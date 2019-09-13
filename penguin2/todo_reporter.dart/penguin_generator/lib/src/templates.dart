class _Template {
  const _Template._(this.value);

  final String value;

  static const _Template methodChannel = _Template._(r'''
import 'package:flutter/services.dart';

// CLASSES
// CLASS
class $__className__ {
  $__className__(this.$uniqueId);
  
  final String $uniqueId;
  
  // METHODS
  // METHOD
  MethodCall $__methodName__() {
    return MethodCall(
      '__className__#__methodName__',
       <String, String>{'uniqueId': $uniqueId},
    );
  }
  // end METHOD
  // end METHODS
}
// end CLASS
// end CLASSES

Future<List<dynamic>> $invoke(
  MethodChannel channel,
  List<MethodCall> methodCalls,
) {
  final List<Map<String, dynamic>> calls = methodCalls
      .map<Map<String, dynamic>>(
        (MethodCall methodCall) => <String, dynamic>{
          'method': methodCall.method,
          'arguments': methodCall.arguments,
        },
      )
      .toList();

  return channel.invokeListMethod('Invoke', calls);
}
  ''');

  static const _Template android = _Template._(r'''
package __package__;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
// IMPORTS
// IMPORT
import __classPackage__;
// end IMPORT
// end IMPORTS

public class ChannelGenerated implements MethodCallHandler {
  private final HashMap<String, FlutterWrapper> allocatedWrappers = new HashMap<>();
  private final HashMap<String, FlutterWrapper> tempWrappers = new HashMap<>();
  
  private void addWrapper(
      final String uniqueId, final FlutterWrapper wrapper, HashMap<String, FlutterWrapper> wrapperMap) {
    if (wrapperMap.get(uniqueId) != null) {
      final String message = String.format("Object for uniqueId already exists: %s", uniqueId);
      throw new IllegalArgumentException(message);
    }
    wrapperMap.put(uniqueId, wrapper);
  }

  private void removeWrapper(String uniqueId) {
    allocatedWrappers.remove(uniqueId);
  }

  private Boolean isAllocated(final String uniqueId) {
    return allocatedWrappers.containsKey(uniqueId);
  }

  private FlutterWrapper getWrapper(String uniqueId) {
    final FlutterWrapper wrapper = allocatedWrappers.get(uniqueId);
    if (wrapper != null) return wrapper;
    return tempWrappers.get(uniqueId);
  }
  
  @Override
  public void onMethodCall(MethodCall call, Result result) {
    try {
      final Object value = onMethodCall(call);
      result.success(value);
    } catch (WrapperNotFoundException exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), null);
    } catch (NoUniqueIdException exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), null);
    } finally {
      tempWrappers.clear();
    }
  }
  
  private Object onMethodCall(MethodCall call) throws NoUniqueIdException, WrapperNotFoundException {
    switch(call.method) {
      case "MultiInvoke":
        final ArrayList<HashMap<String, Object>> allMethodCallData = (ArrayList<HashMap<String, Object>>) call.arguments;
        final ArrayList<Object> resultData = new ArrayList<>(allMethodCallData.size());
        for(HashMap<String, Object> methodCallData : allMethodCallData) {
          final String method = (String) methodCallData.get("method");;
          final HashMap<String, Object> arguments = (HashMap<String, Object>) methodCallData.get("arguments");
          final MethodCall methodCall = new MethodCall(method, arguments);
          resultData.add(onMethodCall(methodCall));
        }
        return resultData;
      default:
        final String uniqueId = call.argument("uniqueId");
        if (uniqueId == null) throw new NoUniqueIdException(call.method);
        
        final FlutterWrapper wrapper = getWrapper(uniqueId);
        if (wrapper == null) throw new WrapperNotFoundException(uniqueId);
        
        return wrapper.onMethodCall(call);
    }
  }

  // CLASSES
  // CLASS
  private class __className__ extends FlutterWrapper {
    private final __className__ __variableName__;

    __className__(String uniqueId, __className__ __variableName__) {
      super(uniqueId);
      this.__variableName__ = __variableName__;
      addWrapper(uniqueId, this, tempWrappers);
    }
    
    @Override
    public Object onMethodCall(MethodCall call) {
      return null;
    }

    // METHODS
    // METHOD
    Object __methodName__() {
      return __variableName__.__methodName__();
    }
    // end METHOD
    // end METHODS
  }
  // end CLASS
  // end CLASSES

  private abstract class FlutterWrapper {
    private final String uniqueId;
    
    FlutterWrapper(String uniqueId) {
      this.uniqueId = uniqueId;
    }

    abstract Object onMethodCall(MethodCall call);

    private void allocate() {
      addWrapper(uniqueId, this, allocatedWrappers);
    }

    private void deallocate() {
      removeWrapper(uniqueId);
    }
  }
  
  private class NotImplementedException extends Exception {
    NotImplementedException(String method) {
      super(String.format(Locale.getDefault(),"No implementation for %s.", method));
    }
  }
  
  private class NoUniqueIdException extends Exception {
    NoUniqueIdException(String method) {
      super(String.format("MethodCall was made without a unique handle for %s.", method));
    }
  }
  
  private class WrapperNotFoundException extends Exception {
    WrapperNotFoundException(String uniqueId) {
      super(String.format("Could not find FlutterWrapper with uniqueId %s.", uniqueId));
    }
  }
}
  ''');

  static const _Template javaChannel = _Template._(r'''
package dev.fruit.fruit_picker;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.lang.Boolean;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.util.ArrayList;
import java.util.HashMap;

public final class FruitPickerPlugin implements MethodCallHandler, FlutterWrapper {
  private static final String CHANNEL_NAME = "dev.fruit/fruit_picker";

  private static final HashMap<String, FlutterWrapper> wrappers = new HashMap<>();

  private static final HashMap<String, FlutterWrapper> invokerWrappers = new HashMap<>();

  private static Registrar registrar;

  private static MethodChannel channel;

  public static void registerWith(Registrar registrar) {
    FruitPickerPlugin.registrar = registrar;
    channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
    channel.setMethodCallHandler(new FruitPickerPlugin());
  }

  static void addWrapper(final String handle, final FlutterWrapper wrapper) {
    if (wrappers.get(handle) != null) {
      final String message = String.format("Object for handle already exists: %s", handle);
      throw new IllegalArgumentException(message);
    }
    wrappers.put(handle, wrapper);
  }

  static void addInvokerWrapper(final String handle, final FlutterWrapper wrapper) {
    if (invokerWrappers.get(handle) != null) {
      final String message = String.format("Object for handle already exists: %s", handle);
      throw new IllegalArgumentException(message);
    }
    invokerWrappers.put(handle, wrapper);
  }

  static void removeWrapper(String handle) {
    wrappers.remove(handle);
  }

  static Boolean allocated(final String handle) {
    return wrappers.containsKey(handle);
  }

  static FlutterWrapper getWrapper(String handle) {
    final FlutterWrapper wrapper = wrappers.get(handle);
    if (wrapper != null) return wrapper;
    return invokerWrappers.get(handle);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    invokerWrappers.clear();
    final Object value = onMethodCall(call);
    if (value instanceof FlutterWrapper.MethodNotImplemented) {
      result.notImplemented();
      return;
    }
    result.success(value);
    invokerWrappers.clear();
  }
  
  public Object onMethodCall(MethodCall call) {
    switch(call.method) {
      case "Invoke":
        Object value = null;
        final ArrayList<HashMap<String, Object>> allMethodCallData = (ArrayList<HashMap<String, Object>>) call.arguments;
        for(HashMap<String, Object> methodCallData : allMethodCallData) {
          final String method = (String) methodCallData.get("method");;
          final HashMap<String, Object> arguments = (HashMap<String, Object>) methodCallData.get("arguments");
          final MethodCall methodCall = new MethodCall(method, arguments);
          value = onMethodCall(methodCall);
          if (value instanceof FlutterWrapper.MethodNotImplemented) {
            return new FlutterWrapper.MethodNotImplemented();
          }
        }
        return value;
      default:
        final String handle = call.argument("handle");
        if (handle == null) {
          return new FlutterWrapper.MethodNotImplemented();
        }
        final FlutterWrapper wrapper = getWrapper(handle);
        if (wrapper == null) {
          return new FlutterWrapper.MethodNotImplemented();
        }
        return wrapper.onMethodCall(call);
    }
  }

  @Override
  public Object onMethodCall(MethodCall call) {
    switch(call.method) {
      case "Invoke":
        Object value = null;
        final ArrayList<HashMap<String, Object>> allMethodCallData = (ArrayList<HashMap<String, Object>>) call.arguments;
        for(HashMap<String, Object> methodCallData : allMethodCallData) {
          final String method = (String) methodCallData.get("method");;
          final HashMap<String, Object> arguments = (HashMap<String, Object>) methodCallData.get("arguments");
          final MethodCall methodCall = new MethodCall(method, arguments);
          value = onMethodCall(methodCall);
          if (value instanceof FlutterWrapper.MethodNotImplemented) {
            return new FlutterWrapper.MethodNotImplemented();
          }
        }
        return value;
      case "Basket()":
        return FlutterBasket.onStaticMethodCall(call);
      case "Basket(Apple)":
        return FlutterBasket.onStaticMethodCall(call);
      case "Basket(List<String>)":
        return FlutterBasket.onStaticMethodCall(call);
      case "Basket#ripestBanana":
        return FlutterBasket.onStaticMethodCall(call);
      case "Basket#favoritePeach":
        return FlutterBasket.onStaticMethodCall(call);
      case "Basket#aGreenGrape":
        return FlutterBasket.onStaticMethodCall(call);
      case "Basket#destroyBasket":
        return FlutterBasket.onStaticMethodCall(call);
      case "Basket#basketWithBananas":
        return FlutterBasket.onStaticMethodCall(call);
      case "Apple#areApplesGood":
        return FlutterApple.onStaticMethodCall(call);
      case "Apple#areApplesBetterThanThis":
        return FlutterApple.onStaticMethodCall(call);
      case "Orange(double)":
        return FlutterOrange.onStaticMethodCall(call);
      case "Strawberry()":
        return FlutterStrawberry.onStaticMethodCall(call);
      case "Strawberry(Map<bool, double>)":
        return FlutterStrawberry.onStaticMethodCall(call);
      case "Strawberry#averageNumberOfSeeds":
        return FlutterStrawberry.onStaticMethodCall(call);
      case "Empty()":
        return FlutterEmpty.onStaticMethodCall(call);
      case "Lemon(String,double)":
        return FlutterLemon.onStaticMethodCall(call);
      case "Peach()":
        return FlutterPeach.onStaticMethodCall(call);
      case "Apricot()":
        return FlutterApricot.onStaticMethodCall(call);
      case "Pear#aPearForAnApple":
        return FlutterPear.onStaticMethodCall(call);
      case "Pineapple()":
        return FlutterPineapple.onStaticMethodCall(call);
      case "Pineapple#doILikePineapple":
        return FlutterPineapple.onStaticMethodCall(call);
      case "Cherry(Seed)":
        return FlutterCherry.onStaticMethodCall(call);
      default:
        final String handle = call.argument("handle");
        if (handle == null) {
          return new FlutterWrapper.MethodNotImplemented();
        }
        final FlutterWrapper wrapper = getWrapper(handle);
        if (wrapper == null) {
          return new FlutterWrapper.MethodNotImplemented();
        }
        return wrapper.onMethodCall(call);
    }
  }
}
  ''');
}

