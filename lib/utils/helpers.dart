class Helpers {
  static bool boolVal(int? v) {
    return v != 0 ? true : false;
  }

  static int intVal(bool? v) {
    return v != false ? 1 : 0;
  }
}
