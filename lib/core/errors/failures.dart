abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Please check your internet connection.',
  ]);
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Something went wrong on our end. Please try again later.',
  ]);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure([
    super.message = 'Invalid email or password.',
  ]);
}

class EmailNotVerifiedFailure extends Failure {
  const EmailNotVerifiedFailure([super.message = 'Email not verified.']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized request.']);
}

class DuplicateFailure extends Failure {
  const DuplicateFailure([super.message = 'Email is already registered.']);
}

class InvalidCodeFailure extends Failure {
  const InvalidCodeFailure([super.message = 'Invalid or expired code.']);
}

class RateLimitFailure extends Failure {
  const RateLimitFailure([
    super.message = 'Too many requests. Please try again later.',
  ]);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found.']);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure([super.message = 'Invalid request.']);
}

class OtherFailure extends Failure {
  const OtherFailure([super.message = 'An unexpected error occurred.']);
}
