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

  // Create a _finalizable_pointer to be attached as peer.
/*
    _finalizable_pointer* peer = new _finalizable_pointer();
    peer->finalizer = finalizer;
    peer->pointer = pointer;

    // Attaced peer and _webcrypto_finalizer_callback
    Dart_FinalizableHandle handle;
    // NOTE: we have check the availability of Dart_NewFinalizableHandle_DL in
    //       webcrypto_dart_dl_initialize.
    intptr_t size = 4096;
    handle = Dart_NewFinalizableHandle_DL(&object, (void*)peer,
                                          size,
                                          &RunFinalizer);
                                          */


}

extern "C"
JNIEXPORT jstring JNICALL
Java_github_penguin_reference_ReferencePlugin_getMsgFromJni(JNIEnv *env, jobject instance) {
// Put your code here
 count++;
 return env->NewStringUTF("Hello From JNI");
}


#endif  // FINALIZER_H