class MethodChannelTemplateCreator extends _TemplateCreator {
  @override
  _Template get template => _Template.methodChannel;

  String createMethod({String className, String methodName}) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.className.name: className,
      _Replacement.methodName.name: methodName,
    });
  }

  String createClass({
    Iterable<String> methods,
    String className,
  }) {
    return _replaceClass(
      <Pattern, String>{
        _Block.methods.exp: methods.join(),
        _Replacement.className.name: className,
      },
    );
  }

  String createFile({Iterable<String> classes}) {
    return _replace(
      template.value,
      <Pattern, String>{_Block.classes.exp: classes.join()},
    );
  }
}

class AndroidTemplateCreator extends _TemplateCreator {
  @override
  _Template get template => _Template.android;

  String createMethod({
    String methodName,
    String variableName,
  }) {
    return _replaceMethod(<Pattern, String>{
      _Replacement.methodName.name: methodName,
      _Replacement.variableName.name: variableName,
    });
  }

  String createClass({
    Iterable<String> methods,
    String className,
    String variableName,
  }) {
    return _replaceClass(<Pattern, String>{
      _Block.methods.exp: methods.join(),
      _Replacement.className.name: className,
      _Replacement.variableName.name: variableName,
    });
  }

  String createImport({String classPackage}) {
    return _replaceImport(<Pattern, String>{
      _Replacement.classPackage.name: classPackage,
    });
  }

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    String package,
  }) {
    return _replace(template.value, <Pattern, String>{
      _Block.imports.exp: imports.join(),
      _Block.classes.exp: classes.join(),
      _Replacement.package.name: package,
    });
  }
}

