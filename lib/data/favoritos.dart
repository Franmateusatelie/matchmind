class Favoritos {
  static final List<String> times = [];

  static bool isFavorito(String time) {
    return times.contains(time);
  }

  static void toggle(String time) {
    if (times.contains(time)) {
      times.remove(time);
    } else {
      times.add(time);
    }
  }
}
