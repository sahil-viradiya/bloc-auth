abstract class AuthState {}

class Init extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

class Failed extends AuthState {
  String message;

  Failed(this.message);
}
