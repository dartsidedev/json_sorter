import 'dart:convert';

/// Make a copy of a JSON serializable object with the keys sorted.
dynamic sortedCopy(dynamic x) {
  if (x is Map) {
    return {
      for (final k in x.keys.toList()..sort()) k: sortedCopy(x[k]),
    };
  } else if (x is List) {
    return x.map(sortedCopy).toList();
  }
  return x;
}

/// Converts [object] to a JSON string with its keys sorted.
///
/// For more info, see [jsonEncode].
String jsonSortedEncode(Object? object,
        {Object? Function(Object? nonEncodable)? toEncodable}) =>
    jsonEncode(sortedCopy(object), toEncodable: toEncodable);

/// This class sorts map keys before converting JSON objects to strings.
///
/// For more information, see [JsonEncoder].
class JsonSortedEncoder extends JsonEncoder {
  /// Creates a JSON encoder where all maps are sorted.
  ///
  /// For more info, see [JsonEncoder].
  const JsonSortedEncoder([Object? Function(dynamic object)? toEncodable])
      : super(toEncodable);

  /// Creates a JSON encoder that creates multi-line JSON with sorted map keys.
  ///
  /// For more info, see [JsonEncoder.withIndent].
  const JsonSortedEncoder.withIndent(indent,
      [Object? Function(dynamic object)? toEncodable])
      : super.withIndent(indent, toEncodable);

  /// Converts [object] to a JSON [String] where all map keys are sorted.
  @override
  String convert(Object? object) {
    final sorted = sortedCopy(object);
    return super.convert(sorted);
  }
}
