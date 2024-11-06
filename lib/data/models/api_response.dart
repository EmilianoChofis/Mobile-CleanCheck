class ApiResponse<T> {
  final T data;
  final bool error;
  final int statusCode;
  final String message;

  ApiResponse({
    required this.data,
    required this.error,
    required this.statusCode,
    required this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse(
      data: fromJsonT(json['data']),
      error: json['error'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
