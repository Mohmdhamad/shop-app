import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubits/login_cubit/login_states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },).then((value){
          print(value.data);
          emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }
}