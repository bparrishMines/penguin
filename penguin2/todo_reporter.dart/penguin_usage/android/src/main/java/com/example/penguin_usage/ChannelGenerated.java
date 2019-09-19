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
  private abstract class FlutterWrapper {
    private final String uniqueId;
    
    FlutterWrapper(String uniqueId) {
      this.uniqueId = uniqueId;
    }

    abstract Object onMethodCall(MethodCall call) throws NotImplementedException;

    void allocate() {
      if (isAllocated(uniqueId)) return;
      addWrapper(uniqueId, this, allocatedWrappers);
    }

    void deallocate() {
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
          new TestClassWrapper((String) call.argument("uniqueId"));
          return null;
        }
      
      case "TestClassTwo()": {
          new TestClassTwoWrapper((String) call.argument("uniqueId"));
          return null;
        }
      
      case "TestGenericClass()": {
          new TestGenericClassWrapper((String) call.argument("uniqueId"));
          return null;
        }
      
      default:
        final String uniqueId = call.argument("uniqueId");
        if (uniqueId == null) throw new NoUniqueIdException(call.method);

        final FlutterWrapper wrapper = getWrapper(uniqueId);
        if (wrapper == null) throw new WrapperNotFoundException(uniqueId);

        return wrapper.onMethodCall(call);
    }
  }

  
  private class TestClassWrapper extends FlutterWrapper {
    private final TestClass testClass;

    TestClassWrapper(String uniqueId, TestClass testClass) {
      super(uniqueId);
      this.testClass = testClass;
      addWrapper(uniqueId, this, tempWrappers);
    }

    
    private TestClassWrapper(final String uniqueId) {
      super(uniqueId);
      this.testClass = new TestClass();
      addWrapper(uniqueId, this, tempWrappers);
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
        
        default:
          throw new NotImplementedException(call.method);
      }
    }

    
    Object aMethod(MethodCall call) {
      
      
      
      testClass.aMethod(
      
      )
      
      ;
      return null;
      
    }
    
    Object getStringMethod(MethodCall call) {
      
      return
      
      
      testClass.getStringMethod(
      
      )
      
      ;
      
    }
    
    Object addTwo(MethodCall call) {
      
      return
      
      
      testClass.addTwo(
      
      call.argument("value") == null ? null : (Integer) call.argument("value")
      
      )
      
      ;
      
    }
    
    Object divide(MethodCall call) {
      
      return
      
      
      testClass.divide(
      
      call.argument("one") == null ? null : (Integer) call.argument("one")
      ,
      call.argument("two") == null ? null : (Integer) call.argument("two")
      
      )
      
      ;
      
    }
    
    Object getList(MethodCall call) {
      
      return
      
      
      testClass.getList(
      
      call.argument("addThese") == null ? null : (HashMap<Integer, Integer>) call.argument("addThese")
      
      )
      
      ;
      
    }
    
    Object giveUsage2(MethodCall call) {
      
      return
      
      
      testClass.giveUsage2(
      
      ((TestClassTwoWrapper) getWrapper((String) call.argument("usage2"))).testClassTwo
      
      )
      
      ;
      
    }
    
    Object getUsage2(MethodCall call) {
      
      new TestClassTwoWrapper((String) call.argument("$newUniqueId"),
      
      
      testClass.getUsage2(
      
      )
      
      );
      return null;
      
    }
    
  }
  
  private class TestClassTwoWrapper extends FlutterWrapper {
    private final TestClassTwo testClassTwo;

    TestClassTwoWrapper(String uniqueId, TestClassTwo testClassTwo) {
      super(uniqueId);
      this.testClassTwo = testClassTwo;
      addWrapper(uniqueId, this, tempWrappers);
    }

    
    private TestClassTwoWrapper(final String uniqueId) {
      super(uniqueId);
      this.testClassTwo = new TestClassTwo();
      addWrapper(uniqueId, this, tempWrappers);
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

    
  }
  
  private class TestGenericClassWrapper extends FlutterWrapper {
    private final TestGenericClass testGenericClass;

    TestGenericClassWrapper(String uniqueId, TestGenericClass testGenericClass) {
      super(uniqueId);
      this.testGenericClass = testGenericClass;
      addWrapper(uniqueId, this, tempWrappers);
    }

    
    private TestGenericClassWrapper(final String uniqueId) {
      super(uniqueId);
      this.testGenericClass = new TestGenericClass();
      addWrapper(uniqueId, this, tempWrappers);
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

    
    Object setValue(MethodCall call) {
      
      
      
      testGenericClass.setValue(
      
      (String) call.argument("value")
      
      )
      
      ;
      return null;
      
    }
    
    Object get(MethodCall call) {
      
      final Object result = 
      
      
      testGenericClass.get(
      
      )
      
      ;
      if (result == null) return null;
      
      final Class wrapperClass;
      try {
        wrapperClass = Class.forName(result.getClass() + "Wrapper");
      } catch (ClassNotFoundException e) {
        return result;
      }

      try {
        final Constructor constructor = wrapperClass.getConstructor(String.class, result.getClass());
        constructor.newInstance(call.argument("$newUniqueId"), result);
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
