
import 'package:crud_operations/app/common/data/crud_data_source.dart';
import 'package:crud_operations/app/common/repository/repository_helper.dart';
import 'package:crud_operations/app/data/user/api/user_api.dart';
import 'package:crud_operations/app/data/user/model/user.dart';
import 'package:dartz/dartz.dart';

class UserRepository with RepositoryHelper<User> {
  final CrudDataSource dataSource;

  UserRepository({required this.dataSource});

  Future<Either<String, List<User>>> getUsers({Gender? gender, UserStatus? status}) async {
    // return checkItemsFailOrSuccess(userApi.getUsers(gender: gender, status: status));
    return checkItemsFailOrSuccess(dataSource.getAll() as Future<List<User>>);
  }

  Future<Either<String, bool>> createUser(User user) async {
    return checkItemFailOrSuccess(dataSource.create(user));
  }

  Future<Either<String, bool>> updateUser(User user) async {
    return checkItemFailOrSuccess(dataSource.update(user));
  }

  Future<Either<String, bool>> deleteUser(User user) async {
    return checkItemFailOrSuccess(dataSource.delete(user));
  }
}
