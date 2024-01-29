import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:dartz/dartz.dart';

enum ApiState { loading, failure, success }

mixin BaseController {
  Rx<ApiState> apiStatus = ApiState.loading.obs;
  Rx<String> errorMessage = "".obs;

  _checkRequestStatus(Either<String, bool> failureOrSuccess) {
    failureOrSuccess.fold(
      (String failure) {
        apiStatus.value = ApiState.failure;
        errorMessage = failure.obs;
      },
      (bool success) {
        apiStatus.value = ApiState.success;
      },
    );
  }

  _apiRunRquestTemplate(Future<Either<String, bool>> apiCallback) async {
    apiStatus.value = ApiState.loading;
    Either<String, bool> failureOrSuccess = await apiCallback;
    _checkRequestStatus(failureOrSuccess);
  }

  void createItem(Future<Either<String, bool>> apiCallback) async {
    _apiRunRquestTemplate(apiCallback);
  }

  void updateItem(Future<Either<String, bool>> apiCallback) async {
    _apiRunRquestTemplate(apiCallback);
  }

  void deleteItem(Future<Either<String, bool>> apiCallback) async {
    _apiRunRquestTemplate(apiCallback);
  }
}
