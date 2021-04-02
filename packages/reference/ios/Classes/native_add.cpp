#include <stdint.h>
#include <stdio.h>
#include <android/log.h>
#include <jni.h>
#include <string>
#include <unordered_map>
#include "include/dart_api_dl.h"

#ifndef FINALIZER_H
#define FINALIZER_H

static Dart_Port dart_send_port;
static std::unordered_map<std::string, Dart_Handle> instanceId_to_dart_handle;
static std::unordered_map<std::string, Dart_WeakPersistentHandle> instanceId_to_weak_dart_handle;

static JavaVM *jvm;
static jobject java_instance_pair_manager;
static jmethodID java_remove_pair_id;
static std::unordered_map<std::string, jobject> instanceId_to_jobject;

extern "C" void dart_remove_pair(char* instanceId) {
  __android_log_write(ANDROID_LOG_INFO, "Tag", "dart_remove_pair start");
  std::string strInstanceId = std::string(instanceId);
  Dart_Handle handle = instanceId_to_dart_handle[strInstanceId];
  instanceId_to_dart_handle.erase(strInstanceId);
  Dart_DeletePersistentHandle_DL(handle);
  __android_log_write(ANDROID_LOG_INFO, "Tag", "dart_remove_pair end");
}

extern "C" void register_dart_receive_port(Dart_Port port) {
  dart_send_port = port;
}

extern "C" void reference_dart_dl_initialize(void* initialize_api_dl_data) {
  if (Dart_InitializeApiDL(initialize_api_dl_data) != 0) {
     __android_log_write(ANDROID_LOG_INFO, "Tag", "CANT INITIALIZE");
  }
}

void release_jobject(std::string instanceId) {
  JNIEnv* env;
  jint result = jvm->GetEnv((void**)&env, JNI_VERSION_1_6);
  if (result == JNI_EDETACHED) {
      __android_log_print(ANDROID_LOG_INFO, "Tag", "Removing Java instance with id: %s", instanceId.c_str());
      result = jvm->AttachCurrentThread(&env, NULL);

      env->CallVoidMethod(java_instance_pair_manager, java_remove_pair_id, env->NewStringUTF(instanceId.c_str()));

      jvm->DetachCurrentThread();
  } else if (result != JNI_OK) {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "Failed to get JNIEnv when releasing jobject.");
  }
}

void dart_finalizer(void* isolate_callback_data,
                    void* peer) {
  std::string instanceId = std::string((char*)peer);
  __android_log_print(ANDROID_LOG_INFO, "Tag", "Removing Dart instance with id: %s", instanceId.c_str());

  instanceId_to_weak_dart_handle.erase(instanceId);
  release_jobject(instanceId);
}

Dart_WeakPersistentHandle dart_attach_finalizer(Dart_Handle instance, char *instanceId) {
  if (Dart_NewWeakPersistentHandle_DL == NULL) {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "Finalizer could not be attached.");
  }

  intptr_t size = 4096;
  return Dart_NewWeakPersistentHandle_DL(instance, (void*)instanceId, size, &dart_finalizer);
}

extern "C" void dart_add_pair(char *instanceId, Dart_Handle instance, int owner) {
  if (owner) {
  __android_log_write(ANDROID_LOG_INFO, "Tag", "Creating finalizer");
    Dart_WeakPersistentHandle handle = dart_attach_finalizer(instance, instanceId);
    instanceId_to_weak_dart_handle[std::string(instanceId)] = handle;
  } else {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "create weak finilizer");
    Dart_Handle handle = Dart_NewPersistentHandle_DL(instance);
    instanceId_to_dart_handle[std::string(instanceId)] = handle;
  }
}

extern "C" int dart_contains_instanceId(char *instanceId) {
  std::string strInstanceId = std::string(instanceId);
  if (instanceId_to_dart_handle.count(strInstanceId) || instanceId_to_weak_dart_handle.count(strInstanceId)) {
    return 1;
  }

  return 0;
}

extern "C" Dart_Handle dart_get_object(char *instanceId) {
  std::string strInstanceId = std::string(instanceId);
  if (instanceId_to_dart_handle.count(strInstanceId)) {
    return instanceId_to_dart_handle[strInstanceId];
  } else if (instanceId_to_weak_dart_handle.count(strInstanceId)) {
    return Dart_HandleFromWeakPersistent_DL(instanceId_to_weak_dart_handle[strInstanceId]);
  }

  Dart_Handle error = Dart_NewApiError_DL("Could not find Dart_Handle.");
  Dart_PropagateError_DL(error);

  return NULL;
}

std::string jstring2string(JNIEnv *env, jstring jStr) {
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

extern "C" JNIEXPORT void JNICALL Java_github_penguin_reference_reference_InstancePairManager_nativeAddPair(JNIEnv *env,
 jobject object, jobject instance, jstring instanceId, jboolean owner) {
  jobject ref;
  if (owner) {
    ref = env->NewWeakGlobalRef(instance);
  } else {
    ref = env->NewGlobalRef(instance);
  }

  std::string strInstanceId = jstring2string(env, instanceId);
  instanceId_to_jobject[strInstanceId] = ref;
}

extern "C"
JNIEXPORT void JNICALL
Java_github_penguin_reference_reference_InstancePairManager_nativeReleaseDartHandle(JNIEnv *env, jobject object, jstring instanceId) {
  std::string strInstanceId = jstring2string(env, instanceId);

  jobject instance = instanceId_to_jobject[strInstanceId];
  instanceId_to_jobject.erase(strInstanceId);
  env->DeleteWeakGlobalRef(instance);

  Dart_CObject dartInstanceId;
  dartInstanceId.type = Dart_CObject_kString;

  char* cstr = new char[strInstanceId.length()+1];
  std::strcpy(cstr, strInstanceId.c_str());
  dartInstanceId.value.as_string = cstr;

  Dart_PostCObject_DL(dart_send_port, &dartInstanceId);

  delete[] cstr;
}

extern "C"
JNIEXPORT jobject JNICALL
Java_github_penguin_reference_reference_InstancePairManager_getInstance(JNIEnv *env, jobject object, jstring instanceId) {
  std::string strInstanceId = jstring2string(env, instanceId);
  if (!instanceId_to_jobject.count(strInstanceId)) return NULL;
  return instanceId_to_jobject[strInstanceId];
}

extern "C"
JNIEXPORT void JNICALL
Java_github_penguin_reference_reference_InstancePairManager_initializeReferenceLib(JNIEnv *env, jobject object) {
  __android_log_write(ANDROID_LOG_INFO, "Tag", "start init");
  env->GetJavaVM(&jvm);
  java_instance_pair_manager = env->NewWeakGlobalRef(object);
  jclass classObject = env->GetObjectClass(java_instance_pair_manager);
  java_remove_pair_id = env->GetMethodID(classObject, "removePair", "(Ljava/lang/String;)V");
  __android_log_write(ANDROID_LOG_INFO, "Tag", "end init");
}

extern "C"
JNIEXPORT void JNICALL
Java_github_penguin_reference_reference_InstancePairManager_nativeRemovePair(JNIEnv *env, jobject object, jstring instanceId) {
  __android_log_write(ANDROID_LOG_INFO, "Tag", "nativeRemvoePare start");
  std::string strInstanceId = jstring2string(env, instanceId);
  jobject instance = instanceId_to_jobject[strInstanceId];
  instanceId_to_jobject.erase(strInstanceId);
  env->DeleteGlobalRef(instance);
  __android_log_write(ANDROID_LOG_INFO, "Tag", "nativeRemvoePare end");
}
#endif  // FINALIZER_H
