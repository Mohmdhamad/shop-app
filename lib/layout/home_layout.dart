import 'package:flutter/material.dart';
import 'package:shop/modules/login_screen/login_screen.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Salla',
        ),
      ),
      body: defaultTextButton(
        function: (){
          CacheHelper.removeData(key:'token').then((value){
            if(value) {
              navigateAndFinish(context, LoginScreen());
            }
          });
        },
          text: 'sign out',
          isUpperCase: true,
      ),
    );
  }
}
