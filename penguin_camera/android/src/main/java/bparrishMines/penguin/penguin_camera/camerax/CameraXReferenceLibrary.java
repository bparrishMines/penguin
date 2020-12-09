//// GENERATED CODE - DO NOT MODIFY BY HAND
//
//package bparrishMines.penguin.penguin_camera.camerax;
//
//import github.penguin.reference.async.Completable;
//import github.penguin.reference.method_channel.MethodChannelReferencePairManager;
//import github.penguin.reference.method_channel.MethodChannelRemoteHandler;
//import github.penguin.reference.method_channel.ReferenceMessageCodec;
//import github.penguin.reference.reference.LocalReference;
//import github.penguin.reference.reference.ReferencePairManager;
//import github.penguin.reference.reference.ReferencePairManager.LocalReferenceCommunicationHandler;
//import io.flutter.plugin.common.BinaryMessenger;
//import java.util.Arrays;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//// **************************************************************************
//// ReferenceGenerator
//// **************************************************************************
//
//@SuppressWarnings({"ArraysAsListWithZeroOrOneArgument", "unused"})
//class CameraXReferenceLibrary {
//  private abstract static class $LocalCreatorHandler {
//    abstract LocalReference call(
//        $LocalHandler localHandler,
//        ReferencePairManager referencePairManager,
//        List<Object> arguments)
//        throws Exception;
//  }
//
//  private abstract static class $LocalStaticMethodHandler {
//    abstract Object call(
//        $LocalHandler localHandler,
//        ReferencePairManager referencePairManager,
//        List<Object> arguments)
//        throws Exception;
//  }
//
//  private abstract static class $LocalMethodHandler {
//    abstract Object call(LocalReference localReference, List<Object> arguments) throws Exception;
//  }
//
//  private abstract static class $CreationArgumentsHandler {
//    abstract List<Object> call(LocalReference localReference);
//  }
//
//  abstract static class $UseCase implements LocalReference {
//
//
//
//
//
//
//
//
//    @Override
//    public Class<? extends LocalReference> getReferenceClass() {
//      return $UseCase.class;
//    }
//  }
//
//abstract static class $Preview extends $UseCase {
//
//
//    abstract Object attachToTexture() throws Exception;
//
//abstract Object releaseTexture() throws Exception;
//
//
//
//    protected Completable<Object> $attachToTexture(
//        $ReferencePairManager manager) {
//      if (manager.getPairedRemoteReference(this) == null) {
//        return manager.invokeRemoteMethodOnUnpairedReference(
//            this, "attachToTexture", Arrays.asList());
//      }
//
//      return manager.invokeRemoteMethod(
//          manager.getPairedRemoteReference(this),
//          "attachToTexture",
//          Arrays.asList());
//    }
//
//protected Completable<Object> $releaseTexture(
//        $ReferencePairManager manager) {
//      if (manager.getPairedRemoteReference(this) == null) {
//        return manager.invokeRemoteMethodOnUnpairedReference(
//            this, "releaseTexture", Arrays.asList());
//      }
//
//      return manager.invokeRemoteMethod(
//          manager.getPairedRemoteReference(this),
//          "releaseTexture",
//          Arrays.asList());
//    }
//
//    @Override
//    public Class<? extends LocalReference> getReferenceClass() {
//      return $Preview.class;
//    }
//  }
//
//abstract static class $SuccessListener implements LocalReference {
//
//
//    abstract Object onSuccess() throws Exception;
//
//abstract Object onError(String code, String message) throws Exception;
//
//
//
//    protected Completable<Object> $onSuccess(
//        $ReferencePairManager manager) {
//      if (manager.getPairedRemoteReference(this) == null) {
//        return manager.invokeRemoteMethodOnUnpairedReference(
//            this, "onSuccess", Arrays.asList());
//      }
//
//      return manager.invokeRemoteMethod(
//          manager.getPairedRemoteReference(this),
//          "onSuccess",
//          Arrays.asList());
//    }
//
//protected Completable<Object> $onError(
//        $ReferencePairManager manager, String code , String message) {
//      if (manager.getPairedRemoteReference(this) == null) {
//        return manager.invokeRemoteMethodOnUnpairedReference(
//            this, "onError", Arrays.asList((Object) code, (Object) message));
//      }
//
//      return manager.invokeRemoteMethod(
//          manager.getPairedRemoteReference(this),
//          "onError",
//          Arrays.asList((Object) code, (Object) message));
//    }
//
//    @Override
//    public Class<? extends LocalReference> getReferenceClass() {
//      return $SuccessListener.class;
//    }
//  }
//
//abstract static class $ProcessCameraProvider implements LocalReference {
//
//
//    abstract Object bindToLifecycle($CameraSelector selector, $UseCase useCase) throws Exception;
//
//abstract Object unbindAll() throws Exception;
//
//    protected static Completable<Object> $initialize(
//        $ReferencePairManager manager, $SuccessListener successListener) {
//      return manager.invokeRemoteStaticMethod(
//          $ProcessCameraProvider.class, "initialize", Arrays.asList((Object) successListener));
//    }
//
//    protected Completable<Object> $bindToLifecycle(
//        $ReferencePairManager manager, $CameraSelector selector , $UseCase useCase) {
//      if (manager.getPairedRemoteReference(this) == null) {
//        return manager.invokeRemoteMethodOnUnpairedReference(
//            this, "bindToLifecycle", Arrays.asList((Object) selector, (Object) useCase));
//      }
//
//      return manager.invokeRemoteMethod(
//          manager.getPairedRemoteReference(this),
//          "bindToLifecycle",
//          Arrays.asList((Object) selector, (Object) useCase));
//    }
//
//protected Completable<Object> $unbindAll(
//        $ReferencePairManager manager) {
//      if (manager.getPairedRemoteReference(this) == null) {
//        return manager.invokeRemoteMethodOnUnpairedReference(
//            this, "unbindAll", Arrays.asList());
//      }
//
//      return manager.invokeRemoteMethod(
//          manager.getPairedRemoteReference(this),
//          "unbindAll",
//          Arrays.asList());
//    }
//
//    @Override
//    public Class<? extends LocalReference> getReferenceClass() {
//      return $ProcessCameraProvider.class;
//    }
//  }
//
//abstract static class $Camera implements LocalReference {
//
//
//
//
//
//
//
//
//    @Override
//    public Class<? extends LocalReference> getReferenceClass() {
//      return $Camera.class;
//    }
//  }
//
//abstract static class $CameraSelector implements LocalReference {
//    abstract Integer getLensFacing();
//
//
//
//
//
//
//
//    @Override
//    public Class<? extends LocalReference> getReferenceClass() {
//      return $CameraSelector.class;
//    }
//  }
//
//  static class $UseCaseCreationArgs {
//
//  }
//
//static class $PreviewCreationArgs {
//
//  }
//
//static class $SuccessListenerCreationArgs {
//
//  }
//
//static class $ProcessCameraProviderCreationArgs {
//
//  }
//
//static class $CameraCreationArgs {
//
//  }
//
//static class $CameraSelectorCreationArgs {
//    Integer lensFacing;
//  }
//
//  abstract static class $ReferencePairManager extends MethodChannelReferencePairManager {
//    $ReferencePairManager(final BinaryMessenger binaryMessenger, final String channelName) {
//      this(binaryMessenger, channelName, new ReferenceMessageCodec());
//    }
//
//    @SuppressWarnings("ArraysAsListWithZeroOrOneArgument")
//    $ReferencePairManager(
//        final BinaryMessenger binaryMessenger,
//        final String channelName,
//        final ReferenceMessageCodec messageCodec) {
//      super(
//          Arrays.<Class<? extends LocalReference>>asList($UseCase.class, $Preview.class, $SuccessListener.class, $ProcessCameraProvider.class, $Camera.class, $CameraSelector.class),
//          binaryMessenger,
//          channelName,
//          channelName,
//          messageCodec);
//    }
//
//    @Override
//    public abstract $LocalHandler getLocalHandler();
//
//    @Override
//    public MethodChannelRemoteHandler getRemoteHandler() {
//      return new $RemoteHandler(binaryMessenger, channelName);
//    }
//  }
//
//  abstract static class $LocalHandler implements LocalReferenceCommunicationHandler {
//    private static final Map<Class<? extends LocalReference>, $LocalCreatorHandler> creators =
//        new HashMap<Class<? extends LocalReference>, $LocalCreatorHandler>() {
//          {
//            put(
//                $UseCase.class,
//                new $LocalCreatorHandler() {
//                  @Override
//                  LocalReference call(
//                      $LocalHandler localHandler,
//                      ReferencePairManager referencePairManager,
//                      List<Object> arguments)
//                      throws Exception {
//                    final $UseCaseCreationArgs args = new $UseCaseCreationArgs();
//
//                    return localHandler.createUseCase(referencePairManager, args);
//                  }
//                });
//put(
//                $Preview.class,
//                new $LocalCreatorHandler() {
//                  @Override
//                  LocalReference call(
//                      $LocalHandler localHandler,
//                      ReferencePairManager referencePairManager,
//                      List<Object> arguments)
//                      throws Exception {
//                    final $PreviewCreationArgs args = new $PreviewCreationArgs();
//
//                    return localHandler.createPreview(referencePairManager, args);
//                  }
//                });
//put(
//                $SuccessListener.class,
//                new $LocalCreatorHandler() {
//                  @Override
//                  LocalReference call(
//                      $LocalHandler localHandler,
//                      ReferencePairManager referencePairManager,
//                      List<Object> arguments)
//                      throws Exception {
//                    final $SuccessListenerCreationArgs args = new $SuccessListenerCreationArgs();
//
//                    return localHandler.createSuccessListener(referencePairManager, args);
//                  }
//                });
//put(
//                $ProcessCameraProvider.class,
//                new $LocalCreatorHandler() {
//                  @Override
//                  LocalReference call(
//                      $LocalHandler localHandler,
//                      ReferencePairManager referencePairManager,
//                      List<Object> arguments)
//                      throws Exception {
//                    final $ProcessCameraProviderCreationArgs args = new $ProcessCameraProviderCreationArgs();
//
//                    return localHandler.createProcessCameraProvider(referencePairManager, args);
//                  }
//                });
//put(
//                $Camera.class,
//                new $LocalCreatorHandler() {
//                  @Override
//                  LocalReference call(
//                      $LocalHandler localHandler,
//                      ReferencePairManager referencePairManager,
//                      List<Object> arguments)
//                      throws Exception {
//                    final $CameraCreationArgs args = new $CameraCreationArgs();
//
//                    return localHandler.createCamera(referencePairManager, args);
//                  }
//                });
//put(
//                $CameraSelector.class,
//                new $LocalCreatorHandler() {
//                  @Override
//                  LocalReference call(
//                      $LocalHandler localHandler,
//                      ReferencePairManager referencePairManager,
//                      List<Object> arguments)
//                      throws Exception {
//                    final $CameraSelectorCreationArgs args = new $CameraSelectorCreationArgs();
//                    args.lensFacing = (Integer) arguments.get(0);
//                    return localHandler.createCameraSelector(referencePairManager, args);
//                  }
//                });
//          }
//        };
//
//    private static final Map<
//            Class<? extends LocalReference>, Map<String, $LocalStaticMethodHandler>>
//        staticMethods =
//            new HashMap<Class<? extends LocalReference>, Map<String, $LocalStaticMethodHandler>>() {
//              {
//                put(
//                    $UseCase.class,
//                    new HashMap<String, $LocalStaticMethodHandler>() {
//                      {
//
//                      }
//                    });
//put(
//                    $Preview.class,
//                    new HashMap<String, $LocalStaticMethodHandler>() {
//                      {
//
//                      }
//                    });
//put(
//                    $SuccessListener.class,
//                    new HashMap<String, $LocalStaticMethodHandler>() {
//                      {
//
//                      }
//                    });
//put(
//                    $ProcessCameraProvider.class,
//                    new HashMap<String, $LocalStaticMethodHandler>() {
//                      {
//                        put(
//                            "initialize",
//                            new $LocalStaticMethodHandler() {
//                              @Override
//                              Object call(
//                                  $LocalHandler localHandler,
//                                  ReferencePairManager referencePairManager,
//                                  List<Object> arguments)
//                                  throws Exception {
//                                return localHandler.processCameraProvider$initialize(
//                                    referencePairManager, ($SuccessListener) arguments.get(0));
//                              }
//                            });
//                      }
//                    });
//put(
//                    $Camera.class,
//                    new HashMap<String, $LocalStaticMethodHandler>() {
//                      {
//
//                      }
//                    });
//put(
//                    $CameraSelector.class,
//                    new HashMap<String, $LocalStaticMethodHandler>() {
//                      {
//
//                      }
//                    });
//              }
//            };
//
//    private static final Map<Class<? extends LocalReference>, Map<String, $LocalMethodHandler>>
//        methods =
//            new HashMap<Class<? extends LocalReference>, Map<String, $LocalMethodHandler>>() {
//              {
//                put(
//                    $UseCase.class,
//                    new HashMap<String, $LocalMethodHandler>() {
//                      {
//
//                      }
//                    });
//put(
//                    $Preview.class,
//                    new HashMap<String, $LocalMethodHandler>() {
//                      {
//                        put(
//                            "attachToTexture",
//                            new $LocalMethodHandler() {
//                              @Override
//                              Object call(LocalReference localReference, List<Object> arguments)
//                                  throws Exception {
//                                return (($Preview) localReference)
//                                    .attachToTexture();
//                              }
//                            });
//put(
//                            "releaseTexture",
//                            new $LocalMethodHandler() {
//                              @Override
//                              Object call(LocalReference localReference, List<Object> arguments)
//                                  throws Exception {
//                                return (($Preview) localReference)
//                                    .releaseTexture();
//                              }
//                            });
//                      }
//                    });
//put(
//                    $SuccessListener.class,
//                    new HashMap<String, $LocalMethodHandler>() {
//                      {
//                        put(
//                            "onSuccess",
//                            new $LocalMethodHandler() {
//                              @Override
//                              Object call(LocalReference localReference, List<Object> arguments)
//                                  throws Exception {
//                                return (($SuccessListener) localReference)
//                                    .onSuccess();
//                              }
//                            });
//put(
//                            "onError",
//                            new $LocalMethodHandler() {
//                              @Override
//                              Object call(LocalReference localReference, List<Object> arguments)
//                                  throws Exception {
//                                return (($SuccessListener) localReference)
//                                    .onError((String) arguments.get(0),(String) arguments.get(1));
//                              }
//                            });
//                      }
//                    });
//put(
//                    $ProcessCameraProvider.class,
//                    new HashMap<String, $LocalMethodHandler>() {
//                      {
//                        put(
//                            "bindToLifecycle",
//                            new $LocalMethodHandler() {
//                              @Override
//                              Object call(LocalReference localReference, List<Object> arguments)
//                                  throws Exception {
//                                return (($ProcessCameraProvider) localReference)
//                                    .bindToLifecycle(($CameraSelector) arguments.get(0),($UseCase) arguments.get(1));
//                              }
//                            });
//put(
//                            "unbindAll",
//                            new $LocalMethodHandler() {
//                              @Override
//                              Object call(LocalReference localReference, List<Object> arguments)
//                                  throws Exception {
//                                return (($ProcessCameraProvider) localReference)
//                                    .unbindAll();
//                              }
//                            });
//                      }
//                    });
//put(
//                    $Camera.class,
//                    new HashMap<String, $LocalMethodHandler>() {
//                      {
//
//                      }
//                    });
//put(
//                    $CameraSelector.class,
//                    new HashMap<String, $LocalMethodHandler>() {
//                      {
//
//                      }
//                    });
//              }
//            };
//
//    public abstract $UseCase createUseCase(
//        ReferencePairManager referencePairManager, $UseCaseCreationArgs args)
//        throws Exception;
//
//public abstract $Preview createPreview(
//        ReferencePairManager referencePairManager, $PreviewCreationArgs args)
//        throws Exception;
//
//public abstract $SuccessListener createSuccessListener(
//        ReferencePairManager referencePairManager, $SuccessListenerCreationArgs args)
//        throws Exception;
//
//public abstract $ProcessCameraProvider createProcessCameraProvider(
//        ReferencePairManager referencePairManager, $ProcessCameraProviderCreationArgs args)
//        throws Exception;
//
//public abstract $Camera createCamera(
//        ReferencePairManager referencePairManager, $CameraCreationArgs args)
//        throws Exception;
//
//public abstract $CameraSelector createCameraSelector(
//        ReferencePairManager referencePairManager, $CameraSelectorCreationArgs args)
//        throws Exception;
//
//    public abstract Object processCameraProvider$initialize(
//        ReferencePairManager referencePairManager, $SuccessListener successListener) throws Exception;
//
//    @SuppressWarnings("ConstantConditions")
//    @Override
//    public LocalReference create(
//        ReferencePairManager referencePairManager,
//        Class<? extends LocalReference> referenceClass,
//        List<Object> arguments)
//        throws Exception {
//      return creators.get(referenceClass).call(this, referencePairManager, arguments);
//    }
//
//    @SuppressWarnings("ConstantConditions")
//    @Override
//    public Object invokeStaticMethod(
//        ReferencePairManager referencePairManager,
//        Class<? extends LocalReference> referenceClass,
//        String methodName,
//        List<Object> arguments)
//        throws Exception {
//      return staticMethods
//          .get(referenceClass)
//          .get(methodName)
//          .call(this, referencePairManager, arguments);
//    }
//
//    @SuppressWarnings({"ConstantConditions", "SwitchStatementWithTooFewBranches"})
//    @Override
//    public Object invokeMethod(
//        ReferencePairManager referencePairManager,
//        LocalReference localReference,
//        String methodName,
//        List<Object> arguments)
//        throws Exception {
//      final $LocalMethodHandler handler =
//          methods.get(localReference.getReferenceClass()).get(methodName);
//      if (handler != null) return handler.call(localReference, arguments);
//
//      // Based on inheritance.
//      if (localReference instanceof $UseCase) {
//        switch (methodName) {
//
//        }
//      }else if (localReference instanceof $Preview) {
//        switch (methodName) {
//          case "attachToTexture":
//            return (($Preview) localReference).attachToTexture();
//case "releaseTexture":
//            return (($Preview) localReference).releaseTexture();
//        }
//      }else if (localReference instanceof $SuccessListener) {
//        switch (methodName) {
//          case "onSuccess":
//            return (($SuccessListener) localReference).onSuccess();
//case "onError":
//            return (($SuccessListener) localReference).onError((String) arguments.get(0),(String) arguments.get(1));
//        }
//      }else if (localReference instanceof $ProcessCameraProvider) {
//        switch (methodName) {
//          case "bindToLifecycle":
//            return (($ProcessCameraProvider) localReference).bindToLifecycle(($CameraSelector) arguments.get(0),($UseCase) arguments.get(1));
//case "unbindAll":
//            return (($ProcessCameraProvider) localReference).unbindAll();
//        }
//      }else if (localReference instanceof $Camera) {
//        switch (methodName) {
//
//        }
//      }else if (localReference instanceof $CameraSelector) {
//        switch (methodName) {
//
//        }
//      }
//
//      final String message =
//          String.format(
//              "Unable to invoke method `%s` on (localReference): %s",
//              methodName, localReference.toString());
//      throw new IllegalArgumentException(message);
//    }
//
//    @SuppressWarnings("RedundantThrows")
//    @Override
//    public void dispose(ReferencePairManager referencePairManager, LocalReference localReference)
//        throws Exception {
//      // Do nothing.
//    }
//  }
//
//  static class $RemoteHandler extends MethodChannelRemoteHandler {
//    private static final Map<Class<? extends LocalReference>, $CreationArgumentsHandler>
//        creationArguments =
//            new HashMap<Class<? extends LocalReference>, $CreationArgumentsHandler>() {
//              {
//                put(
//                    $UseCase.class,
//                    new $CreationArgumentsHandler() {
//                      @Override
//                      List<Object> call(LocalReference localReference) {
//                        final $UseCase value = ($UseCase) localReference;
//                        return Arrays.asList();
//                      }
//                    });
//put(
//                    $Preview.class,
//                    new $CreationArgumentsHandler() {
//                      @Override
//                      List<Object> call(LocalReference localReference) {
//                        final $Preview value = ($Preview) localReference;
//                        return Arrays.asList();
//                      }
//                    });
//put(
//                    $SuccessListener.class,
//                    new $CreationArgumentsHandler() {
//                      @Override
//                      List<Object> call(LocalReference localReference) {
//                        final $SuccessListener value = ($SuccessListener) localReference;
//                        return Arrays.asList();
//                      }
//                    });
//put(
//                    $ProcessCameraProvider.class,
//                    new $CreationArgumentsHandler() {
//                      @Override
//                      List<Object> call(LocalReference localReference) {
//                        final $ProcessCameraProvider value = ($ProcessCameraProvider) localReference;
//                        return Arrays.asList();
//                      }
//                    });
//put(
//                    $Camera.class,
//                    new $CreationArgumentsHandler() {
//                      @Override
//                      List<Object> call(LocalReference localReference) {
//                        final $Camera value = ($Camera) localReference;
//                        return Arrays.asList();
//                      }
//                    });
//put(
//                    $CameraSelector.class,
//                    new $CreationArgumentsHandler() {
//                      @Override
//                      List<Object> call(LocalReference localReference) {
//                        final $CameraSelector value = ($CameraSelector) localReference;
//                        return Arrays.asList((Object) value.getLensFacing());
//                      }
//                    });
//              }
//            };
//
//    $RemoteHandler(BinaryMessenger binaryMessenger, String channelName) {
//      super(binaryMessenger, channelName);
//    }
//
//    @SuppressWarnings("ConstantConditions")
//    @Override
//    public List<Object> getCreationArguments(LocalReference localReference) {
//      return creationArguments.get(localReference.getReferenceClass()).call(localReference);
//    }
//  }
//}
