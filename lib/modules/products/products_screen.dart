import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:shop/shared/cubits/app_cubit/app_states.dart';
import 'package:shop/shared/styles/colors/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: homeCubit.homeModel != null,
          builder: (context) => homeBuilder(homeCubit.homeModel!),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel model) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        CarouselSlider(
          items:
              model.data.banners
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
        SizedBox(height: 11.0),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 7.0,
            mainAxisSpacing: 7.0,
            childAspectRatio: 1 / 1.53,
            children: List.generate(
              model.data.products.length,
              (index) => productBuilder(model.data.products[index]),
            ),
          ),
        ),
      ],
    ),
  );

  Widget productBuilder(ProductModel model) => Container(
    color: Colors.white,
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
                  IconButton(onPressed: (){

                  },
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        size: 21.0,
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
}
