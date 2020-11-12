import 'package:rxdart/rxdart.dart';

typedef OnInitStream<E> = E Function();

class LazyStream<E> {
  OnInitStream<E> _onInitStream;

  LazyStream([OnInitStream<E> onInitStream]) {
    this._onInitStream = onInitStream ?? () => null;
  }

  BehaviorSubject<E> _element;

  BehaviorSubject<E> get() {
    if (_element == null) {
      _element = BehaviorSubject.seeded(_onInitStream.call());
    }
    return _element;
  }

  void add(E element) {
    get().sink.add(element);
  }

  Stream<E> get stream => get().stream;

  E get value => get().value;

  void close() {
    get().close();
    _element = null;
  }
}
