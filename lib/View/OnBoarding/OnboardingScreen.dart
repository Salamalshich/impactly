import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:impactlyflutter/Services/Routes.dart';
import 'package:impactlyflutter/Services/ServicesProvider.dart';
import 'package:impactlyflutter/View/Auth/Login/Controller/LoginPageController.dart';
import 'package:impactlyflutter/View/Auth/Login/LoginPage.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  void _onDone(BuildContext context) async {
    await context.read<ServicesProvider>().showboard();
    CustomRoute.RouteReplacementTo(
      context,
      ChangeNotifierProvider<Loginpagecontroller>(
        create: (context) => Loginpagecontroller(),
        child: Loginpage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: AppLocalizations.of(context)!.onboard_welcome_title,
              body: AppLocalizations.of(context)!.onboard_welcome_body,
              image: _buildImage('assets/SVG/board.svg'),
              decoration: _getPageDecoration(),
            ),
            PageViewModel(
              title: AppLocalizations.of(context)!.onboard_feature_title,
              body: AppLocalizations.of(context)!.onboard_feature_body,
              image: _buildImage('assets/SVG/board2.svg'),
              decoration: _getPageDecoration(),
            ),
            PageViewModel(
              title: AppLocalizations.of(context)!.onboard_get_started_title,
              body: AppLocalizations.of(context)!.onboard_get_started_body,
              image: _buildImage('assets/SVG/board3.svg'),
              decoration: _getPageDecoration(),
            ),
          ],
          next: Text(
            AppLocalizations.of(context)!.next,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          skip: Text(AppLocalizations.of(context)!.skip),
          done: Text(
            AppLocalizations.of(context)!.get_started,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          showSkipButton: true,
          onDone: () => _onDone(context),
          onSkip: () => _onDone(context),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.black26,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          globalBackgroundColor: Colors.white,
          controlsPadding: const EdgeInsets.all(16),
          dotsContainerDecorator: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Center(
      child: SvgPicture.asset(assetName, width: width, fit: BoxFit.contain),
    );
  }

  PageDecoration _getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 16.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.only(top: 40.0),
      pageColor: Colors.white,
    );
  }
}
