import 'dart:io';

import 'package:dio/dio.dart';

String handleError(error) {
  if (error is Exception) {
    try {
      String errorDescription = "";
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.CANCEL:
            errorDescription = "Request cancelled";
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            errorDescription = "Connection timeout";
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioErrorType.DEFAULT:
            errorDescription = "No internet connection";
            break;
          case DioErrorType.RESPONSE:
            switch (error.response.statusCode) {
              case 400:
                errorDescription = 'Unauthorised request';
                break;
              case 401:
                errorDescription = 'Unauthorised request';
                break;
              case 403:
                errorDescription = 'Unauthorised request';
                break;
              case 404:
                errorDescription = 'Not found';
                break;
              case 409:
                errorDescription = "Error due to a conflict";
                break;
              case 408:
                errorDescription = "Connection request timeout";
                break;
              case 500:
                errorDescription = "Internal Server Error";
                break;
              case 503:
                errorDescription = "Service Unavailable";
                break;
              default:
                errorDescription =
                    "Received invalid status code: ${error.response.statusCode}";
            }
            break;
          case DioErrorType.SEND_TIMEOUT:
            errorDescription = "Send timeout in connection with API server";
            break;
        }
      } else if (error is SocketException) {
        errorDescription ='No Internet connection';
           } else {
        errorDescription = "Unexpected error occured";
      }
      return errorDescription;
    } on FormatException catch (e) {
      print(e.toString());
      throw FormatException("Unable to process the data");
    } catch (e) {
      return "Unexpected error occured";
    }
  } else {
    if (error.toString().contains("is not a subtype of")) {
      return "Unable to process the data";
    } else {
      return "Unexpected error occured";
    }
  }
}



