import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:shop/shared/cubits/app_cubit/app_states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, State) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text('Salla',),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                  icon: Icon(Icons.search_rounded),
                ),
              ],
              ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,),
              label: 'Home',
              ),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded,),
              label: 'Categories',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.favorite,),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings,),
              label: 'Settings',
            ),
          ],),
          );

      },
    );
  }
}
