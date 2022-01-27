Map<String, dynamic> deepMergeMap(
    Map<String, dynamic> source, Map<String, dynamic> changes) {
  source.forEach((k, v) {
    if (!changes.containsKey(k)) {
      changes[k] = v;
    } else {
      if (changes[k] is Map) {
        deepMergeMap(Map<String, dynamic>.from(changes[k]),
            Map<String, dynamic>.from(source[k]));
      } else {
        changes[k] = source[k];
      }
    }
  });

  return changes;
}
