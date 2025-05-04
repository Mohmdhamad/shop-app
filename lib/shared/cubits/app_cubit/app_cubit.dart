import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
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
  Map<int,bool> favorites = {};
  void getHomeData (){
    emit(LoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token: token,
        ).then((value){
          homeModel=HomeModel.fromJson(value.data);
           homeModel!.data.products.forEach((element){
            favorites.addAll({
              element.id:element.inFavorites,
            });
          });
          print(homeModel!.status);
          print(favorites.toString());
          emit(SuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData (){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorCategoriesDataState(error.toString()));
    });
  }

}