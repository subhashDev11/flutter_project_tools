import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import '../core/utils/utils.dart';
import 'package:http/http.dart' as http;


class HttpService {
  HttpService.instance({required this.baseUrl});
  final String baseUrl;
  Future<dynamic> getRandom(String url) async {
    dynamic responseJson;
    final header = ({
      'Accept': 'application/json',
    });

    try {
      reqLogger(url, 'GET');
      final response = await http.get(
        Uri.parse(url),
        headers: header,
      );
      responseJson = _response(response, url, 'GET');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String path, {String? token}) async {
    dynamic responseJson;
    final header = ({
      'Accept': 'application/json',
    });

    if (token != null) {
      header['Authorization'] = 'Bearer $token';
    }
    try {
      reqLogger(baseUrl + path, 'GET', token: token);
      final response = await http.get(
        Uri.parse(baseUrl + path),
        headers: header,
      );
      responseJson = _response(response, baseUrl + path, 'GET');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response, String uri, String reqType) {
    final cdt = DateTime.now();
    try {
      final cdt = DateTime.now();
      switch (response.statusCode) {
        case 200:
          AppLogger.i('Parsed $uri $reqType at $cdt  \n res -> ${response.body}');
          dynamic responseJson;
          try {
            responseJson = json.decode(response.body.toString());
          } catch (e) {
            responseJson = response.body;
          }
          AppLogger.i('Parsed $uri $reqType at $cdt  \n data res -> $responseJson');
          return responseJson;
        case 400:
          AppLogger.e(
              'Error Code 400 for $uri ${reqType.toUpperCase()} at $cdt  \n error res -> ${response.body.toString()}');
          AppLogger.e('Parsed $uri $reqType at $cdt  \n res -> ${response.body}');
          dynamic responseJson;
          try {
            responseJson = json.decode(response.body.toString());
          } catch (e) {
            responseJson = response.body;
          }
          return responseJson;
        case 401:
          dynamic responseJson;
          try {
            responseJson = json.decode(response.body.toString());
          } catch (e) {
            responseJson = response.body;
          }
          AppLogger.e('Error Code 401 for $uri ${reqType.toUpperCase()} at $cdt with res-> $responseJson');
          return responseJson;
        case 403:
          AppLogger.e(
              'Error Code 403 for $uri ${reqType.toUpperCase()} at $cdt  \n error res -> ${response.body.toString()}');
          dynamic responseJson;
          try {
            responseJson = json.decode(response.body.toString());
          } catch (e) {
            responseJson = response.body;
          }
          return responseJson;
        case 500:
          AppLogger.e(
              'Error Code 500 for $uri ${reqType.toUpperCase()} at $cdt  \n error res -> ${response.body.toString()}');
          dynamic responseJson;
          try {
            responseJson = json.decode(response.body.toString());
          } catch (e) {
            responseJson = response.body;
          }
          return responseJson;
        default:
          AppLogger.e(
              'Error occurred while Communication with Server with StatusCode : ${response.statusCode} for request ${baseUrl + uri} ${reqType.toUpperCase()} at $cdt  \n error res -> ${response.body.toString()}');
          if (response.body != null) {
            dynamic responseJson;
            try {
              responseJson = json.decode(response.body.toString());
            } catch (e) {
              responseJson = response.body;
            }
            return responseJson;
          } else {
            throw FetchDataException(
                'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
          }
      }
    } catch (e) {
      AppLogger.e('Exception for request- $uri ${reqType.toUpperCase()} at $cdt  \n with exception -> ${e.toString()}');
      return ({
        'success': false,
        'status': response.statusCode,
        'message': 'Bad access exception',
      });
    }
  }

  Future<dynamic> post({required String path, String? token, dynamic data}) async {
    dynamic responseJson;

    final header = ({
      //'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    if (token != null) {
      header['Authorization'] = 'Bearer $token';
    }
    try {
      reqLogger(
        '${baseUrl}$path, data -> $data',
        'POST',
      );
      final pdata = json.encode(data);
      log('log data -> $pdata ');
      final response = await http.post(
        Uri.parse(
          baseUrl + path,
        ),
        body: pdata,
        headers: header,
      );
      //final res = http.Request('POST', Uri.parse(baseUrl + path));
      //res.body = jsonEncode(data).toString();
      //res.headers.addAll(header);
      //var streamResponse = await res.send();
      //final response = await http.Response.fromStream(streamResponse);
      responseJson = _response(response, baseUrl + path, 'POST');
    } catch (e) {
      AppLogger.e('Failed to Post Data at -> ${baseUrl + path} $e');
      throw FetchDataException('Failed to Post Data at -> ${baseUrl + path} $e');
    }
    return responseJson;
  }

  Future<dynamic> uploadFile(
      {required String path,
      String? token,
      required String filePath,
      String? previousValue,}) async {
    dynamic responseJson;
    final header = ({
      //'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    if (token != null) {
      header['Authorization'] = 'Bearer $token';
    }
    try {
      reqLogger(
        '${baseUrl}$path, file -> $filePath',
        'POST FILE',
      );
      var uploadURI = Uri.parse(baseUrl + path);
      // http.MultipartRequest request = http.MultipartRequest("POST", uploadURI);
      // request.headers.addAll(header);
      // http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      //   'uploaded_file',
      //   filePath,
      // );
      // request.files.add(multipartFile);
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest('POST', uploadURI);
      request.fields.addAll({
        'previous_value': '$previousValue',
      });
      request.files.add(await http.MultipartFile.fromPath(
        'uploaded_file',
        filePath,
      ));

      request.headers.addAll(headers);

      http.StreamedResponse streamResponse = await request.send();

      final response = await http.Response.fromStream(streamResponse);
      responseJson = _response(response, baseUrl + path, 'POST File');
    } catch (e) {
      AppLogger.e('Failed to Post File at -> ${baseUrl + path} $e');
      throw FetchDataException('Failed to Post File at -> ${baseUrl + path} $e');
    }
    return responseJson;
  }

  void reqLogger(String uri, String reqType, {String? data, String? token}) {
    final cdt = DateTime.now();
    AppLogger.i(
        'New ${reqType.toUpperCase()} for $uri at $cdt ${data != null ? 'with req body -> $data' : 'with token -> $token'} ');
  }
}

class CustomException implements Exception {
  final String message;
  final String? prefix;

  CustomException({required this.message, this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException(String message) : super(message: message, prefix: "Error During Communication:");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message: message, prefix: "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message: message, prefix: "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException(String message) : super(message: message, prefix: "Invalid Input: ");
}

class CustomResponse {
  final String message;
  final bool isSuccess;
  final dynamic data;

  CustomResponse({required this.isSuccess, required this.data, required this.message});
}
