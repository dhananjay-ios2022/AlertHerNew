import 'dart:io';

class ApiResponse<T> {
  int statusCode;
  T? body;

  ApiResponse({required this.statusCode, this.body});

  factory ApiResponse.success(T body) {
    return ApiResponse(statusCode: 200, body: body);
  }

  factory ApiResponse.error(int statusCode) {
    return ApiResponse(statusCode: statusCode);
  }
}


enum ApiStatusCode {
  success200(HttpStatus.ok), // 200
  created201(HttpStatus.created), // 201
  badRequest400(HttpStatus.badRequest), // 400
  unauthorized401(HttpStatus.unauthorized), // 401
  tooManyRequests429(HttpStatus.tooManyRequests); // 429

  final int value;
  const ApiStatusCode(this.value);
}

