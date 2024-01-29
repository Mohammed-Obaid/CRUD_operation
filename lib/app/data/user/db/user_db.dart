import 'package:crud_operations/app/common/data/crud_data_source.dart';
import 'package:crud_operations/app/data/user/model/user.dart';
import 'package:crud_operations/app/db/database.dart';

class UserDB with CrudDataSource<User> {
  final DatabaseHelper _dbHelper =
      DatabaseHelper.instance; 

  @override
  Future<bool> create(User item) async {
    try {
      final id = await _dbHelper.insertUser(item);
      return id > 0; 
    } catch (e) {
      _handleDatabaseError("Error creating user", e);
      return false;
    }
  }

  @override
  Future<bool> delete(User item) async {
    try {
      final id = item.id;
      if (id == null) {
        throw Exception("Cannot delete user without an ID");
      }
      final rowsDeleted = await _dbHelper.deleteUser(item);
      return rowsDeleted > 0;
    } catch (e) {
      _handleDatabaseError("Error deleting user", e);
      return false;
    }
  }

  @override
  Future<List<User>> getAll() async {
    try {
      final usersData = await _dbHelper.fetchAllUsers();
      return usersData;
    } catch (e) {
      _handleDatabaseError("Error fetching users", e);
      return []; 
    }
  }

  @override
  Future<bool> update(User item) async {
    try {
      final id = item.id;
      if (id == null) {
        throw Exception("Cannot update user without an ID");
      }
      final rowsUpdated = await _dbHelper.updateUser(item);
      return rowsUpdated > 0;
    } catch (e) {
      _handleDatabaseError("Error updating user", e);
      return false;
    }
  }

  /// Centralized error handling for database operations
  void _handleDatabaseError(String message, dynamic error) {
    print('$message: $error');
   
  }
}
