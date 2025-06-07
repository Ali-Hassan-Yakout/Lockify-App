import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  onObscureChange() => emit(ObscureChange());

  onLoadingChange() => emit(LoadingChange());

  onLanguageChange() => emit(LanguageChange());

  onThemeChange() => emit(ThemeChange());
}
