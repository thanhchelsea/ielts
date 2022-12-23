import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:logger/logger.dart';
import '../index.dart';
import '../repositories/error_handlers.dart';
import '../repositories/exceptions/index.dart';

class BaseRepository {
  var logger = Logger();
  Dio get dioClient => DioProvider.dioWithHeaderToken;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;
      if (response.statusCode == HttpStatus.ok ||
          (response.data as Map<String, dynamic>)['statusCode'] == HttpStatus.ok) {
        int status = (response.data as Map<String, dynamic>)['status'] as int;
        if (status != Configs.SUCCESS) {
          String statusMessage = ClientUltis.convertStatus(status);
          throw handleError(statusMessage);
        }
      }
      return response;
    } on DioError catch (dioError) {
      Exception exception = handleDioError(dioError);
      logger.e("Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}");
      throw exception;
    } catch (error) {
      // logger.e("Generic error: >>>>>>> $error");
      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
