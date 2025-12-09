import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _keyFavorites = 'favorite_courses';

  Future<List<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? ids = prefs.getStringList(_keyFavorites);
    if (ids == null) return [];
    return ids.map((id) => int.parse(id)).toList();
  }

  Future<void> toggleFavorite(int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ids = prefs.getStringList(_keyFavorites) ?? [];
    final String idStr = courseId.toString();

    if (ids.contains(idStr)) {
      ids.remove(idStr);
    } else {
      ids.add(idStr);
    }

    await prefs.setStringList(_keyFavorites, ids);
  }

  Future<bool> isFavorite(int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> ids = prefs.getStringList(_keyFavorites) ?? [];
    return ids.contains(courseId.toString());
  }
}
