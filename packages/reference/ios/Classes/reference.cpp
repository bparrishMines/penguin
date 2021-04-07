#ifdef __ANDROID__
#include <android/log.h>
#include <jni.h>
#elif __APPLE__
//#import <REFCollections_Internal.h>
#endif

#include <string>
#include <unordered_map>

#include "include/dart_api_dl.h"

#ifdef __ANDROID__
#define LOG(message) __android_log_write(ANDROID_LOG_DEBUG, "reference", message)
#elif __APPLE__
#define LOG(message) referenceLog(message);
#endif

#ifdef __ANDROID__
static JavaVM *jvm;
static jobject java_instance_pair_manager;
static jmethodID java_remove_pair_id;
#endif

static Dart_Port dart_send_port;
static std::unordered_map<std::string, Dart_WeakPersistentHandle> instanceId_to_weak_dart_handle;

#ifdef __ANDROID__
void release_platform_object(std::string instanceId) {
  JNIEnv* env;
  jint result = jvm->GetEnv((void**)&env, JNI_VERSION_1_6);
  if (result == JNI_EDETACHED) {
    result = jvm->AttachCurrentThread(&env, NULL);
    if (result != JNI_OK) {
      LOG("Failed to attach thread to jvm.");
    } else {
      env->CallVoidMethod(java_instance_pair_manager, java_remove_pair_id, env->NewStringUTF(instanceId.c_str()));
      jvm->DetachCurrentThread();
    }
  } else {
    LOG("Failed to get JNIEnv to release jobject.");
  }
}
#elif __APPLE__
void release_platform_object(std::string instanceId) {
  //removePair(instanceId.c_str());
}
#endif

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
