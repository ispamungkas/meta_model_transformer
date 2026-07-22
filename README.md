# Model Parser

A code generation package that automatically converts raw JSON data into strongly typed Dart model objects using generics.

Instead of manually calling each model's `fromJson()` method, this package generates a parser registry and resolves the appropriate parser based on the requested generic type.

## Features

- 🚀 Automatically parse `Map<String, dynamic>` into model objects.
- 📦 Automatically parse `List<dynamic>` into `List<T>`.
- ⚡ Type-safe API using Dart generics.
- 🔧 Generates parser registry using `build_runner`.
- 📝 Eliminates repetitive `fromJson()` calls throughout your project.

## Getting started

Add the package to your project by referencing a tagged release from GitHub.

```yaml
dependencies:
  meta_model_transformer:
    git:
      url: https://github.com/ispamungkas/meta_model_transformer.git
      ref: ^latest_version

dev_dependencies:
  meta_model_transformer:
      git:
        url: https://github.com/ispamungkas/meta_model_transformer.git
        ref: ^latest_version
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
