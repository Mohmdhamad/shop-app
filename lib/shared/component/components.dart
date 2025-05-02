import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (Route<dynamic> route) => false,
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required String? Function(String?) validate,
  Function(String)? onChange,
  Function(String)? onSubmit,
  VoidCallback? onTap,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isPassword = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix),
      )
          : null,
      border: const OutlineInputBorder(),
    ),
    onChanged: onChange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: validate,
  );
}

Widget defaultFloatingButton({
  double width = double.infinity,
  double radius = 15.0,
  bool isUpperCase = false,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase(): text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
    );
Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
})=>TextButton(onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase(): text,
    style: TextStyle(
      fontSize: 17.0,
    ),
    ),
);

void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor:  chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates {SUCCESS,ERROR,WARNING}

  Color chooseToastColor(ToastStates state){
  late Color color ;
  switch(state){
    case ToastStates.SUCCESS:
    color =  Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
  }