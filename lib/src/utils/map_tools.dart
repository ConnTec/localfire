Map<String, dynamic> deepMergeMap(
  Map<String, dynamic> source,
  Map<String, dynamic> changes,
) {
  changes.forEach((k, v) {
    if (source.containsKey(k) && changes[k] is Map && source[k] is Map) {
      source[k] = deepMergeMap(Map<String, dynamic>.from(source[k]),
          Map<String, dynamic>.from(changes[k]));
    } else {
      source[k] = v;
    }
  });

  return source;
}
