class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SignOutSuccess extends SettingsState {}

final class SignOutFailure extends SettingsState {
  final String errorMessage;

  SignOutFailure(this.errorMessage);
}
