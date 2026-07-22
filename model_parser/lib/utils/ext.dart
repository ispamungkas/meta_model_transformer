StringBuffer writeExtension({
  required String baseClass,
  required List<Object> registry,
  required String fieldName,
}) {
  final StringBuffer ext = StringBuffer();
  ext.write('''
/// Converts the raw JSON data into the requested generic type [T].
///
/// This method automatically resolves the appropriate parser from the
/// generated registry based on the generic type provided.
///
/// Supported conversions:
/// - [Map<String, dynamic>] → [T]
/// - [List<dynamic>] → [List<T>]
///
/// Throws an [Exception] if:
/// - The raw data is neither a `Map` nor a `List`.
/// - No parser is registered for the requested generic type.
extension ${baseClass}ToObj<T> on $baseClass<T> {

  T getData() {
    // Prevent data doesn't containt [Map, List]
    if (data is! Map && data is! List) {
      throw Exception('Unsupported type');
    }

    // Get T data type
    String dataType = T.toString();
    bool isList = false;

    if (dataType.startsWith('List<')) {
      isList = true;
      dataType = dataType.substring(5, dataType.length - 1);
    }

    dataType = dataType.replaceAll(RegExp(r'<dynamic>'), '');

    final String key = isList ? '_\${dataType}lst' : '_\$dataType';

    final parser = _\$MetaModelTransformer.parseClosure[key];

    if (parser == null) {
      throw Exception('\${T.toString()} class not registered, please add @Transform() on \${T.toString()} class');
    }

    return parser(data) as T;

  }
}''');

  return ext;
}

String writeOutputData(List<Object> registry, String baseDataName) {
  final StringBuffer listBaseBuffer = StringBuffer();
  for (final Object data in registry) {
    listBaseBuffer.write('''
    '_${data.toString()}' : (data) =>  $data.fromJson(data),
''');
  }

  return listBaseBuffer.toString();
}

String writeListOutputData(List<Object> registry, String baseDataName) {
  final StringBuffer listBaseBuffer = StringBuffer();
  for (final Object data in registry) {
    listBaseBuffer.write('''
    '_${data.toString()}lst' : (data) => (data as List?)?.map((e) => $data.fromJson(e as Map<String, dynamic>)).toList(),
''');
  }

  return listBaseBuffer.toString();
}
