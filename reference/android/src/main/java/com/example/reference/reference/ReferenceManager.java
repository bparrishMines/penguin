package com.example.reference.reference;

import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public abstract class ReferenceManager {
  public interface ReferenceHolder {}

  public interface LocalReferenceHandler {
    ReferenceHolder createLocalReference(final String referenceId, final Object arguments);

    CompletableRunnable<?> receiveLocalMethodCall(
        final ReferenceHolder holder, final String methodName, final Object[] arguments);
  }

  public interface RemoteReferenceHandler {
    void createRemoteReference(final String referenceId, final ReferenceHolder holder);

    void disposeRemoteReference(final String referenceId, final ReferenceHolder holder);

    <T> CompletableRunnable<T> sendRemoteMethodCall(
        final Reference reference, final String methodName, final Object[] arguments);
  }

  private final BiMap<ReferenceHolder, String> holderToReferenceId = HashBiMap.create();
  private final Map<String, ReferenceCounter> referenceIdToReferenceCounter = new HashMap<>();

  public abstract LocalReferenceHandler getLocalReferenceHandler();

  public abstract RemoteReferenceHandler getRemoteReferenceHandler();

  public abstract void initialize();

  public void createAndAddLocalReference(final String referenceId, final Object arguments) {
    final ReferenceHolder holder =
        getLocalReferenceHandler().createLocalReference(referenceId, arguments);
    holderToReferenceId.put(holder, referenceId);
  }

  public void disposeLocalReference(final String referenceId) {
    holderToReferenceId.inverse().remove(referenceId);
  }

  public String referenceIdFor(final ReferenceHolder holder) {
    return holderToReferenceId.get(holder);
  }

  public ReferenceHolder referenceHolderFor(final String referenceId) {
    return holderToReferenceId.inverse().get(referenceId);
  }

  public void retain(final ReferenceHolder holder) {
    String referenceId = holderToReferenceId.get(holder);
    if (referenceId == null) {
      add(holder);
      referenceId = referenceIdFor(holder);
    }
    referenceIdToReferenceCounter.get(referenceId).retain(referenceId, holder);
  }

  public <T> CompletableRunnable<T> sendMethodCall(
      final ReferenceHolder holder, final String methodName, final Object[] arguments) {
    for (int i = 0; i < arguments.length; i++) {
      final Object argument = arguments[i];
      if (!(argument instanceof ReferenceHolder)) continue;

      final String referenceId = referenceIdFor((ReferenceHolder) argument);
      if (referenceId != null) arguments[i] = new Reference(referenceId);
    }

    return getRemoteReferenceHandler()
        .sendRemoteMethodCall(new Reference(referenceIdFor(holder)), methodName, arguments);
  }

  public CompletableRunnable<?> receiveMethodCall(
      final Reference reference, final String methodName, final Object[] arguments) {
    for (int i = 0; i < arguments.length; i++) {
      final Object argument = arguments[i];
      if (argument instanceof Reference) {
        arguments[i] = referenceHolderFor(((Reference) argument).referenceId);
      }
    }

    return getLocalReferenceHandler()
        .receiveLocalMethodCall(referenceHolderFor(reference.referenceId), methodName, arguments);
  }

  public void release(ReferenceHolder holder) {
    final String referenceId = referenceIdFor(holder);
    if (referenceId != null) {
      referenceIdToReferenceCounter.get(referenceId).release(referenceId, holder);
    }
  }

  private void add(ReferenceHolder holder) {
    final String referenceId = UUID.randomUUID().toString();
    holderToReferenceId.put(holder, referenceId);
    referenceIdToReferenceCounter.put(
        referenceId,
        new ReferenceCounter(
            new ReferenceCounter.LifecycleListener() {
              @Override
              public void onCreate(String referenceId, ReferenceHolder holder) {
                getRemoteReferenceHandler().createRemoteReference(referenceId, holder);
              }

              @Override
              public void onDispose(String referenceId, ReferenceHolder holder) {
                getRemoteReferenceHandler().disposeRemoteReference(referenceId, holder);
                remove(holder);
              }
            }));
  }

  private void remove(ReferenceHolder holder) {
    final String referenceId = holderToReferenceId.remove(holder);
    referenceIdToReferenceCounter.remove(referenceId);
  }
}
