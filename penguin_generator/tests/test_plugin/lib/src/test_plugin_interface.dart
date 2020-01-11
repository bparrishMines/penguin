import 'dart:async';

import 'package:penguin/penguin.dart';

abstract class TestClass1 {
  @Field()
  set mutableField(FutureOr<double> value);

  @Field()
  FutureOr<double> get mutableField;

  @Method()
  Future<void> returnVoid();

  @Method()
  Future<String> returnString();

  @Method()
  Future<int> returnInt();

  @Method()
  Future<double> returnDouble();

  @Method()
  Future<bool> returnBool();

  @Method()
  Future<List<double>> returnList();

  @Method()
  Future<Map<String, int>> returnMap();

  @Method()
  Future<Object> returnObject();

  @Method()
  Future<dynamic> returnDynamic();

  @Field()
  FutureOr<int> get intField;

  @Field()
  Future<String> get stringField;

  @Field()
  Future<double> get doubleField;

  @Field()
  Future<bool> get boolField;

  @Field(nameOverride: 'nameOverrideField')
  Future<double> get notAField;
}

abstract class TestClass2 {}

abstract class GenericClass<T> {
  @Method()
  Future<void> add(T object);

  @Method()
  Future<T> get(String identifier);
}
