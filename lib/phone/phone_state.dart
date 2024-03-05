abstract class PhoneState {}

class Init extends PhoneState {}

class Loading extends PhoneState {}

class Loaded extends PhoneState {}

class Failed extends PhoneState {
  String message;

  Failed(this.message);
}
