import 'package:flutter/material.dart';

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

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
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
        color: background,
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
})=>TextButton(onPressed: function,
    child: Text(text.toUpperCase(),
    style: TextStyle(
      fontSize: 17.0,
    ),
    ),
);
