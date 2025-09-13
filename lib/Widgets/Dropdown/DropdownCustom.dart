import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';

class DropdownCustom<T> extends StatelessWidget {
  final T? value;
  final String? hint;
  final bool enable;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  bool isrequierd = false;
  String? Function(T?)? validator;
  Color? bordercolor;
  Color? fillcolor;
  DropdownCustom({
    required this.items,
    required this.onChanged,
    this.value,
    this.isrequierd = false,
    this.validator,
    this.hint,
    this.enable = true,
    this.bordercolor = AppColors.primary,
    this.fillcolor = AppColors.basic,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:
          validator ??
          (value) {
            if (isrequierd) {
              if (value == null) {
                return isrequierd ? "This field is required" : '';
              }
              return null;
            } else {
              return null;
            }
          },
      value: value,
      items: items,
      selectedItemBuilder: (context) {
        return items.map((item) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Text(
              (item.child as Text).data ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyles.paraghraph.copyWith(color: AppColors.primary),
            ),
          );
        }).toList();
      },
      onChanged: enable ? onChanged : null,
      dropdownColor: AppColors.grey50,
      isExpanded: true,
      style: TextStyles.inputtitle.copyWith(
        color: AppColors.primary,
        fontSize: 14,
      ),
      borderRadius: BorderRadius.circular(15),
      iconEnabledColor: bordercolor!.withAlpha(255),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabled: enable,
        filled: true,
        fillColor: AppColors.grey50,

        hintText: hint,
        hintStyle: TextStyles.inputtitle.copyWith(
          color: bordercolor!.withAlpha(255),
        ),
        floatingLabelStyle: TextStyles.inputtitle.copyWith(
          color: bordercolor!.withAlpha(255),
        ),
      ),
    );
  }
}
