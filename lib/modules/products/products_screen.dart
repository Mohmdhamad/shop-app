import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:shop/shared/cubits/app_cubit/app_states.dart';
import 'package:shop/shared/styles/colors/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: homeCubit.homeModel != null && homeCubit.categoriesModel != null,
          builder: (context) => homeBuilder(homeCubit.homeModel!,homeCubit.categoriesModel!,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel homeModel,CategoriesModel categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items:
              homeModel.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        defaultVerticalSeparator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(width: 25.0,),
              Icon(
                Icons.menu,
              ),
            ],
          ),
        ),
        defaultVerticalSeparator(),
        Container(height: 100.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>categoriesBuilder(categoriesModel.data.data[index]),
              separatorBuilder:(context,index) =>Container(
                color: defaultPagesColor,
                width: 10.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categoriesModel.data.data.length,
          ),
        ),
        defaultVerticalSeparator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'New Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        defaultVerticalSeparator(),
        Container(
          color: defaultPagesColor,
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 7.0,
            mainAxisSpacing: 7.0,
            childAspectRatio: 1 / 1.53,
            children: List.generate(
              homeModel.data.products.length,
              (index) => productBuilder(homeModel.data.products[index],context),
            ),
          ),
        ),
      ],
    ),
  );
  Widget categoriesBuilder(DataModelOfCategories model)=>Stack(
  alignment: Alignment.bottomCenter,
  children: [
  Image(image: NetworkImage(model.image,),
  width: 100.0,
  height: 100.0,
  fit: BoxFit.cover,
  ),
  Container(
  width: 100.0,
  decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.7),
  borderRadius: BorderRadiusDirectional.circular(7.5),
  ),
  child: Text(
  model.name,
  textAlign: TextAlign.center,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
  color: Colors.white,
  ),
  ),
  ),
  ],
  );
  Widget productBuilder(ProductModel model,context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadiusDirectional.circular(7.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 190.0,
            ),
            if (model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.amber,
                child: Text('DISCOUNT',
                    style: TextStyle(fontSize: 11.0)),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3, fontSize: 14.0),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(fontSize: 13.0, color: defaultColor),
                  ),
                  SizedBox(width: 7.0),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: AppCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                    child: IconButton(onPressed: (){
                      print(model.id);
                    },
                        icon: Icon(
                          color: Colors.white,
                          Icons.favorite_border_outlined,
                          size: 21.0,
                        ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Widget defaultVerticalSeparator()=>Container(
  height: 7.0,
  color: defaultPagesColor,
  );

}
