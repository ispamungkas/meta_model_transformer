#!/bin/bash

# Tentukan path target folder
TARGET_DIR="model_parser/lib/example"

# 1. Buat folder lib/example jika belum ada
echo "📁 Create a directory $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

# 2. Membuat file lib/example/isi.dart
echo "📝 Writing into $TARGET_DIR/isi.dart..."
cat << 'EOF' > "$TARGET_DIR/isi.dart"
import 'package:model_parser/meta/meta.dart';

// @MetaUse(field: 'data')
// class Isi<T>{
//   const Isi({this.data});

//   final dynamic data;
// }

@MetaUse(field: 'data')
abstract class Aca<T>{
  factory Aca({required dynamic data}) = _AcaImpl<T>;
  
  dynamic get data;
}

class _AcaImpl<T> implements Aca<T>{
  const _AcaImpl({required this.data});

  @override
  final dynamic data;
}
EOF

# 3. Membuat file lib/example/sample.dart
echo "📝 Writing into $TARGET_DIR/sample.dart..."
cat << 'EOF' > "$TARGET_DIR/sample.dart"
import 'package:model_parser/meta/meta.dart';

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
EOF

# 4. Membuat file lib/example/usu.dart
echo "📝 Writing into $TARGET_DIR/usu.dart..."
cat << 'EOF' > "$TARGET_DIR/usu.dart"
import 'package:model_parser/meta/meta.dart';

@Transform()
class Usu {
  Usu();
  
  factory Usu.fromJson(Map<String, dynamic>? json) {
    return Usu();
  }
}

class Camat {
  Camat();
  
}
EOF

# 5. Cek status akhir eksekusi
if [ $? -eq 0 ]; then
    echo "========================================="
    echo "✅ Create files successfully:"
    echo "  📍 $TARGET_DIR/isi.dart"
    echo "  📍 $TARGET_DIR/sample.dart"
    echo "  📍 $TARGET_DIR/usu.dart"
    echo "========================================="
else
    echo "❌ Something went wrong."
fi