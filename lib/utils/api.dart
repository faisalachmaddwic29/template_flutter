import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/api_response.dart';
import 'config.dart';

class Api {
  static BaseOptions dioOptions = new BaseOptions(
    baseUrl: endpoint,
    connectTimeout: 60000 * 10, //10menit
    receiveTimeout: 60000 * 10, //10menit
  );
  static Response response;
  static Dio dio = new Dio(dioOptions);

  InterceptorsWrapper interceptors() {
    return InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError e) {
      return e;
    });
  }
  // https://github.com/dangquanuet/MovieDB-Flutter/blob/develop/lib/data/repositories/movie_repository.dart

  Future<ApiResponse> apiResponse(
    String type, {
    String url,
    String token,
    Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
  }) async {
    String errorMessageKey = 'server_error';
    String errorMessage = 'Terjadi kesalahan sistem, coba lagi nanti!';

    try {
      dio.interceptors.add(interceptors());
      Options options = Options(headers: {
        "Accept": "multipart/form-data",
        "Content-Type": "multipart/form-data"
      });
      if (token != null) {
        options = Options(
            headers: {"Authorization": "$token", "Accept": "application/json"});
      }

      Response endpoint;
      if (type == 'post') {
        FormData formData = FormData.fromMap(data);
        print(formData.fields);
        endpoint = await dio.post(
          url,
          data: formData,
        );
      } else if (type == 'put') {
        FormData formData = FormData.fromMap(data);
        endpoint = await dio.post(url, data: formData, options: options);
      } else if (type == 'delete') {
        endpoint = await dio.delete(url, options: options);
      } else {
        endpoint = await dio.get(url,
            options: options, queryParameters: queryParameters);
      }
      var dataResponse = endpoint.data;

      print(endpoint.data['status']);
      return ApiResponse(
        status: dataResponse,
        data: dataResponse,
        message: endpoint.statusMessage,
        messageKey: 'success',
        messages: 'success_response',
        statusCode: endpoint.statusCode,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT) {
        errorMessageKey = 'conection_timeout';
        errorMessage = 'Koneksi internet Anda tidak stabil';
      }
      if (e.type == DioErrorType.CANCEL) {
        errorMessageKey = 'conection_cancel';
        errorMessage = 'Permintaan Anda dibatalkan';
      }
      if (e.type == DioErrorType.DEFAULT) {
        errorMessageKey = 'error_default';
        // errorMessage = 'Tidak ada konesksi internet';
      }
      if (e.type == DioErrorType.RESPONSE) {
        dynamic dataError = e.response.data;
        bool isRedirectToHome = false;
        // List<String> authKey = [
        //   'token_expired',
        //   'token_invalid',
        //   'user_not_verified',
        //   'token_required',
        //   'user_not_found',
        //   'user_is_lock'
        // ];
        // if (authKey.contains(dataError['exp'])) {
        //   isRedirectToHome = true;
        // }
        print(dataError);
        return ApiResponse(
          isRedirectToHome: isRedirectToHome,
          data: dataError,
          status: dataError,
          message: e.response.statusMessage,
          messageKey: 'error_response',
          messages: 'error_response',
          statusCode: e.response.statusCode,
        );
      }
      return ApiResponse(
        data: null,
        status: false,
        message: errorMessage,
        messageKey: errorMessageKey,
        messages: 'Error',
        statusCode: 0,
      );
    }
  }
}

class ApiRepository extends Api {
  Future<ApiResponse> apiGet(
    String url, {
    String token,
    Map<String, dynamic> queryParameters,
  }) async {
    return await apiResponse('get',
        url: url, queryParameters: queryParameters, token: token);
  }

  Future<ApiResponse> apiPost(
    String url, {
    @required Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
    String token,
  }) async {
    return await apiResponse('post',
        url: url, data: data, token: token, queryParameters: queryParameters);
  }

  Future<ApiResponse> apiDelete(String url, {String token}) async {
    return await apiResponse('delete', url: url, token: token);
  }

  Future<ApiResponse> apiPut(
    String url, {
    String token,
    @required Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
  }) async {
    return await apiResponse('put',
        url: url, data: data, token: token, queryParameters: queryParameters);
  }
}
