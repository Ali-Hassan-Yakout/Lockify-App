part of 'app_manager_cubit.dart';

sealed class AppManagerState {}

final class AppManagerInitial extends AppManagerState {}

final class ObscureChange extends AppManagerState {}

final class LoadingChange extends AppManagerState {}

final class LanguageChange extends AppManagerState {}

final class ThemeChange extends AppManagerState {}
