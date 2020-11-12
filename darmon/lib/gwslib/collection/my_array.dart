import 'dart:collection';

import 'interfaces.dart';

class MyArray<E> extends Iterable<E> {
  static MyArray<Object> empty = MyArray._([]);

  static List<T> addAll<T>(List<T> data1, List<T> data2) {
    List<T> result = [];
    result.addAll(data1);
    result.addAll(data2);
    return result;
  }

  static bool containsList<E>(Iterable<E> list, Predicate<E> predicate) {
    return list.firstWhere(predicate, orElse: () => null) != null;
  }

  static E findItem<E>(Iterable<E> list, Predicate<E> predicate) {
    return list.firstWhere(predicate, orElse: () => null);
  }

  factory MyArray.fromPrivate(Iterable<E> data) {
    return data == null ? empty : MyArray<E>._(data);
  }

  factory MyArray.emptyArray() {
    return MyArray.from(List<E>());
  }

  factory MyArray.from(Iterable<E> data) {
    return MyArray.fromPrivate(data);
  }

  List<E> _data;
  Map<Object, E> _map;
  Mapper<Object, E> _mapper;

  MyArray._(Iterable<E> data) {
    this._data = data is List ? data : data.toList();
  }

  E get(int index) => _data[index];

  bool hasNull() => contains(null);

  Iterable<E> toIterable() {
    return this._data.toList();
  }

  void checkNotNull() {
    if (hasNull()) {
      throw new Exception("list has null element");
    }
  }

  MyArray<E> filter(Predicate<E> predicate) {
    if (predicate == null || isEmpty) {
      return this;
    } else {
      List<E> result = [];
      _data.forEach((element) {
        if (predicate.call(element)) {
          result.add(element);
        }
      });
      return MyArray.from(result);
    }
  }

  MyArray<E> filters(Predicate<E> predicateA, Predicate<E> predicateB) {
    if (predicateA == null && predicateB == null) {
      return this;
    }
    if (isEmpty) {
      return this;
    } else {
      List<E> result = [];
      _data.forEach((element) {
        if ((predicateA != null && predicateA.call(element)) &&
            (predicateB != null && predicateB.call(element))) {
          result.add(element);
        }
      });
      return MyArray.from(result);
    }
  }

  MyArray<E> filterNotNull() => filter((element) => element != null);

  int findFirstPosition(Predicate<E> predicate) {
    for (int i = 0; i < length; i++) {
      if (predicate.call(get(i))) {
        return i;
      }
    }
    return -1;
  }

  int findPosition<K>(K key, Mapper<K, E> mapper) {
    return findFirstPosition((element) => mapper.call(element) == key);
  }

  E findFirst(Predicate<E> predicate) {
    final index = findFirstPosition(predicate);
    if (index == -1) return null;
    return get(index);
  }

  bool containsPredicate(Predicate<E> predicate) => findFirstPosition(predicate) != -1;

  bool containsMapper<K>(K key, Mapper<K, E> mapper) => find(key, mapper) != null;

  MyArray<R> flatMap<R>(FlatMapper<R, E> flatMapper) {
    if (isEmpty) {
      return empty;
    }
    List<R> result = new List();
    forEach((element) {
      result.addAll(flatMapper.call(element));
    });
    return MyArray.from(result);
  }

  void makeKeyMap(Mapper<Object, E> mapper) {
    if (_map == null) {
      this._mapper = mapper;
      this._map = HashMap();

      forEach((element) {
        final key = mapper.call(element);
        if (_map.containsKey(key)) {
          throw new Exception("MyArray key duplicate found key=$key");
        }
        this._map[key] = element;
      });
    }
  }

  E find<K>(K key, Mapper<K, E> mapper) {
    if (isEmpty) {
      return null;
    }
    if (this._map == null) {
      makeKeyMap(mapper);
    }
    if (this._mapper != mapper) {
      throw new Exception("not proper key adapter used");
    }
    return this._map[key];
  }

  void checkUnique<K>(Mapper<K, E> mapper) {
    if (isNotEmpty && map == null) {
      makeKeyMap(mapper);
    }
  }

  A reducer<A>(A acc, Reducer<A, E> reducer) {
    if (isEmpty) {
      return acc;
    }

    A result = acc;
    forEach((element) {
      result = reducer.call(result, element);
    });
    return result;
  }

  MyArray<E> sort(int compare(E a, E b)) {
    List<E> result = new List();
    result.addAll(this._data);
    result.sort(compare);
    return MyArray.from(result);
  }

  MyArray<E> prepend(E element) {
    List<E> result = List();
    result.add(element);
    result.addAll(this._data);
    return MyArray.from(result);
  }

  MyArray<E> append(E element) {
    List<E> result = new List();
    result.addAll(this._data);
    result.add(element);
    return MyArray.from(result);
  }

  MyArray<E> appendAll(MyArray<E> that) {
    if (isEmpty) {
      return that;
    } else if (that.isEmpty) {
      return this;
    }
    List<E> result = new List();
    result.addAll(this._data);
    result.addAll(that._data);
    return MyArray.from(result);
  }

  MyArray<E> union<K>(MyArray<E> that, Mapper<K, E> mapper) {
    if (this.isEmpty) {
      return that;
    } else if (that.isEmpty) {
      return this;
    }

    List<E> list = List();
    forEach((element) {
      K key = mapper.call(element);
      if (!this.containsMapper(key, mapper)) {
        list.add(element);
      }
    });
    if (list.isEmpty) {
      return this;
    } else {
      return appendAll(MyArray.from(list));
    }
  }

  @override
  Iterator<E> get iterator => this._data.iterator;
}
