// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
package com.example.penguin_usage;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.example.penguin_usage.test_package.TestClass;

import com.example.penguin_usage.test_package.TestClassTwo;

import com.example.penguin_usage.test_package.TestGenericClass;


public class ChannelGenerated implements MethodCallHandler {
  private static abstract class FlutterWrapper {
    final ChannelGenerated $channelGenerated;
    final String $uniqueId;
    
    FlutterWrapper(ChannelGenerated $channelGenerated, String $uniqueId) {
      this.$channelGenerated = $channelGenerated;
      this.$uniqueId = $uniqueId;
    }

    abstract Object onMethodCall(MethodCall call) throws NotImplementedException;
    abstract Object $getValue();

    void allocate() {
      if ($channelGenerated.isAllocated($uniqueId)) return;
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.allocatedWrappers);
    }

    void deallocate() {
      $channelGenerated.removeWrapper($uniqueId);
    }
  }

  private static class NotImplementedException extends Exception {
    NotImplementedException(String method) {
      super(String.format(Locale.getDefault(),"No implementation for %s.", method));
    }
  }

  private static class NoUniqueIdException extends Exception {
    NoUniqueIdException(String method) {
      super(String.format("MethodCall was made without a unique handle for %s.", method));
    }
  }

  private static class WrapperNotFoundException extends Exception {
    WrapperNotFoundException(String uniqueId) {
      super(String.format("Could not find FlutterWrapper with uniqueId %s.", uniqueId));
    }
  }

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
    } catch (NotImplementedException exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), null);
    } finally {
      tempWrappers.clear();
    }
  }

  private Object onMethodCall(MethodCall call) throws NoUniqueIdException, WrapperNotFoundException, NotImplementedException {
    switch(call.method) {
      case "MultiInvoke":
        final ArrayList<HashMap<String, Object>> allMethodCallData = (ArrayList<HashMap<String, Object>>) call.arguments;
        final ArrayList<Object> resultData = new ArrayList<>(allMethodCallData.size());
        for(HashMap<String, Object> methodCallData : allMethodCallData) {
          final String method = (String) methodCallData.get("method");
          final HashMap<String, Object> arguments = (HashMap<String, Object>) methodCallData.get("arguments");
          final MethodCall methodCall = new MethodCall(method, arguments);
          resultData.add(onMethodCall(methodCall));
        }
        return resultData;
      
      case "TestClass()": {
          return TestClassWrapper.onStaticMethodCall(this, call);
        }
      
      case "TestClassTwo()": {
          return TestClassTwoWrapper.onStaticMethodCall(this, call);
        }
      
      case "TestGenericClass()": {
          return TestGenericClassWrapper.onStaticMethodCall(this, call);
        }
      
      default:
        final String $uniqueId = call.argument("$uniqueId");
        if ($uniqueId == null) throw new NoUniqueIdException(call.method);

        final FlutterWrapper wrapper = getWrapper($uniqueId);
        if (wrapper == null) throw new WrapperNotFoundException($uniqueId);

        return wrapper.onMethodCall(call);
    }
  }

  
  private static class TestClassWrapper extends FlutterWrapper {
    private final TestClass $value;

    public TestClassWrapper(ChannelGenerated $channelGenerated, String $uniqueId, TestClass $value) {
      super($channelGenerated, $uniqueId);
      this.$value = $value;
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }

    
    private TestClassWrapper(ChannelGenerated $channelGenerated, final String $uniqueId) {
      super($channelGenerated, $uniqueId);
      this.$value = new TestClass();
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }
    
    
    static Object onStaticMethodCall(ChannelGenerated $channelGenerated, MethodCall call) throws NotImplementedException {
      switch(call.method) {
        
        case "TestClass()": {
            new TestClassWrapper($channelGenerated, (String) call.argument("$uniqueId"));
            return null;
          }
        
        default:
          throw new NotImplementedException(call.method);
      }
    }

    @Override
    public Object onMethodCall(MethodCall call) throws NotImplementedException {
      switch(call.method) {
        case "TestClass#allocate":
          allocate();
          return null;
        case "TestClass#deallocate":
          deallocate();
          return null;
        
        case "TestClass#aMethod":
          return aMethod(call);
        
        case "TestClass#getStringMethod":
          return getStringMethod(call);
        
        case "TestClass#addTwo":
          return addTwo(call);
        
        case "TestClass#divide":
          return divide(call);
        
        case "TestClass#getList":
          return getList(call);
        
        case "TestClass#giveUsage2":
          return giveUsage2(call);
        
        case "TestClass#getUsage2":
          return getUsage2(call);
        
        case "TestClass#arePenguinsAwesome":
          return arePenguinsAwesome(call);
        
        default:
          throw new NotImplementedException(call.method);
      }
    }
    
    @Override
    public Object $getValue() {
      return $value;
    }

    
     Object aMethod(MethodCall call) {
      
      
      
      $value.aMethod(
      
      )
      
      ;
      return null;
      
    }
    
     Object getStringMethod(MethodCall call) {
      
      return
      
      
      $value.getStringMethod(
      
      )
      
      ;
      
    }
    
     Object addTwo(MethodCall call) {
      
      return
      
      
      $value.addTwo(
      
      call.argument("value") == null ? null : (Integer) call.argument("value")
      
      )
      
      ;
      
    }
    
     Object divide(MethodCall call) {
      
      return
      
      
      $value.divide(
      
      call.argument("one") == null ? null : (Integer) call.argument("one")
      ,
      call.argument("two") == null ? null : (Integer) call.argument("two")
      
      )
      
      ;
      
    }
    
     Object getList(MethodCall call) {
      
      return
      
      
      $value.getList(
      
      call.argument("addThese") == null ? null : (HashMap<Integer, Integer>) call.argument("addThese")
      
      )
      
      ;
      
    }
    
     Object giveUsage2(MethodCall call) {
      
      return
      
      
      $value.giveUsage2(
      
      ((TestClassTwoWrapper) $channelGenerated.getWrapper((String) call.argument("usage2"))).$value
      
      )
      
      ;
      
    }
    
     Object getUsage2(MethodCall call) {
      
      new TestClassTwoWrapper($channelGenerated, (String) call.argument("$newUniqueId"),
      
      
      $value.getUsage2(
      
      )
      
      );
      return null;
      
    }
    
    static Object arePenguinsAwesome(MethodCall call) {
      
      return
      
      
      TestClass.arePenguinsAwesome(
      
      )
      
      ;
      
    }
    
  }
  
  private static class TestClassTwoWrapper extends FlutterWrapper {
    private final TestClassTwo $value;

    public TestClassTwoWrapper(ChannelGenerated $channelGenerated, String $uniqueId, TestClassTwo $value) {
      super($channelGenerated, $uniqueId);
      this.$value = $value;
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }

    
    private TestClassTwoWrapper(ChannelGenerated $channelGenerated, final String $uniqueId) {
      super($channelGenerated, $uniqueId);
      this.$value = new TestClassTwo();
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }
    
    
    static Object onStaticMethodCall(ChannelGenerated $channelGenerated, MethodCall call) throws NotImplementedException {
      switch(call.method) {
        
        case "TestClassTwo()": {
            new TestClassTwoWrapper($channelGenerated, (String) call.argument("$uniqueId"));
            return null;
          }
        
        default:
          throw new NotImplementedException(call.method);
      }
    }

    @Override
    public Object onMethodCall(MethodCall call) throws NotImplementedException {
      switch(call.method) {
        case "TestClassTwo#allocate":
          allocate();
          return null;
        case "TestClassTwo#deallocate":
          deallocate();
          return null;
        
        default:
          throw new NotImplementedException(call.method);
      }
    }
    
    @Override
    public Object $getValue() {
      return $value;
    }

    
  }
  
  private static class TestGenericClassWrapper extends FlutterWrapper {
    private final TestGenericClass $value;

    public TestGenericClassWrapper(ChannelGenerated $channelGenerated, String $uniqueId, TestGenericClass $value) {
      super($channelGenerated, $uniqueId);
      this.$value = $value;
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }

    
    private TestGenericClassWrapper(ChannelGenerated $channelGenerated, final String $uniqueId) {
      super($channelGenerated, $uniqueId);
      this.$value = new TestGenericClass();
      $channelGenerated.addWrapper($uniqueId, this, $channelGenerated.tempWrappers);
    }
    
    
    static Object onStaticMethodCall(ChannelGenerated $channelGenerated, MethodCall call) throws NotImplementedException {
      switch(call.method) {
        
        case "TestGenericClass()": {
            new TestGenericClassWrapper($channelGenerated, (String) call.argument("$uniqueId"));
            return null;
          }
        
        default:
          throw new NotImplementedException(call.method);
      }
    }

    @Override
    public Object onMethodCall(MethodCall call) throws NotImplementedException {
      switch(call.method) {
        case "TestGenericClass#allocate":
          allocate();
          return null;
        case "TestGenericClass#deallocate":
          deallocate();
          return null;
        
        case "TestGenericClass#setValue":
          return setValue(call);
        
        case "TestGenericClass#get":
          return get(call);
        
        default:
          throw new NotImplementedException(call.method);
      }
    }
    
    @Override
    public Object $getValue() {
      return $value;
    }

    
     Object setValue(MethodCall call) {
      
      
      
      $value.setValue(
      
      $channelGenerated.getWrapper((String) call.argument("value")) == null ? call.argument("value") : $channelGenerated.getWrapper((String) call.argument("value")).$getValue()
      
      )
      
      ;
      return null;
      
    }
    
     Object get(MethodCall call) {
      
      final Object result = 
      
      
      $value.get(
      
      )
      
      ;
      if (result == null) return null;

      final Class wrapperClass;
      try {
        wrapperClass = Class.forName(String.format("com.example.penguin_usage.ChannelGenerated$%sWrapper", result.getClass().getSimpleName()));
      } catch (ClassNotFoundException e) {
        return result;
      }

      try {
        final Constructor constructor = wrapperClass.getConstructor(ChannelGenerated.class, String.class, result.getClass());
        constructor.newInstance($channelGenerated, call.argument("$newUniqueId"), result);
      } catch (NoSuchMethodException e) {
        e.printStackTrace();
      } catch (IllegalAccessException e) {
        e.printStackTrace();
      } catch (InstantiationException e) {
        e.printStackTrace();
      } catch (InvocationTargetException e) {
        e.printStackTrace();
      }
      return null;
      
    }
    
  }
  
}
