import 'my_array.dart';

typedef Mapper<R, E> = R Function(E element);

typedef Predicate<E> = bool Function(E element);

typedef FlatMapper<R, E> = MyArray<R> Function(E element);

typedef Reducer<A, E> = A Function(A acc, E element);
