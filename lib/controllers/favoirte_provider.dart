import '../views/shared/export_packages.dart';

class FavoriteNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');
  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];
  List<dynamic> _fav = [];

  List<dynamic> get ids => _ids;

  set ids(List<dynamic> newId) {
    _ids = newId;
    notifyListeners();
  }

  List<dynamic> get favorites => _favorites;

  set favoitres(List<dynamic> newFav) {
    _favorites = newFav;
    notifyListeners();
  }

  List<dynamic> get fav => _fav;

  set fav(List<dynamic> newFav) {
    _fav = newFav;
    notifyListeners();
  }

  getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);

      return {"key": key, "id": item["id"]};
    }).toList();

    _favorites = favData.toList();
    _ids = _favorites.map((item) => item['id']).toList();
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
  }

  Future<void> deleteFav(int key) async {
    await _favBox.delete(key);
  }

  getAllFav() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);

      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        "category": item['category'],
        "price": item['price'],
        "imageUrl": item['imageUrl'],
      };
    }).toList();

    _fav = favData.reversed.toList();
  }
}
