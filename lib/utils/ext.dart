StringBuffer writeExtension({
  required String baseClass,
  required List<Object> registry,
  required String fieldName,
}) {
  final StringBuffer ext = StringBuffer();
  ext.write('''

extension ${baseClass}ToObj<T> on $baseClass<T> {
  Map<String, dynamic Function()> _registry() => {

    // Registry List<T> object
${writeListOutputData(registry, fieldName)}
    // Registry <T> object
${writeOutputData(registry, fieldName)}
  };

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

    final String key = isList ? '_\${dataType}lst' : '_\$dataType';

    final parser = _registry()[key];

    if (parser == null) {
      throw Exception('Unsupported type');
    }

    return parser() as T;

  }
}

''');

  return ext;
}

String writeOutputData(List<Object> registry, String baseDataName) {
  final StringBuffer listBaseBuffer = StringBuffer();
  for (final Object data in registry) {
    listBaseBuffer.write('''
    '_${data.toString()}' : () =>  $data.fromJson($baseDataName),
''');
  }

  return listBaseBuffer.toString();
}

String writeListOutputData(List<Object> registry, String baseDataName) {
  final StringBuffer listBaseBuffer = StringBuffer();
  for (final Object data in registry) {
    listBaseBuffer.write('''
    '_${data.toString()}lst' : () => ($baseDataName as List?)?.map((e) => $data.fromJson(e as Map<String, dynamic>)).toList(),
''');
  }

  return listBaseBuffer.toString();
}
