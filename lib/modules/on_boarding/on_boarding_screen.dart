import 'package:flutter/material.dart';
import 'package:shop/modules/login_screen/login_screen.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> board = [
    BoardingModel(
      image: 'assets/images/grocery.png',
      title: 'On board Screen one title',
      body: 'on board screen one body',
    ),
    BoardingModel(
      image: 'assets/images/grocery.png',
      title: 'ON board screen two',
      body: 'on board screen two body',
    ),
    BoardingModel(
      image: 'assets/images/grocery.png',
      title: 'ON board screen three title',
      body: 'on board screen three body',
    ),
  ];
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: defaultTextButton(function: submit, text: 'skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder:
                    (context, index) => buildBoardingItem(board[index]),
                itemCount: board.length,
                onPageChanged: (int index) {
                  if (index == board.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 25.0),
            SmoothPageIndicator(
              controller: boardController,
              count: board.length,
              effect: ExpandingDotsEffect(activeDotColor: defaultColor),
            ),
            Row(
              children: [
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 770),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(model.image))),
      SizedBox(height: 30.0),
      Text(model.title, style: TextStyle(fontSize: 25.0)),
      SizedBox(height: 20.0),
      Text(model.body, style: TextStyle(fontSize: 20.0)),
      SizedBox(height: 30.0),
    ],
  );
}
