import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/buttons/clickable.dart';
import 'package:fripay/views/utils/globalwidget/space.dart';

import '../../../gen/colors.gen.dart';



class AppTextformField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final String? Function(String?)? validator;
  const AppTextformField(
      {super.key,
      required this.controller,
      this.obscure = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}

class AuthTextformField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final bool next;
  final String label;
  final String ? hintext;
  final void Function()? onClick;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool suffix;
  final int cas;
  final IconData? iconData;
  final TextInputType? input_type;
  const AuthTextformField(
      {super.key,
      required this.controller,
      this.obscure = false,
      this.validator,
      this.cas = 1,

      required this.next,
      required this.label,
      required this.onClick,
      required this.suffix,
      this.input_type,
      this.iconData,
        this.hintext,
        this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return
    cas==1?
      TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      onChanged: onChanged,
      keyboardType: input_type ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: next ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(
            color: ColorName.webCardAuthLabelColor,
            fontWeight: FontWeight.w400),
        suffixIcon: suffix
            ? Clickable(
                onClick: onClick!,
                child: Icon(
                  iconData,
                  color: Colors.grey,
                ),
              )
            : null,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(05))),
      ),
    ):
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
          context.textStyle(fontWeight: FontWeight.bold, fontSize: 15,
          colour: Colors.black),
        ),
        Space.verticale(heigth: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          keyboardType: input_type ?? TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: next ? TextInputAction.next : TextInputAction.done,
          decoration: InputDecoration(
            hintText:hintext ,
            hintStyle: const TextStyle(
                color: ColorName.webCardAuthLabelColor,
                fontWeight: FontWeight.w400),
            suffixIcon: suffix
                ? Clickable(
              onClick: onClick!,
              child: Icon(
                iconData,
                color: Colors.grey,
              ),
            )
                : null,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(03))),
          ),
        )
      ],
    )

    ;
  }
}

class WalletformField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final bool text;
  final bool next;
  final String title;
  final String? Function(String?)? validator;
  const WalletformField(
      {super.key,
      required this.controller,
      this.obscure = false,
      this.text = false,
      this.validator,
      this.next = true,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 9),
            child: Text(
              title,
              style:
                  context.textStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),
          !text
              ? TextFormField(
                  controller: controller,
                  obscureText: obscure,
                  validator: validator,
                  textInputAction:
                      next ? TextInputAction.next : TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                )
              : TextFormField(
                  controller: controller,
                  obscureText: obscure,
                  validator: validator,
                  keyboardType: TextInputType.text,
                  textInputAction:
                      next ? TextInputAction.next : TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                )
        ],
      ),
    );
  }
}
