abstract class Option<T> {}

class Some<T> implements Option<T> {
  final T value;

  const Some(this.value);
}

class None<T> implements Option<T> {
  const None();
}
