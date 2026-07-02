import 'package:meta_model_transformer/meta/meta.dart';

@Transform()
class Usu {
  Usu();
  
  factory Usu.fromJson(Map<String, dynamic>? json) {
    return Usu();
  }
}