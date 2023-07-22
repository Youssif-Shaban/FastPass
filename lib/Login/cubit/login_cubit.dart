import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/loginModel.dart';
import '../../network/remote/dio_Helper.dart';
import 'login_states.dart';

class CartaLoginCubit extends Cubit<CartaLoginStates> {
  CartaLoginCubit() : super(CartaLoginInitialState());
  static CartaLoginCubit get(context) => BlocProvider.of(context);

  late CartaLoginModel cartaloginmodel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(CartaLoginLoadingState());
    DioHelper.postData(
      url: 'http://192.168.234.142:4242/users/login',
      data: {
        'user_email': email,
        'user_password': password,
      },
    ).then((value) {
      print(value.data);
      cartaloginmodel = CartaLoginModel.fromJson(value.data);
      print(value.data['message']);
      print(cartaloginmodel.data?.usernationality);

      emit(CartaLoginSuccessState(cartaloginmodel));
    }).catchError((error) {
      print(error.toString());
      emit(CartaLoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisiibility() {
    isPassword = !isPassword;
    // suffix =
    //     isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(CartaLoginPasswordState());
  }
}
