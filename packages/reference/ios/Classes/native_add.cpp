#include <stdint.h>
#include <stdio.h>
#include <android/log.h>
#include <jni.h>

#include "include/dart_api.h"
#include "include/dart_native_api.h"

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


#endif  // FINALIZER_H
