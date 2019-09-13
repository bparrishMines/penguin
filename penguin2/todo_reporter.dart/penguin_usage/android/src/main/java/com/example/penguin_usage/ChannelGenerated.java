package com.example.penguin_usage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import start.now;


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
    } catch (WrapperNotFoundException e) {
      e.printStackTrace();
    } catch (NoUniqueIdException e) {
      e.printStackTrace();
    } finally {
      tempWrappers.clear();
    }
  }
  
  public Object onMethodCall(MethodCall call) throws NoUniqueIdException, WrapperNotFoundException {
    switch(call.method) {
      case "Invoke":
        Object value = null;
        final ArrayList<HashMap<String, Object>> allMethodCallData = (ArrayList<HashMap<String, Object>>) call.arguments;
        for(HashMap<String, Object> methodCallData : allMethodCallData) {
          final String method = (String) methodCallData.get("method");;
          final HashMap<String, Object> arguments = (HashMap<String, Object>) methodCallData.get("arguments");
          final MethodCall methodCall = new MethodCall(method, arguments);
          value = onMethodCall(methodCall);
        }
        return value;
      default:
        final String uniqueId = call.argument("uniqueId");
        if (uniqueId == null) throw new NoUniqueIdException(call.method);
        
        final FlutterWrapper wrapper = getWrapper(uniqueId);
        if (wrapper == null) throw new WrapperNotFoundException(uniqueId);
        
        return wrapper.onMethodCall(call);
    }
  }
  
  private class Banana extends FlutterWrapper {
    private final Banana banana;

    Banana(String uniqueId, Banana banana) {
      super(uniqueId);
      this.banana = banana;
      addWrapper(uniqueId, this, tempWrappers);
    }
    
    @Override
    public Object onMethodCall(MethodCall call) {
      return null;
    }

    
    Object method() {
      return banana.method();
    }
    
  }
  
  private class Apple extends FlutterWrapper {
    private final Apple apple;

    Apple(String uniqueId, Apple apple) {
      super(uniqueId);
      this.apple = apple;
      addWrapper(uniqueId, this, tempWrappers);
    }
    
    @Override
    public Object onMethodCall(MethodCall call) {
      return null;
    }

    
  }
  

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
  