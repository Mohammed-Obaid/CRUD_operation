import 'package:crud_operations/app/core/api_config.dart';
import 'package:crud_operations/app/common/data/crud_data_source.dart';
import 'package:crud_operations/app/data/user/model/user.dart';
import 'package:crud_operations/app/network/api_helper.dart';
import 'package:crud_operations/app/network/dio_client.dart';

class UserApi with CrudDataSource<User>, ApiHelper<User> {
  final DioClient dioClient;
  UserApi({required this.dioClient});

  @override
  Future<List<User>> getAll() async {
        //  await makeGetSingletItemRequest(
        // dioClient.dio.get(ApiConfig.users), User.fromJson);
    return await makeGetRequest(
        dioClient.dio.get(ApiConfig.users), User.fromJson);
  }

  @override
  Future<bool> create(User item) async {
    return await postRequest(dioClient.dio.post(ApiConfig.users, data: item));
  }

  @override
  Future<bool> update(User item) async {
    return await putRequest(dioClient.dio.put('${ApiConfig.users}/${item.id}',data: item));
  }

  @override
  Future<bool> delete(User item) async{
    return deleteRequest(dioClient.dio.delete('${ApiConfig.users}/${item.id}'));
    
  }
}
