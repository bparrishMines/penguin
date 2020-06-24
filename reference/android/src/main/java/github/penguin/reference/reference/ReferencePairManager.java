package github.penguin.reference.reference;

import androidx.annotation.CallSuper;
import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

@SuppressWarnings({"unchecked", "WeakerAccess", "unused"})
public abstract class ReferencePairManager {
  private boolean isInitialized = false;
  private final BiMap<LocalReference, RemoteReference> referencePairs = HashBiMap.create();
  final BiMap<Integer, Class<? extends LocalReference>> classIds = HashBiMap.create();

  public final List<Class<? extends LocalReference>> supportedClasses;

  public interface RemoteReferenceCommunicationHandler {
    List<Object> getCreationArguments(LocalReference localReference);

    Completable<Void> create(RemoteReference remoteReference, int classId, List<Object> arguments);

    Completable<Object> invokeMethod(RemoteReference remoteReference, String methodName, List<Object> arguments);

    Completable<Object> invokeMethodOnUnpairedReference(
        UnpairedReference unpairedReference,
        String methodName,
        List<Object> arguments
    );

    Completable<Void> dispose(RemoteReference remoteReference);
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

  public ReferenceConverter getConverter() {
    return new ReferenceConverter.StandardReferenceConverter();
  }

  @CallSuper
  public void initialize() {
    isInitialized = true;
  }

  public Integer getClassId(Class<? extends LocalReference> referenceClass) {
    return classIds.inverse().get(referenceClass);
  }

  public Class<? extends LocalReference> getReferenceClass(int typeId) {
    return classIds.get(typeId);
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
    return pairWithNewLocalReference(remoteReference, classId, Collections.emptyList());
  }

  public LocalReference pairWithNewLocalReference(
      RemoteReference remoteReference, int classId, List<Object> arguments)
      throws Exception {
    assertIsInitialized();
    final LocalReference localReference =
        getLocalHandler()
            .create(
                this, classIds.get(classId),
                (List<Object>) getConverter().convertReferencesForLocalManager(this, arguments));
    referencePairs.put(localReference, remoteReference);
    return localReference;
  }

  public <T> T invokeLocalMethod(LocalReference localReference, String methodName)
      throws Exception {
    return (T) invokeLocalMethod(localReference, methodName, new ArrayList<>());
  }

  public <T> T invokeLocalMethod(
      LocalReference localReference, String methodName, List<Object> arguments) throws Exception {
    assertIsInitialized();
    final Object result =
        getLocalHandler()
            .invokeMethod(
                this,
                localReference,
                methodName,
                (List<Object>) getConverter().convertReferencesForLocalManager(this, arguments));

    return (T) getConverter().convertReferencesForRemoteManager(this, result);
  }

  public <T> T invokeLocalMethodOnUnpairedReference(UnpairedReference unpairedReference, String methodName) throws Exception {
    return (T) invokeLocalMethodOnUnpairedReference(unpairedReference, methodName, Collections.EMPTY_LIST);
  }

  public <T> T invokeLocalMethodOnUnpairedReference(UnpairedReference unpairedReference, String methodName,
                                                    List<Object> arguments) throws Exception {
    assertIsInitialized();
    return invokeLocalMethod(getLocalHandler().create(this,
        classIds.get(unpairedReference.classId),
        (List<Object>) getConverter().convertReferencesForLocalManager(this, unpairedReference.creationArguments)
    ), methodName, arguments);
  }

  public void disposePairWithRemoteReference(RemoteReference remoteReference) throws Exception {
    assertIsInitialized();

    final LocalReference localReference = getPairedLocalReference(remoteReference);
    if (localReference == null) return;

    referencePairs.remove(localReference);
    getLocalHandler().dispose(this, localReference);
  }

