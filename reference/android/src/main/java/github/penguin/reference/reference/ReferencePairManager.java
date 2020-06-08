package github.penguin.reference.reference;

import androidx.annotation.CallSuper;
import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@SuppressWarnings({"unchecked", "WeakerAccess", "unused"})
public abstract class ReferencePairManager {
  private boolean isInitialized = false;
  private final BiMap<LocalReference, RemoteReference> referencePairs = HashBiMap.create();
  private final BiMap<Integer, Class<? extends LocalReference>> classIds = HashBiMap.create();

  public final List<Class<? extends LocalReference>> supportedClasses;

  protected ReferencePairManager(final List<Class<? extends LocalReference>> supportedClass) {
    this.supportedClasses = Collections.unmodifiableList(supportedClass);
    for (int i = 0; i < supportedClass.size(); i++) classIds.put(i, supportedClasses.get(i));
  }

  public interface RemoteReferenceCommunicationHandler {
    List<Object> creationArgumentsFor(LocalReference localReference);

    CompletableRunnable<Void> createRemoteReference(
        RemoteReference remoteReference, int classId, List<Object> arguments);

    CompletableRunnable<Object> executeRemoteMethod(
        RemoteReference remoteReference, String methodName, List<Object> arguments);

    CompletableRunnable<Void> disposeRemoteReference(RemoteReference remoteReference);
  }

  public interface LocalReferenceCommunicationHandler {
    LocalReference createLocalReference(
        ReferencePairManager referencePairManager,
        Class<? extends LocalReference> referenceClass,
        List<Object> arguments)
        throws Exception;

    Object executeLocalMethod(
        ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) throws Exception;

