import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fripay/theme/app_theme.dart';
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
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm)),
      ),
    );
  }
}

class AuthTextformField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final bool next;
  final String label;
  final String? hintext;
  final void Function()? onClick;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool suffix;
  final int cas;
  final IconData? iconData;
  final IconData? prefixIcon;
  final TextInputType? input_type;
  final List<TextInputFormatter>? inputFormatters;
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
      this.prefixIcon,
      this.hintext,
      this.onChanged,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final prefix = prefixIcon != null
        ? Icon(prefixIcon,
            color: scheme.onSurface.withValues(alpha: 0.5), size: 22)
        : null;

    return cas == 1
        ? TextFormField(
            controller: controller,
            obscureText: obscure,
            validator: validator,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            keyboardType: input_type ?? TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: next ? TextInputAction.next : TextInputAction.done,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(
                  color: ColorName.webCardAuthLabelColor,
                  fontWeight: FontWeight.w400),
              prefixIcon: prefix,
              suffixIcon: suffix
                  ? Clickable(
                      onClick: onClick!,
                      child: Icon(
                        iconData,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm)),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    colour: scheme.onSurface),
              ),
              Space.verticale(heigth: 8),
              TextFormField(
                controller: controller,
                obscureText: obscure,
                validator: validator,
                onChanged: onChanged,
                inputFormatters: inputFormatters,
                keyboardType: input_type ?? TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction:
                    next ? TextInputAction.next : TextInputAction.done,
                decoration: InputDecoration(
                  hintText: hintext,
                  hintStyle: const TextStyle(
                      color: ColorName.webCardAuthLabelColor,
                      fontWeight: FontWeight.w400),
                  prefixIcon: prefix,
                  suffixIcon: suffix
                      ? Clickable(
                          onClick: onClick!,
                          child: Icon(
                            iconData,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm)),
                ),
              )
            ],
          );
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm)),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm)),
                  ),
                )
        ],
      ),
    );
  }
}
