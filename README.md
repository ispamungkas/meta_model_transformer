# Meta Model Transformer

A code generation package that automatically converts raw JSON data into strongly typed Dart model objects using generics.

Instead of manually calling each model's `fromJson()` method, this package generates a parser registry and resolves the appropriate parser based on the requested generic type.

## Features

- 🚀 Automatically parse `Map<String, dynamic>` into model objects.
- 📦 Automatically parse `List<dynamic>` into `List<T>`.
- ⚡ Type-safe API using Dart generics.
- 🔧 Generates parser registry using `build_runner`.
- 📝 Eliminates repetitive `fromJson()` calls throughout your project.

## Getting started

Add the package to your project.

```yaml
dependencies:
  meta_model_transformer: ^latest_version

dev_dependencies:
  build_runner: ^latest_version
```

Run code generation:

```bash
flutter pub run build_runner build
```

or

```bash
dart run build_runner build
```

If generated files already exist, you can overwrite them with:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🚀 Usage

### 1. Annotate the generic container

Annotate the generic wrapper with `@MetaUse`.

The `field` parameter specifies which property contains the raw JSON that will be transformed.

```dart
@MetaUse(field: 'data')
class Isi<T> {
  const Isi({this.data});

  final dynamic data;
}
```

#### Requirements

- `field` is **required**.
- The specified field **must exist** in the annotated class.
- The field should contain either:
  - `Map<String, dynamic>`, or
  - `List<dynamic>`.

---

### 2. Annotate your models

Annotate every model that should be included in the generated parser registry.

```dart
@Transform()
class Sample {
  Sample();

  factory Sample.fromJson(Map<String, dynamic>? json) {
    return Sample();
  }
}
```

Multiple models are supported.

```dart
@Transform()
class Sample2 {
  Sample2();

  factory Sample2.fromJson(Map<String, dynamic>? json) {
    return Sample2();
  }
}
```

---

## ✅ Requirements for @Transform

A class annotated with `@Transform()` **must** satisfy the following requirements:

- The class must expose a `factory fromJson(Map<String, dynamic>? json)` constructor.
- The `fromJson()` constructor must return an instance of the annotated class.
- The class must be accessible by the code generator.

For example:

```dart
@Transform()
class User {
  User();

  factory User.fromJson(Map<String, dynamic>? json) {
    return User();
  }
}
```

---

## 🧩 Compatible with json_serializable

`@Transform()` can be used together with `json_serializable`.

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@Transform()
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory User.fromJson(Map<String, dynamic> json)
      => _$UserFromJson(json);

  Map<String, dynamic> toJson()
      => _$UserToJson(this);
}
```

---

## ❄️ Compatible with Freezed

`@Transform()` can also be combined with `freezed`.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Transform()
@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json)
      => _$UserFromJson(json);
}
```

---

### 3. Generate the parser registry

Run the generator.

```bash
dart run build_runner build
```

or

```bash
flutter pub run build_runner build
```

---

### 4. Parse JSON

#### Single object

```dart
final sample = Isi<Sample>(
  data: json,
).getData();
```

#### List of objects

```dart
final samples = Isi<List<Sample>>(
  data: jsonList,
).getData();
```

The generated parser registry automatically selects the correct parser based on the requested generic type.

## Additional information

### Supported input types

| Raw data | Result |
|----------|--------|
| `Map<String, dynamic>` | `T` |
| `List<dynamic>` | `List<T>` |

### Exceptions

`getData()` throws an exception when:

- The provided data is neither a `Map` nor a `List`.
- No parser has been generated for the requested generic type.

### Code generation

Whenever you add or modify a registered model, regenerate the parser registry:

```bash
flutter pub run build_runner build
```

or

```bash
dart run build_runner build
```

### Contributing

Contributions, bug reports, and feature requests are welcome. Please open an issue or submit a pull request if you'd like to improve the package.