import 'package:excelerate_inquisit/models/program_model.dart';

class Favorites {
  static final List<Program> _favorites = [];

  static List<Program> get favorites => _favorites;

  static void add(Program program) {
    if (! _favorites.any((p) => p.id == program.id)) {
      _favorites.add(program);
    }
  }

  static void remove(Program program) {
    _favorites.removeWhere((p) => p.id == program.id);
  }

  static bool isFavorited(Program program) {
    return _favorites.any((p) => p.id == program.id);
  }
}