class LoginException implements Exception {
  String message;

  LoginException(this.message);
}

class RegistrationException implements Exception {
  String message;

  RegistrationException(this.message);
}

class ForgotPasswordException implements Exception {
  String message;

  ForgotPasswordException(this.message);
}
