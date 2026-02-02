/// Base class for API results
sealed class ApiResult<T> {
  const ApiResult();
}

/// Success result
class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

/// Error result
class ApiError<T> extends ApiResult<T> {
  final String message;
  final int? statusCode;
  
  const ApiError(this.message, {this.statusCode});
}

/// Extension methods for ApiResult
extension ApiResultExtension<T> on ApiResult<T> {
  /// Check if result is success
  bool get isSuccess => this is ApiSuccess<T>;

  /// Check if result is error
  bool get isError => this is ApiError<T>;

  /// Get data if success, null otherwise
  T? get dataOrNull => this is ApiSuccess<T> ? (this as ApiSuccess<T>).data : null;

  /// Get error message if error, null otherwise
  String? get errorOrNull => this is ApiError<T> ? (this as ApiError<T>).message : null;

  /// Transform the result
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, int? statusCode) error,
  }) {
    return switch (this) {
      ApiSuccess<T>(:final data) => success(data),
      ApiError<T>(:final message, :final statusCode) => error(message, statusCode),
    };
  }

  /// Transform only success case
  ApiResult<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      ApiSuccess<T>(:final data) => ApiSuccess(transform(data)),
      ApiError<T>(:final message, :final statusCode) => ApiError(message, statusCode: statusCode),
    };
  }
}
