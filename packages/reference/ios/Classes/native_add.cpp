#include <stdint.h>
#include <stdio.h>
#include <android/log.h>

#include "include/dart_api.h"
#include "include/dart_native_api.h"

#include "include/dart_api_dl.h"

#ifndef FINALIZER_H
#define FINALIZER_H

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
__android_log_write(ANDROID_LOG_INFO, "Tag", "Error here");
printf("HIIIIIIIII.\n");
    return x + y;
}

static void RunFinalizer(void* isolate_callback_data,
                         void* peer) {
  printf("Running finalizer.\n");
}

extern "C" void PassObjectToC(Dart_Handle h) {
  printf("YOLO.\n");
  //void* peer = 0x0;
  //intptr_t size = 8;
  //auto finalizable_handle = Dart_NewFinalizableHandle_DL(h, peer, size, RunFinalizer);
}


#endif  // FINALIZER_H
