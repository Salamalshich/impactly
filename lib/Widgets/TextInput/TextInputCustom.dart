// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';

class TextInputCustom extends StatefulWidget {
  Icon? icon;
  Widget? suffix;
  TextInputType? type;
  bool isrequierd = false;
  String? hint;
  bool? ispassword;
  int? line;
  String? Function(String?)? validator;
  bool enable;
  TextEditingController? controller;
  Color? bordercolor;
  Color? fillcolor;
  Color? foucedcolor;

  TextInputCustom({
    this.icon,
    this.type,
    this.controller,
    this.hint,
    this.isrequierd = false,
    this.validator,
    this.ispassword = false,
    this.enable = true,
    this.line = 1,
    this.suffix,
    this.bordercolor = AppColors.primary,
    this.fillcolor = AppColors.grey50,
  });

  @override
  State<TextInputCustom> createState() => _TextInputCustomState();
}

class _TextInputCustomState extends State<TextInputCustom> {
  bool? visiblepassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator:
          widget.validator ??
          (value) {
            if (widget.isrequierd) {
              if (value!.isEmpty || value == '') {
                return widget.isrequierd ? "This field is required" : '';
              }
              return null;
            } else {
              return null;
            }
          },
      maxLines: widget.line,
      keyboardType: widget.type,
      style: TextStyles.inputtitle.copyWith(
        color: widget.bordercolor,
        fontSize: 14,
      ),
      obscureText: widget.ispassword! ? visiblepassword! : false,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      cursorColor: AppColors.active,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor:
            widget.enable
                ? widget.fillcolor!.withOpacity(1)
                : const Color.fromARGB(255, 207, 205, 205),

        suffixIconConstraints: BoxConstraints.expand(width: 40, height: 20),
        suffixIcon:
            widget.ispassword!
                ? visiblepassword!
                    ? GestureDetector(
                      onTap:
                          () => setState(() {
                            visiblepassword = !visiblepassword!;
                          }),
                      child: SvgPicture.asset(
                        'assets/SVG/eye_close.svg',
                        color: AppColors.primary.withAlpha(255),
                        width: 22,
                      ),
                    )
                    : GestureDetector(
                      onTap:
                          () => setState(() {
                            visiblepassword = !visiblepassword!;
                          }),
                      child: SvgPicture.asset(
                        'assets/SVG/eye_open.svg',
                        color: AppColors.primary.withAlpha(255),
                        width: 22,
                      ),
                    )
                : widget.suffix,
        enabled: widget.enable,

        hintText: widget.hint,
        helperStyle: TextStyles.inputtitle.copyWith(
          color: widget.bordercolor!.withAlpha(255),
        ),
        floatingLabelStyle: TextStyles.inputtitle.copyWith(
          color: widget.bordercolor!.withAlpha(255),
        ),
        contentPadding: EdgeInsets.all(20),
      ),
    );
  }
}
