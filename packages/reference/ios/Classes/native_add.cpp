#include <stdint.h>
#include <stdio.h>
#include <android/log.h>
#include <jni.h>
#include <map>
#include <string>
#include <unordered_map>
#include <any>

#include "include/dart_api.h"
//#include "include/dart_native_api.h"

#include "include/dart_api_dl.h"

#ifndef FINALIZER_H
#define FINALIZER_H

static Dart_Handle aDartHandle;
static int count = 0;

typedef void (*reference_finalizer)(void*);

typedef struct _finalizable_pointer {
  void* pointer;
  reference_finalizer finalizer;
} _finalizable_pointer;

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "Error here");
    printf("HIIIIIIIII.\n");
    return x + y;
}

static void RunFinalizer(void* isolate_callback_data,
                         void* peer) {
  __android_log_write(ANDROID_LOG_INFO, "Tag", "RunFinalizer");
  aDartHandle = NULL;
}

extern "C" void reference_dart_dl_initialize(void* initialize_api_dl_data) {
  if (Dart_InitializeApiDL(initialize_api_dl_data) != 0) {
     __android_log_write(ANDROID_LOG_INFO, "Tag", "CANT INITIALIZE");
  }
}

extern "C" void PassObjectToC(Dart_Handle object/*,
                              reference_finalizer finalizer*/) {
  if (Dart_NewFinalizableHandle_DL == NULL) {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "NADA");
  }

  __android_log_print(ANDROID_LOG_INFO, "Tag", "aDartHandle: %d\n", aDartHandle == NULL);
  aDartHandle = object;

  void *peer = 0x0;
  intptr_t size = 10000;

  __android_log_print(ANDROID_LOG_INFO, "Tag", "object %d\n", object == NULL);
  __android_log_print(ANDROID_LOG_INFO, "Tag", "count %d\n", count);
  auto finalizable_handle = Dart_NewFinalizableHandle_DL(object, peer, size, &RunFinalizer);
}

static JavaVM *jvm;
static jobject myApple;

extern "C"
JNIEXPORT jstring JNICALL
Java_github_penguin_reference_ReferencePlugin_getMsgFromJni(JNIEnv *env, jobject instance, jobject apple) {
// Put your code here
 count++;
 env->GetJavaVM(&jvm);
 myApple = reinterpret_cast<jobject>(env->NewGlobalRef(apple));
 return env->NewStringUTF("Hello From JNI");
}

/*
void GetJniEnv(JavaVM *vm, JNIEnv **env) {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "GetJniEnv");
    JNIEnv **env;
    JavaVM *vm;
    bool did_attach_thread = false;
    *env = nullptr;
    // Check if the current thread is attached to the VM
    auto get_env_result = vm->GetEnv((void**)env, JNI_VERSION_1_6);
    if (get_env_result == JNI_EDETACHED) {
        if (vm->AttachCurrentThread(env, NULL) == JNI_OK) {
            did_attach_thread = true;
            __android_log_write(ANDROID_LOG_INFO, "Tag", "attach_thread");
        } else {
            // Failed to attach thread. Throw an exception if you want to.
            __android_log_write(ANDROID_LOG_INFO, "Tag", "fail to attach");
        }
    } else if (get_env_result == JNI_EVERSION) {
        // Unsupported JNI version. Throw an exception if you want to.
        __android_log_write(ANDROID_LOG_INFO, "Tag", "unsupported");
    }
    //return did_attach_thread;
    __android_log_write(ANDROID_LOG_INFO, "Tag", "end");
}
*/

