import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final String? Function(String?) validator;
  final IconData icon;
  final bool obscureText;
  final Function() onTap;
  final TextInputType input;

  const TextForm(this.controller, this.text, this.validator, this.icon,
      this.obscureText, this.onTap, this.input,
      {Key? key, maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: input,
      onTap: onTap,
      validator: validator,
      maxLines: obscureText ? 1 : null,
      obscureText: obscureText,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0.0),
          labelText: text,
          hintText: text,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