  @SuppressWarnings("ConstantConditions")
  public Completable<RemoteReference> pairWithNewRemoteReference(final LocalReference localReference) {
    assertIsInitialized();
    if (getPairedRemoteReference(localReference) != null) return null;

    final RemoteReference remoteReference = new RemoteReference(UUID.randomUUID().toString());
    referencePairs.put(localReference, remoteReference);

    final List<Object> creationArguments = getRemoteHandler().getCreationArguments(localReference);
    final Completable<Void> resultRunnable =
        getRemoteHandler()
            .create(
                remoteReference,
                classIds.inverse().get(localReference.getReferenceClass()),
                (List<Object>) getConverter().convertReferencesForRemoteManager(this, creationArguments));

    final Completer<RemoteReference> completer = new Completer<>();

    resultRunnable.setOnCompleteListener(new Completable.OnCompleteListener<Void>() {
      @Override
      public void onComplete(Void result) {
        completer.complete(remoteReference);
      }

      @Override
      public void onError(Throwable throwable) {
        completer.completeWithError(throwable);
      }
    });

    return completer.completable;
  }

  public <T> Completable<T> invokeRemoteMethod(
      RemoteReference remoteReference, String methodName) {
    return invokeRemoteMethod(remoteReference, methodName, Collections.EMPTY_LIST);
  }

  public <T> Completable<T> invokeRemoteMethod(
      RemoteReference remoteReference, String methodName, List<Object> arguments) {
    assertIsInitialized();

    final Completable<Object> resultCompletable = getRemoteHandler()
            .invokeMethod(
                remoteReference,
                methodName,
                (List<Object>) getConverter().convertReferencesForRemoteManager(this, arguments));

    final Completer<T> replaceCompleter = new Completer<>();

    resultCompletable.setOnCompleteListener(new Completable.OnCompleteListener<Object>() {
      @Override
      public void onComplete(Object result) {
        try {
          replaceCompleter.complete((T) getConverter().convertReferencesForLocalManager(ReferencePairManager.this, result));
        } catch(Exception exception) {
          throw new RuntimeException(exception.getMessage());
        }
      }

      @Override
      public void onError(Throwable throwable) {
          replaceCompleter.completeWithError(throwable);
      }
    });

    return replaceCompleter.completable;
  }

  public <T> Completable<T> invokeRemoteMethodOnUnpairedReference(LocalReference localReference,
                                                                 String methodName) {
    return invokeRemoteMethodOnUnpairedReference(localReference, methodName, Collections.EMPTY_LIST);
  }

  @SuppressWarnings("ConstantConditions")
  public <T> Completable<T> invokeRemoteMethodOnUnpairedReference(
      LocalReference localReference,
      String methodName,
      List<Object> arguments
  ) {
    assertIsInitialized();

    final Completable<Object> resultCompletable = getRemoteHandler()
            .invokeMethodOnUnpairedReference(
                new UnpairedReference(
                    classIds.inverse().get(localReference.getReferenceClass()),
                    (List<Object>) getConverter().convertReferencesForRemoteManager(this, getRemoteHandler().getCreationArguments(localReference))
                ),
                methodName,
                (List<Object>) getConverter().convertReferencesForRemoteManager(this, arguments));

    final Completer<T> replaceCompleter = new Completer<>();

    resultCompletable.setOnCompleteListener(new Completable.OnCompleteListener<Object>() {
      @Override
      public void onComplete(Object result) {
        replaceCompleter.complete((T) getConverter().convertReferencesForRemoteManager(ReferencePairManager.this, result));
      }

      @Override
      public void onError(Throwable throwable) {
        replaceCompleter.completeWithError(throwable);
      }
    });

    return replaceCompleter.completable;
  }

  @SuppressWarnings("UnusedReturnValue")
  public Completable<Void> disposePairWithLocalReference(LocalReference localReference) {
    assertIsInitialized();

    final RemoteReference remoteReference = getPairedRemoteReference(localReference);
    if (remoteReference == null) return null;

    referencePairs.remove(localReference);
    return getRemoteHandler().dispose(remoteReference);
  }

  private void assertIsInitialized() {
    if (!isInitialized) throw new AssertionError("Initialize has not been called.");
  }
}
