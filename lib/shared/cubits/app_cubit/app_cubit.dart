import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/modules/categories/categories_screen.dart';
import 'package:shop/modules/products/products_screen.dart';
import 'package:shop/modules/settings/settings_screen.dart';
import 'package:shop/shared/component/constants.dart';
import 'package:shop/shared/cubits/app_cubit/app_states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

import '../../../modules/favorites/favorites_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0 ;
  List <Widget> bottomScreens =[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomNav( int index){
    currentIndex= index;
    emit(ChangeBottomNavState());
  }
   HomeModel? homeModel;
  void getHomeData (){
    emit(LoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token: token,
        ).then((value){
          homeModel=HomeModel.fromJson(value.data);
          printFullText(homeModel!.data.banners[0].id.toString());
          print(homeModel!.status);
          emit(SuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorHomeDataState(error.toString()));
    });
  }


}