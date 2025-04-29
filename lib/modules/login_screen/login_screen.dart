import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/home_layout.dart';
import 'package:shop/modules/register_screen/register_screen.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/cubits/login_cubit/login_cubit.dart';
import 'package:shop/shared/cubits/login_cubit/login_states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateAndFinish(context, HomeLayout());
              });
            } else {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login To Browse Our Hot Offers',
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(color: Colors.black54),
                        ),
                        SizedBox(height: 25.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'email address cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.text,
                          label: 'Password',
                          isPassword: loginCubit.isVisible,
                          suffix: loginCubit.suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              loginCubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffixPressed: () {
                            loginCubit.changeVisibility();
                          },
                          prefix: Icons.lock_outline_rounded,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 31.0),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          fallback:
                              (context) =>
                                  Center(child: CircularProgressIndicator()),
                          builder:
                              (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    loginCubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'Login',
                              ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Spacer(),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'Register Now',
                              isUpperCase: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
