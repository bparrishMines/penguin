//#include <android/log.h>
//#define LOG(message) __android_log_write(ANDROID_LOG_DEBUG, "reference", message)

//#include <string>
//#include <unordered_map>

#include "include/dart_api_dl.h"
#include "hashmap.h"

// TODO: Find out how to instantiate a new one for each NativeWeakMap or maybe use hashmap.h?
//static std::unordered_map<std::string, Dart_WeakPersistentHandle> instanceMap;

struct _finalizer_data {
  char* instanceId;
  Dart_Port onFinalizePort;
};

struct NativeWeakMap {
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

static hashmap_s instanceMap;

DART_EXPORT NativeWeakMap create_weak_map(Dart_Port onFinalizePort) {
  NativeWeakMap map;
  map.onFinalizePort = onFinalizePort;
  
  const unsigned initial_size = 2;
  //struct hashmap_s hashmap;
  hashmap_create(initial_size, &instanceMap);
  
  map.instanceMap = &instanceMap;
  return map;
}

//std::unordered_map<std::string, Dart_WeakPersistentHandle> toMap(void *ptr) {
//  std::unordered_map<std::string, Dart_WeakPersistentHandle> *map =
//    static_cast<std::unordered_map<std::string, Dart_WeakPersistentHandle> *>(ptr);
//  return *map;
//}

hashmap_s* toMap(void *ptr) {
  return (hashmap_s *)ptr;
}

DART_EXPORT int put(NativeWeakMap weakMap, char *instanceId, Dart_Handle instance) {
  _finalizer_data* peer = (_finalizer_data *) malloc(sizeof(_finalizer_data));
  peer->instanceId = instanceId;
  peer->onFinalizePort = weakMap.onFinalizePort;

  intptr_t size = 4096;
  Dart_WeakPersistentHandle weakHandle = Dart_NewWeakPersistentHandle_DL(instance, (void *)peer, size, &finalizer_callback);
  if (weakHandle == NULL) return 0;

  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  hashmap_put(instanceMap, instanceId, strlen(instanceId), (void *)weakHandle);
  //instanceMap[std::string(instanceId)] = weakHandle;
  return 1;
}

DART_EXPORT int contains(NativeWeakMap weakMap, char *instanceId) {
  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  void* const element = hashmap_get(instanceMap, instanceId, strlen(instanceId));
  if (NULL == element) return 0;
  return 1;
}

DART_EXPORT Dart_Handle get(NativeWeakMap weakMap, char *instanceId) {
  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  //std::string strInstanceId = std::string(instanceId);
  return (Dart_Handle) hashmap_get(instanceMap, instanceId, strlen(instanceId));
  //return Dart_HandleFromWeakPersistent_DL(instanceMap[strInstanceId]);
}

DART_EXPORT void remove_key(NativeWeakMap weakMap, char *instanceId) {
  hashmap_s *instanceMap = toMap(weakMap.instanceMap);
  hashmap_remove(instanceMap, instanceId, strlen(instanceId));
  //toMap(weakMap.instanceMap).erase(std::string(instanceId));
}

/*
DART_EXPORT void register_dart_receive_port(Dart_Port port) {
  dart_send_port = port;
}

DART_EXPORT void reference_dart_dl_initialize(void* initialize_api_dl_data) {
  if (Dart_InitializeApiDL(initialize_api_dl_data) != 0) {
     LOG("Unable to initialize reference library.");
  } else {
     LOG("Initialized library for Dart thread.");
  }
}

void release_dart_handle(std::string instanceId) {
  Dart_CObject dartInstanceId;
  dartInstanceId.type = Dart_CObject_kString;

  char* cstr = new char[instanceId.length()+1];
  std::strcpy(cstr, instanceId.c_str());
  dartInstanceId.value.as_string = cstr;

  Dart_PostCObject_DL(dart_send_port, &dartInstanceId);

  delete[] cstr;
}

void dart_finalizer(void* isolate_callback_data,
                    void* peer) {
  std::string instanceId = std::string((char*)peer);
  instanceId_to_weak_dart_handle.erase(instanceId);
  release_platform_object(instanceId);
}

DART_EXPORT void dart_add_weak_reference(Dart_Handle instance, char *instanceId) {
  intptr_t size = 4096;
  Dart_WeakPersistentHandle weakHandle = Dart_NewWeakPersistentHandle_DL(instance, (void*)instanceId, size, &dart_finalizer);
  if (weakHandle == NULL) {
    LOG("Invalid parameters were passed to Dart_NewWeakPersistentHandle_DL.");
  } else {
    instanceId_to_weak_dart_handle[std::string(instanceId)] = weakHandle;
  }
}

DART_EXPORT int dart_contains_weak_handle_instanceId(char *instanceId) {
  std::string strInstanceId = std::string(instanceId);
  if (instanceId_to_weak_dart_handle.count(strInstanceId)) {
    return 1;
  }

  return 0;
}

DART_EXPORT Dart_Handle dart_get_weak_handle(char *instanceId) {
  std::string strInstanceId = std::string(instanceId);
  if (instanceId_to_weak_dart_handle.count(strInstanceId)) {
    return Dart_HandleFromWeakPersistent_DL(instanceId_to_weak_dart_handle[strInstanceId]);
  }

  Dart_Handle error = Dart_NewApiError_DL("Could not find Dart_Handle.");
  Dart_PropagateError_DL(error);

  // unreachable
  abort();
}
*/

/*
#ifdef __ANDROID__
std::string jstring_to_string(JNIEnv *env, jstring jStr) {
  if (!jStr) return "";

  const jclass stringClass = env->GetObjectClass(jStr);
  const jmethodID getBytes = env->GetMethodID(stringClass, "getBytes", "(Ljava/lang/String;)[B");
  const jbyteArray stringJbytes = (jbyteArray) env->CallObjectMethod(jStr, getBytes, env->NewStringUTF("UTF-8"));

  size_t length = (size_t) env->GetArrayLength(stringJbytes);
  jbyte* pBytes = env->GetByteArrayElements(stringJbytes, NULL);

  std::string ret = std::string((char *)pBytes, length);
  env->ReleaseByteArrayElements(stringJbytes, pBytes, JNI_ABORT);

  env->DeleteLocalRef(stringJbytes);
  env->DeleteLocalRef(stringClass);
  return ret;
}

extern "C"
JNIEXPORT void JNICALL
Java_github_penguin_reference_reference_InstancePairManager_nativeReleaseDartHandle(
    JNIEnv *env, jobject object, jstring instanceId) {
  release_dart_handle(jstring_to_string(env, instanceId));
}

extern "C"
JNIEXPORT void JNICALL
Java_github_penguin_reference_reference_InstancePairManager_initializeLib(
    JNIEnv *env, jobject object) {
  env->GetJavaVM(&jvm);
  java_instance_pair_manager = env->NewWeakGlobalRef(object);
  jclass classObject = env->GetObjectClass(java_instance_pair_manager);
  java_remove_pair_id = env->GetMethodID(classObject, "removePair", "(Ljava/lang/String;)V");
}
#endif
*/
