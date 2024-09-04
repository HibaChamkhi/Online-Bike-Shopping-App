
import '../error/exception.dart';

String mapExceptionToMessage(Exception exception) {
  if (exception is ServerException) {
    return 'Server error: ${exception.message}';
  } else if (exception is NetworkException) {
    return 'Network error: ${exception.message}';
  } else {
    return 'Unexpected error occurred. Please try again later.';
  }
}