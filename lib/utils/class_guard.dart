import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta_model_transformer/meta/meta.dart';
import 'package:source_gen/source_gen.dart';

class ClassGuard {
  static bool isClassHasField(String fieldName, {required ClassElement data}) {
    for (final FieldElement field in data.fields) {
      if (field.name == null || field.name == '') return false;
      if (field.name == fieldName) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> guardData(AssetId file, BuildStep buildStep) async {
    if (file.path.endsWith('x.dart')) return true;
    if (!await buildStep.resolver.isLibrary(file)) return true;

    return false;
  }

  static Future<
    (bool annotationIsEmpty, Iterable<AnnotatedElement> dataElements)
  >
  checkFileContainAnnotation(
    String annotationName, {
    required AssetId file,
    required BuildStep buildStep,
  }) async {
    final LibraryElement library = await buildStep.resolver.libraryFor(file);

    Iterable<AnnotatedElement> data = LibraryReader(
      library,
    ).annotatedWith(TypeChecker.typeNamedLiterally(annotationName));

    return (data.isEmpty, data);
  }

  static bool isValidFromJson(ClassElement classElement) {
    final ConstructorElement? construct = classElement.constructors
        .where((ConstructorElement element) => element.name == 'fromJson')
        .firstOrNull;

    if (construct == null) return false;

    if (construct.formalParameters.isEmpty) return false;

    final FormalParameterElement firstParameter =
        construct.formalParameters.first;

    if (!firstParameter.type.isDartCoreMap) return false;

    return true;
  }

  final MetaUse data = MetaUse(field: 'data');
}
