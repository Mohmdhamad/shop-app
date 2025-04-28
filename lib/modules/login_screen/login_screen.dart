import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/register_screen/regestir_screen.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/cubits/login_cubit/login_cubit.dart';
import 'package:shop/shared/cubits/login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar:AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text('LOGIN',
                          style:Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login To Browse Our Hot Offers',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 25.0,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (String? value){
                            if (value!.isEmpty){
                              return 'email address cannot be empty';
                            }
                          },
                        ),
                        SizedBox(height: 20.0,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.text,
                            label: 'Password',
                            isPassword: true,
                            suffix: Icons.visibility_outlined,
                            suffixPressed: (){

                            },
                            prefix: Icons.lock_outline_rounded,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'Password cannot be empty';
                              }
                            }),
                        SizedBox(height: 31.0,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                          builder:(context)=> defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(email: emailController.text,
                                  password: passwordController.text,);
                              }
                            },
                            text: 'Login',
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          children: [
                            Text('Don\'t have an account ?',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            Spacer(),
                            defaultTextButton(function: (){
                              navigateTo(context, RegestirScreen());
                            },
                                text: 'Register now'),
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