    void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) throws Exception;
  }

  public abstract RemoteReferenceCommunicationHandler getRemoteHandler();

  public abstract LocalReferenceCommunicationHandler getLocalHandler();

  @CallSuper
  public void initialize() {
    isInitialized = true;
  }

  public RemoteReference remoteReferenceFor(LocalReference localReference) {
    assertIsInitialized();
    return referencePairs.get(localReference);
  }

  public LocalReference localReferenceFor(RemoteReference remoteReference) {
    assertIsInitialized();
    return referencePairs.inverse().get(remoteReference);
  }

  public LocalReference createLocalReferenceFor(
      RemoteReference remoteReference, int classId) throws Exception {
    return createLocalReferenceFor(remoteReference, classId, new ArrayList<>());
  }

  public LocalReference createLocalReferenceFor(
      RemoteReference remoteReference, int classId, List<Object> arguments)
      throws Exception {
    assertIsInitialized();
    final LocalReference localReference =
        getLocalHandler()
            .createLocalReference(
                this, classIds.get(classId), (List<Object>) replaceRemoteReferences(arguments));
    referencePairs.put(localReference, remoteReference);
    return localReference;
  }

  public void disposeLocalReferenceFor(RemoteReference remoteReference) throws Exception {
    assertIsInitialized();

    final LocalReference localReference = localReferenceFor(remoteReference);
    if (localReference == null) return;

    referencePairs.remove(localReference);
    getLocalHandler().disposeLocalReference(this, localReference);
  }

  @SuppressWarnings("UnusedReturnValue")
  public CompletableRunnable<RemoteReference> createRemoteReferenceFor(
      final LocalReference localReference) {
    return createRemoteReferenceFor(localReference, classIds.inverse().get(localReference.getReferenceClass()));
  }

  public CompletableRunnable<RemoteReference> createRemoteReferenceFor(
      final LocalReference localReference, int classId) {
    assertIsInitialized();
    if (remoteReferenceFor(localReference) != null) return null;

    final RemoteReference remoteReference = new RemoteReference(UUID.randomUUID().toString());
    referencePairs.put(localReference, remoteReference);

    final List<Object> creationArguments = getRemoteHandler().creationArgumentsFor(localReference);
    final CompletableRunnable<Void> resultRunnable =
        getRemoteHandler()
            .createRemoteReference(
                remoteReference,
                classId,
                (List<Object>) replaceLocalReferences(creationArguments));

    final CompletableRunnable<RemoteReference> referenceRunnable =
        new CompletableRunnable<RemoteReference>() {
          @Override
          public void run() {
            resultRunnable.setOnCompleteListener(
                new OnCompleteListener() {
                  @Override
                  public void onComplete(Object result) {
                    complete(remoteReference);
                  }

                  @Override
                  public void onError(Throwable throwable) {
                    throw new RuntimeException(throwable.getLocalizedMessage());
                  }
                });
          }
        };

    referenceRunnable.run();
    return referenceRunnable;
  }

  @SuppressWarnings("UnusedReturnValue")
  public CompletableRunnable<Void> disposeRemoteReferenceFor(LocalReference localReference) {
    assertIsInitialized();

    final RemoteReference remoteReference = remoteReferenceFor(localReference);
    if (remoteReference == null) return null;

    referencePairs.remove(localReference);
    return getRemoteHandler().disposeRemoteReference(remoteReference);
  }

  public CompletableRunnable<Object> executeRemoteMethodFor(
      LocalReference localReference, String methodName) {
    return executeRemoteMethodFor(localReference, methodName, new ArrayList<>());
  }

  // TODO: handle setting object type
  public CompletableRunnable<Object> executeRemoteMethodFor(
      LocalReference localReference, String methodName, List<Object> arguments) {
    assertIsInitialized();
    if (remoteReferenceFor(localReference) == null) throw new AssertionError();

    final CompletableRunnable<Object> resultRunnable =
        getRemoteHandler()
            .executeRemoteMethod(
                remoteReferenceFor(localReference),
                methodName,
                (List<Object>) replaceLocalReferences(arguments));

    final CompletableRunnable<Object> replaceRunnable =
        new CompletableRunnable<Object>() {
          @Override
          public void run() {
            resultRunnable.setOnCompleteListener(
                new OnCompleteListener() {
                  @Override
                  public void onComplete(Object result) {
                    try {
                      complete(replaceRemoteReferences(result));
                    } catch (Exception exception) {
                      completeWithError(exception);
                    }
                  }

                  @Override
                  public void onError(Throwable throwable) {
                    throw new RuntimeException(throwable.getLocalizedMessage());
                  }
                });
          }
        };

    replaceRunnable.run();
    return replaceRunnable;
  }

  public Object executeLocalMethodFor(RemoteReference remoteReference, String methodName)
      throws Exception {
    return executeLocalMethodFor(remoteReference, methodName, new ArrayList<>());
  }

  public Object executeLocalMethodFor(
      RemoteReference remoteReference, String methodName, List<Object> arguments) throws Exception {
    assertIsInitialized();
    if (localReferenceFor(remoteReference) == null) throw new AssertionError();

    final Object result =
        getLocalHandler()
            .executeLocalMethod(
                this,
                localReferenceFor(remoteReference),
                methodName,
                (List<Object>) replaceRemoteReferences(arguments));
    return replaceLocalReferences(result);
  }

  private void assertIsInitialized() {
    if (!isInitialized) throw new AssertionError("Initialize has not been called.");
  }

  @SuppressWarnings("rawtypes")
  private Object replaceRemoteReferences(Object argument) throws Exception {
    if (argument instanceof RemoteReference) {
      return localReferenceFor((RemoteReference) argument);
    } else if (argument instanceof UnpairedRemoteReference) {
      return getLocalHandler()
          .createLocalReference(
              this,
              classIds.get(((UnpairedRemoteReference) argument).classId),
              (List<Object>)
                  replaceRemoteReferences(((UnpairedRemoteReference) argument).creationArguments));
    } else if (argument instanceof List) {
      final List<Object> result = new ArrayList<>();
      for (final Object obj : (List) argument) {
        result.add(replaceRemoteReferences(obj));
      }
      return result;
    } else if (argument instanceof Map) {
      final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) argument);
      final Map<Object, Object> newMap = new HashMap<>();
      for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
        newMap.put(
            replaceRemoteReferences(entry.getKey()), replaceRemoteReferences(entry.getValue()));
      }
      return newMap;
    }

    return argument;
  }

  @SuppressWarnings("rawtypes")
  private Object replaceLocalReferences(Object argument) {
    if (argument instanceof LocalReference
        && remoteReferenceFor((LocalReference) argument) != null) {
      return remoteReferenceFor((LocalReference) argument);
    } else if (argument instanceof LocalReference
        && remoteReferenceFor((LocalReference) argument) == null) {
      return new UnpairedRemoteReference(
          classIds.inverse().get(((LocalReference) argument).getReferenceClass()),
          (List<Object>)
              replaceLocalReferences(
                  getRemoteHandler().creationArgumentsFor((LocalReference) argument)));
    } else if (argument instanceof List) {
      final List<Object> result = new ArrayList<>();
      for (final Object obj : (List) argument) {
        result.add(replaceLocalReferences(obj));
      }
      return result;
    } else if (argument instanceof Map) {
      final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) argument);
      final Map<Object, Object> newMap = new HashMap<>();
      for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
        newMap.put(
            replaceLocalReferences(entry.getKey()), replaceLocalReferences(entry.getValue()));
      }
      return newMap;
    }

    return argument;
  }
}
