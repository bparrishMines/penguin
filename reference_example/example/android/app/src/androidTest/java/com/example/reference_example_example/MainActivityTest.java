package com.example.reference_example_example;

import com.example.reference_example.MyReferencePairManager;

import androidx.test.rule.ActivityTestRule;
import io.flutter.plugin.common.BinaryMessenger;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static org.junit.Assert.assertTrue;
import static org.mockito.ArgumentMatchers.anyDouble;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

@RunWith(MyRunner.class)
public class MainActivityTest {
  TestReferencePairManager testManager;

  @Rule
  public ActivityTestRule<MainActivity> rule = new ActivityTestRule<>(MainActivity.class, true, false);

  public void init(BinaryMessenger messenger) {
    testManager = new TestReferencePairManager(messenger);
    testManager.initialize();
  }

  @Test
  public void testMyClass() {
    verify(testManager.mockMyApiClass).myMethod(eq(23.0d), eq("MyOtherClass"));
  }
}