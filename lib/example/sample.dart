import 'package:meta_model_transformer/meta/meta.dart';

@Transform()
class Sample {
  Sample();

  factory Sample.fromJson(Map<String, dynamic>? json) {
    return Sample();
  }
}

@Transform()
class Sample2{

  Sample2();

  factory Sample2.fromJson(Map<String, dynamic>? json) {
    return Sample2();
  }
}