// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';

class TextInputCustomSearch extends StatefulWidget {
  TextInputCustomSearch({
    this.icon,
    this.type,
    this.controller,
    this.hint,
    this.isrequierd = false,
    this.validator,
    this.ispassword = false,
    this.onSearch,
    this.enable = true,
    this.line = 1,
    this.bordercolor = AppColors.primary,
    this.fillcolor = AppColors.grey50,
  });

  Icon? icon;
  TextInputType? type;
  bool isrequierd = false;
  String? hint;
  bool? ispassword;
  final Function(String)? onSearch;
  int? line;
  String? Function(String?)? validator;
  bool enable;
  TextEditingController? controller;
  Color? bordercolor;
  Color? fillcolor;

  @override
  State<TextInputCustomSearch> createState() => _TextInputCustomSearchState();
}

class _TextInputCustomSearchState extends State<TextInputCustomSearch> {
  bool? visiblepassword = true;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    widget.onSearch?.call(query);
    FocusScope.of(context).unfocus(); // لتسكير الكيبورد بعد البحث
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:
          widget.validator ??
          (value) {
            if (widget.isrequierd && (value == null || value.isEmpty)) {
              return "This field is required";
            }
            return null;
          },
      maxLines: widget.line,
      onChanged: (value) {
        widget.onSearch?.call(value); // 🔥 live search
      },
      keyboardType: widget.type,
      style: TextStyles.inputtitle.copyWith(
        color: widget.bordercolor,
        fontSize: 14,
      ),
      obscureText: widget.ispassword! ? visiblepassword! : false,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorColor: AppColors.active,
      enabled: widget.enable,
      onEditingComplete: _performSearch,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor:
            widget.enable ? widget.fillcolor!.withOpacity(1) : AppColors.grey50,
        prefixIcon: Icon(Icons.search, color: AppColors.active),
        suffixIcon: IconButton(
          icon: Icon(Icons.send, color: AppColors.active),
          onPressed: _performSearch,
        ),
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