extern "C" void dart_send_create_new_instance_pair(char *channelName, Dart_Handle object) {
  __android_log_write(ANDROID_LOG_INFO, "Tag", channelName);

  JNIEnv* env;
  jint result = jvm->GetEnv((void**)&env, JNI_VERSION_1_6);
  if (result == JNI_EDETACHED) {
      result = jvm->AttachCurrentThread(&env, NULL);
      __android_log_write(ANDROID_LOG_INFO, "Tag", "attached");
      jclass clsObj = env->GetObjectClass(myApple);
      jmethodID mID = env->GetMethodID(clsObj, "logString", "()V");
      env->CallVoidMethod(myApple, mID);
      jvm->DetachCurrentThread();
  }
  if (result != JNI_OK) {
      fprintf(stderr, "Failed to get JNIEnv\n");
      __android_log_write(ANDROID_LOG_INFO, "Tag", "not attached");
  }
}

//static std::unordered_map<std::string, > instanceId_to_dart_handle;
static std::unordered_map<std::string, Dart_Handle> instanceId_to_dart_handle;
static std::unordered_map<std::string, Dart_WeakPersistentHandle> instanceId_to_weak_dart_handle;

static std::map<std::string, jobject> instanceId_to_jobject;

//static std::map<char *, Dart_Handle, cmp_str> instanceId_to_dart_handle;

void dart_finalizer(void* isolate_callback_data,
                    void* peer) {
  char* instanceId = (char*)peer;
  __android_log_print(ANDROID_LOG_INFO, "Tag", "Removing instance with id: %s", instanceId);

  instanceId_to_weak_dart_handle.erase(instanceId);
}

Dart_WeakPersistentHandle dart_attach_finalizer(Dart_Handle instance, char *instanceId) {
  if (Dart_NewWeakPersistentHandle_DL == NULL) {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "Finalizer could not be attached.");
  }

  intptr_t size = 4096;
  return Dart_NewWeakPersistentHandle_DL(instance, (void*)instanceId, size, &dart_finalizer);
}
/*
extern "C" int dart_is_paired(Dart_Handle instance) {
  return dart_handle_to_instanceId.count(instance);
}
*/
extern "C" void dart_add_pair(char *instanceId, Dart_Handle instance, int owner) {
  if (owner) {
  __android_log_write(ANDROID_LOG_INFO, "Tag", "Creating finalizer");
    Dart_WeakPersistentHandle handle = dart_attach_finalizer(instance, instanceId);
    instanceId_to_weak_dart_handle[std::string(instanceId)] = handle;
  } else {
    __android_log_write(ANDROID_LOG_INFO, "Tag", "Not add finalizer");
    Dart_Handle handle = Dart_NewPersistentHandle_DL(instance);
    instanceId_to_dart_handle[std::string(instanceId)] = handle;
  }
}
/*
extern "C" char* dart_get_instanceId(Dart_Handle instance) {
  if(!dart_is_paired(instance)) return NULL;
  return dart_handle_to_instanceId[instance];
}
*/

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

/*
extern "C"
JNIEXPORT jboolean JNICALL
Java_github_penguin_reference_reference_InstancePairManager_isPaired(JNIEnv *env, jobject object, jobject instance) {
  return jobject_to_instanceId.count(instance);
}
*/

extern "C"
JNIEXPORT void JNICALL
Java_github_penguin_reference_reference_InstancePairManager_nativeAddPair(JNIEnv *env,
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

/*
extern "C"
JNIEXPORT jstring JNICALL
Java_github_penguin_reference_reference_InstancePairManager_getInstanceId(JNIEnv *env, jobject object, jobject instance) {
  if (!Java_github_penguin_reference_reference_InstancePairManager_isPaired(env, object, instance)) {
    return NULL;
  }
  std::string instanceId = jobject_to_instanceId[instance];
  return env->NewStringUTF(&instanceId[0]);
}
*/

extern "C"
JNIEXPORT jobject JNICALL
Java_github_penguin_reference_reference_InstancePairManager_getObject(JNIEnv *env, jobject object, jstring instanceId) {
  std::string strInstanceId = jstring2string(env, instanceId);
  if (!instanceId_to_jobject.count(strInstanceId)) return NULL;
  return instanceId_to_jobject[strInstanceId];
}
#endif  // FINALIZER_H
