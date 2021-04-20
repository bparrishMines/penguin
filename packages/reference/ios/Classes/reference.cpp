// For debugging on Android
//#include <android/log.h>
//#define LOG(message) __android_log_write(ANDROID_LOG_DEBUG, "reference", message)

#include "include/dart_api_dl.h"
#include "hashmap.h"

// TODO: Replace by instatiating a new one for each _NativeWeakMap in create_weak_map
static hashmap_s instanceMap;
static bool initialized = false;

struct _finalizer_data {
  char* instanceId;
  Dart_Port onFinalizePort;
};

struct _NativeWeakMap {
  Dart_Port onFinalizePort;
  void* instanceMap;
};

DART_EXPORT int reference_dart_dl_initialize(void* initializeApiDLData) {
  return Dart_InitializeApiDL(initializeApiDLData);
}

void finalizer_callback(void* isolateCallbackData, void* peer) {
  _finalizer_data *data = (_finalizer_data *)peer;

  Dart_CObject dartInstanceId;
  dartInstanceId.type = Dart_CObject_kString;
  dartInstanceId.value.as_string = strdup(data->instanceId);
  Dart_PostCObject_DL(data->onFinalizePort, &dartInstanceId);

  free(data);
}

/// Create a new weak map with the callback port to notify Dart.
DART_EXPORT _NativeWeakMap create_weak_map(Dart_Port onFinalizePort) {
  _NativeWeakMap map;
  map.onFinalizePort = onFinalizePort;

  if (!initialized) {
    const unsigned initial_size = 8;
    hashmap_create(initial_size, &instanceMap);
    initialized = true;
  }
  
  map.instanceMap = &instanceMap;
  return map;
}

/// Cast void pointer to hashmap pointer.
hashmap_s* toMap(void *ptr) {
  return (hashmap_s *)ptr;
}

/// Store the instanceId and Dart_Handle as a key value pair in weakMap.
DART_EXPORT int put(_NativeWeakMap weakMap, char *instanceId, Dart_Handle instance) {
  _finalizer_data* peer = (_finalizer_data *) malloc(sizeof(_finalizer_data));
  peer->instanceId = instanceId;
  peer->onFinalizePort = weakMap.onFinalizePort;

  intptr_t size = 4096;
  Dart_WeakPersistentHandle weakHandle = Dart_NewWeakPersistentHandle_DL(instance, (void *)peer, size, &finalizer_callback);
  if (weakHandle == NULL) return 0;

  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  hashmap_put(instanceMap, instanceId, strlen(instanceId), (void *)weakHandle);
  return 1;
}

/// Whether the weak map contains the key instanceId.
DART_EXPORT int contains(_NativeWeakMap weakMap, char *instanceId) {
  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  void* const element = hashmap_get(instanceMap, instanceId, strlen(instanceId));
  if (NULL == element) return 0;
  return 1;
}

/// Retrive the Dart_Handle value stored under instanceId key.
DART_EXPORT Dart_Handle get(_NativeWeakMap weakMap, char *instanceId) {
  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  return (Dart_Handle) hashmap_get(instanceMap, instanceId, strlen(instanceId));
}

/// Remove instanceId key and the Dart_Handle stored as its value.
DART_EXPORT void remove_key(_NativeWeakMap weakMap, char *instanceId) {
  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  hashmap_remove(instanceMap, instanceId, strlen(instanceId));
}
