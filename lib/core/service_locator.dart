class ServiceLocator {
  ServiceLocator._();

  static final Map<String, dynamic> _manifest = {};

  static void single<T>(T instance) {
    final key = T.toString();

    _manifest[key] = instance;
  }

  static void factory<T>(T Function() constructor) {
    final key = T.toString();

    _manifest[key] = constructor;
  }

  static T find<T>() {
    final key = T.toString();

    final result = _manifest[key];

    assert(result != null, "$T is not found");

    if (result is Function) {
      return result() as T;
    }

    return result as T;
  }
}
