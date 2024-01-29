mixin CrudDataSource<T> {
  Future<List<T>> getAll();
  Future<bool> create(T item);
  Future<bool> update(T item);
  Future<bool> delete(T item);
  T? get(int id) {
    return null;
  }
}