abstract class _TemplateCreator {
  _Template get template;

  String _getMethod(String input) {
    return _Block.method.exp.firstMatch(input).group(1);
  }

  String _getImport(String input) {
    return _Block.import.exp.firstMatch(input).group(1);
  }

  String _getClass(String input) {
    return _Block.aClass.exp.firstMatch(input).group(1);
  }

  // TODO: Speedup with replaceAllMapped
  String _replace(String value, Map<Pattern, String> replacements) {
    for (MapEntry<Pattern, String> entry in replacements.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }

  String _replaceClass(Map<Pattern, String> replacements) {
    return _replace(_getClass(template.value), replacements);
  }

  String _replaceMethod(Map<Pattern, String> replacements) {
    return _replace(_getMethod(template.value), replacements);
  }

  String _replaceImport(Map<Pattern, String> replacements) {
    return _replace(_getImport(template.value), replacements);
  }
}

class _Block {
  _Block(this.exp);

  final RegExp exp;

  static final _Block methods = _Block(RegExp(
    r'// METHODS$.(.*)// end METHODS',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block method = _Block(RegExp(
    r'// METHOD$(.*)// end METHOD$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block imports = _Block(RegExp(
    r'// IMPORTS$(.*)// end IMPORTS',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block import = _Block(RegExp(
    r'// IMPORT$(.*)// end IMPORT$',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block classes = _Block(RegExp(
    r'// CLASSES$(.*)// end CLASSES',
    multiLine: true,
    dotAll: true,
  ));

  static final _Block aClass = _Block(RegExp(
    r'// CLASS$(.*)// end CLASS$',
    multiLine: true,
    dotAll: true,
  ));
}

class _Replacement {
  const _Replacement(this.name);

  final String name;

  static final _Replacement methodName = _Replacement('__methodName__');
  static final _Replacement className = _Replacement('__className__');
  static final _Replacement channelName = _Replacement('__channelName__');
  static final _Replacement variableName = _Replacement('__variableName__');
  static final _Replacement package = _Replacement('__package__');
  static final _Replacement classPackage = _Replacement('__classPackage__');
}
