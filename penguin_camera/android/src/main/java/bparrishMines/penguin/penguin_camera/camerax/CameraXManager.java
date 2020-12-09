//package bparrishMines.penguin.penguin_camera.camerax;
//
//import android.content.Context;
//
//import androidx.lifecycle.LifecycleOwner;
//import bparrishMines.penguin.penguin_camera.PenguinCameraPlugin;
//import github.penguin.reference.reference.ReferencePairManager;
//import io.flutter.plugin.common.BinaryMessenger;
//import io.flutter.view.TextureRegistry;
//
//public class CameraXManager extends CameraXReferenceLibrary.$ReferencePairManager {
//  final TextureRegistry textureRegistry;
//  Context context;
//  final LifecycleOwner lifecycleOwner;
//
//  public CameraXManager(BinaryMessenger binaryMessenger, TextureRegistry textureRegistry, Context context, LifecycleOwner lifecycleOwner) {
//    super(binaryMessenger, "bparrishMines.penguin/penguin_camera/camerax");
//    this.textureRegistry = textureRegistry;
//    this.context = context;
//    this.lifecycleOwner = lifecycleOwner;
//  }
//
//  @Override
//  public CameraXReferenceLibrary.$LocalHandler getLocalHandler() {
//    return new CameraXReferenceLibrary.$LocalHandler() {
//      @Override
//      public CameraXReferenceLibrary.$UseCase createUseCase(ReferencePairManager referencePairManager, CameraXReferenceLibrary.$UseCaseCreationArgs args) throws Exception {
//        return null;
//      }
//
//      @Override
//      public CameraXReferenceLibrary.$Preview createPreview(ReferencePairManager referencePairManager, CameraXReferenceLibrary.$PreviewCreationArgs args) throws Exception {
//        return new Preview((CameraXManager) referencePairManager);
//      }
//
//      @Override
//      public CameraXReferenceLibrary.$SuccessListener createSuccessListener(ReferencePairManager referencePairManager, CameraXReferenceLibrary.$SuccessListenerCreationArgs args) throws Exception {
//        return new SuccessListener((CameraXManager) referencePairManager);
//      }
//
//      @Override
//      public CameraXReferenceLibrary.$ProcessCameraProvider createProcessCameraProvider(ReferencePairManager referencePairManager, CameraXReferenceLibrary.$ProcessCameraProviderCreationArgs args) throws Exception {
//        return null;
//      }
//
//      @Override
//      public CameraXReferenceLibrary.$Camera createCamera(ReferencePairManager referencePairManager, CameraXReferenceLibrary.$CameraCreationArgs args) throws Exception {
//        return null;
//      }
//
//      @Override
//      public CameraXReferenceLibrary.$CameraSelector createCameraSelector(ReferencePairManager referencePairManager, CameraXReferenceLibrary.$CameraSelectorCreationArgs args) throws Exception {
//        return new CameraSelector(args.lensFacing);
//      }
//
//      @Override
//      public Object processCameraProvider$initialize(ReferencePairManager referencePairManager, CameraXReferenceLibrary.$SuccessListener successListener) throws Exception {
//        return ProcessCameraProvider.initialize((CameraXManager) referencePairManager, (SuccessListener) successListener);
//      }
//    };
//  }
//
//  public void setContext(Context context) {
//    this.context = context;
//  }
//}
