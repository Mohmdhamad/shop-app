import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:shop/shared/cubits/app_cubit/app_states.dart';
import 'package:shop/shared/styles/colors/colors.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildCategoryItem(AppCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder:(context,index) =>Container(
            color: defaultPagesColor,
            height:12.0,
          ),
          itemCount: AppCubit.get(context).categoriesModel!.data.data.length ,
        );
      },
    ) ;
  }
  Widget buildCategoryItem(DataModelOfCategories model)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image),
          height: 125.0,
          width: 125.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(model.name,
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
