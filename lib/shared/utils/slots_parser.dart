import 'dart:convert';

/// Parses the JSON-encoded slot array stored in weapons and armor pieces.
/// Returns an empty list for null, empty string, or malformed JSON.
List<int> parseSlots(String? json) {
  if (json == null || json.isEmpty) return [];
  try {
    final decoded = jsonDecode(json);
    if (decoded is! List) return [];
    return decoded.whereType<int>().toList();
  } catch (_) {
    return [];
  }
}
