import 'package:flutter/material.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Constant/text_styles.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:provider/provider.dart';
import 'package:impactlyflutter/Controller/LocaleController.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localeController = context.watch<LocaleController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.choose_language,
          style: TextStyles.header.copyWith(color: AppColors.black),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => CustomRoute.RoutePop(context),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        ),
      ),

      body: ListView(
        children: [
          RadioListTile<Locale>(
            title: Text(
              'English',
              style: TextStyles.title.copyWith(color: AppColors.primary),
            ),
            value: const Locale('en'),
            groupValue: localeController.locale,
            onChanged: (locale) {
              if (locale != null) localeController.setLocale(locale);
            },
          ),
          RadioListTile<Locale>(
            title: Text(
              'العربية',
              style: TextStyles.title.copyWith(color: AppColors.primary),
            ),
            value: const Locale('ar'),
            groupValue: localeController.locale,
            onChanged: (locale) {
              if (locale != null) localeController.setLocale(locale);
            },
          ),
        ],
      ),
    );
  }
}
