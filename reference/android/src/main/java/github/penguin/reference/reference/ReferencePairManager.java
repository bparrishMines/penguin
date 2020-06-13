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
  final BiMap<Integer, Class<? extends LocalReference>> classIds = HashBiMap.create();

  public final List<Class<? extends LocalReference>> supportedClasses;

  public interface RemoteReferenceCommunicationHandler {
    List<Object> getCreationArguments(LocalReference localReference);

    CompletableRunnable<Void> create(RemoteReference remoteReference, int classId, List<Object> arguments);

    CompletableRunnable<Object> invokeMethod(
        RemoteReference remoteReference, String methodName, List<Object> arguments);

    CompletableRunnable<Void> dispose(RemoteReference remoteReference);
  }

  public interface LocalReferenceCommunicationHandler {
    LocalReference create(
        ReferencePairManager referencePairManager,
        Class<? extends LocalReference> referenceClass,
        List<Object> arguments)
        throws Exception;

    Object invokeMethod(
        ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) throws Exception;

    void dispose(ReferencePairManager referencePairManager, LocalReference localReference) throws Exception;
  }

  protected ReferencePairManager(final List<Class<? extends LocalReference>> supportedClasses) {
    this.supportedClasses = Collections.unmodifiableList(supportedClasses);
    for (int i = 0; i < supportedClasses.size(); i++) classIds.put(i, this.supportedClasses.get(i));
  }

  public abstract RemoteReferenceCommunicationHandler getRemoteHandler();

  public abstract LocalReferenceCommunicationHandler getLocalHandler();

  @CallSuper
  public void initialize() {
    isInitialized = true;
  }

  public RemoteReference getPairedRemoteReference(LocalReference localReference) {
    assertIsInitialized();
    return referencePairs.get(localReference);
  }

  public LocalReference getPairedLocalReference(RemoteReference remoteReference) {
    assertIsInitialized();
    return referencePairs.inverse().get(remoteReference);
  }

  public LocalReference pairWithNewLocalReference(
      RemoteReference remoteReference, int classId) throws Exception {
    return pairWithNewLocalReference(remoteReference, classId, new ArrayList<>());
  }

  public LocalReference pairWithNewLocalReference(
      RemoteReference remoteReference, int classId, List<Object> arguments)
      throws Exception {
    assertIsInitialized();
    final LocalReference localReference =
        getLocalHandler()
            .create(
                this, classIds.get(classId), (List<Object>) replaceRemoteReferences(arguments));
    referencePairs.put(localReference, remoteReference);
    return localReference;
  }

  public void disposePairWithRemoteReference(RemoteReference remoteReference) throws Exception {
    assertIsInitialized();

    final LocalReference localReference = getPairedLocalReference(remoteReference);
    if (localReference == null) return;

    referencePairs.remove(localReference);
    getLocalHandler().dispose(this, localReference);
  }

  public CompletableRunnable<RemoteReference> pairWithNewRemoteReference(final LocalReference localReference) {
    assertIsInitialized();
    if (getPairedRemoteReference(localReference) != null) return null;

    final RemoteReference remoteReference = new RemoteReference(UUID.randomUUID().toString());
    referencePairs.put(localReference, remoteReference);

    final List<Object> creationArguments = getRemoteHandler().getCreationArguments(localReference);
    final CompletableRunnable<Void> resultRunnable =
        getRemoteHandler()
            .create(
                remoteReference,
                classIds.inverse().get(localReference.getReferenceClass()),
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
  public CompletableRunnable<Void> disposePairWithLocalReference(LocalReference localReference) {
    assertIsInitialized();

    final RemoteReference remoteReference = getPairedRemoteReference(localReference);
    if (remoteReference == null) return null;

    referencePairs.remove(localReference);
    return getRemoteHandler().dispose(remoteReference);
  }

  public CompletableRunnable<Object> invokeRemoteMethod(
      RemoteReference remoteReference, String methodName) {
    return invokeRemoteMethod(remoteReference, methodName, new ArrayList<>());
  }

  // TODO: handle setting object type
  public CompletableRunnable<Object> invokeRemoteMethod(
      RemoteReference remoteReference, String methodName, List<Object> arguments) {
    assertIsInitialized();

    final CompletableRunnable<Object> resultRunnable =
        getRemoteHandler()
            .invokeMethod(
                remoteReference,
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

  public Object invokeLocalMethod(LocalReference localReference, String methodName)
      throws Exception {
    return invokeLocalMethod(localReference, methodName, new ArrayList<>());
  }

  public Object invokeLocalMethod(
      LocalReference localReference, String methodName, List<Object> arguments) throws Exception {
    assertIsInitialized();

    final Object result =
        getLocalHandler()
            .invokeMethod(
                this,
                localReference,
                methodName,
                (List<Object>) replaceRemoteReferences(arguments));

    return replaceLocalReferences(result);
  }

  private void assertIsInitialized() {
    if (!isInitialized) throw new AssertionError("Initialize has not been called.");
  }

  @SuppressWarnings("rawtypes")
  Object replaceRemoteReferences(Object argument) throws Exception {
    if (argument instanceof RemoteReference) {
      return getPairedLocalReference((RemoteReference) argument);
    } else if (argument instanceof UnpairedRemoteReference) {
      return getLocalHandler()
          .create(
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
  Object replaceLocalReferences(Object argument) {
    if (argument instanceof LocalReference
        && getPairedRemoteReference((LocalReference) argument) != null) {
      return getPairedRemoteReference((LocalReference) argument);
    } else if (argument instanceof LocalReference
        && getPairedRemoteReference((LocalReference) argument) == null) {
      return new UnpairedRemoteReference(
          classIds.inverse().get(((LocalReference) argument).getReferenceClass()),
          (List<Object>)
              replaceLocalReferences(
                  getRemoteHandler().getCreationArguments((LocalReference) argument)));
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
