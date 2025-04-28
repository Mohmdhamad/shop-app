import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/theme_cubit/theme_states.dart';
import '../../network/local/cache_helper.dart';


class AppThemeCubit extends Cubit<AppThemeStates> {
  AppThemeCubit() : super(AppThemeInitialState());
  static AppThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeMode());

    } else {
      isDark = !isDark;
      emit(AppChangeThemeMode());

    }
    // CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
    }
  }

