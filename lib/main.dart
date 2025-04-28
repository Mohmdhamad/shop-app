import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/cubits/bloc_observer.dart';
import 'package:shop/shared/cubits/theme_cubit/theme_cubit.dart';
import 'package:shop/shared/cubits/theme_cubit/theme_states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/themes/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  // await CacheHelper.init();
  // bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(false));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (BuildContext context) =>
          AppThemeCubit()..changeThemeMode(fromShared: isDark),
        ),
        // BlocProvider(
        //   create:
        //       (BuildContext context) =>
        //   NewsCubit()
        //     ..getBusiness()
        //     ..getSports(),
        // ),
      ],
      child: BlocConsumer<AppThemeCubit, AppThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme:darkTheme ,
            themeMode:
              AppThemeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
