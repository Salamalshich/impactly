<<<<<<< HEAD
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Controller/CategoryController.dart';
import 'package:impactlyflutter/Controller/GovernorateController%20copy.dart';
import 'package:impactlyflutter/Controller/LocaleController.dart';
import 'package:impactlyflutter/Controller/NotificationProvider.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:impactlyflutter/Constant/colors.dart';
import 'package:impactlyflutter/Controller/GovernorateController.dart';
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
import 'package:impactlyflutter/Services/NetworkClient.dart';
import 'package:impactlyflutter/Services/ServicesProvider.dart';
import 'package:impactlyflutter/View/Splash/Controller/SplashController.dart';
import 'package:impactlyflutter/View/Splash/Splash.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/firebase_options.dart';
import 'package:impactlyflutter/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
=======
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

<<<<<<< HEAD
  // تحميل SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // إنشاء LocaleController بالاعتماد على اللغة المخزنة
  final localeController = LocaleController(prefs);

  // إنشاء ServicesProvider
  final servicesProvider = ServicesProvider();
  await servicesProvider.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  if (Platform.isAndroid) {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('🔔 Android Notification permission: ${settings.authorizationStatus}');
  }
  // ربط Background Handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await initLocalNotification();

=======
  final servicesProvider = ServicesProvider();
  await servicesProvider.init();
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ServicesProvider>.value(value: servicesProvider),
        ChangeNotifierProvider<GovernorateController>(
<<<<<<< HEAD
          create: (_) => GovernorateController(),
        ),
        ChangeNotifierProvider<CategoryController>(
          create: (_) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider()..initNotifications(),
        ),
        Provider<NetworkClient>(
          create:
              (_) => NetworkClient(
                http.Client(),
                servicesProvider,
                localeController,
              ),
        ),
        ChangeNotifierProvider<LocaleController>.value(value: localeController),
=======
          create: (context) => GovernorateController(),
        ),
        Provider<NetworkClient>(
          create: (context) => NetworkClient(http.Client(), servicesProvider),
        ),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
<<<<<<< HEAD
        final localeController = context.watch<LocaleController>();
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Impaclty',
          theme: ThemeData(
            fontFamily: 'Inter',
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.basic,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith(
                  (states) => AppColors.primary,
                ),
              ),
            ),
            iconTheme: IconThemeData(color: AppColors.active),
            appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Inter',
              bodyColor: AppColors.primary,
              displayColor: AppColors.primary,
            ),
            useMaterial3: false,
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.secondery,
            ).copyWith(surface: AppColors.secondery),
          ),
<<<<<<< HEAD
          locale: localeController.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
=======
          locale: Locale('en'),
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
          home: ChangeNotifierProvider(
            create: (context) => SplashController()..whenIslogin(context),
            builder: (context, child) => Splash(),
          ),
          builder: (context, child) {
            EasyLoading.instance
              ..displayDuration = const Duration(seconds: 3)
              ..indicatorType = EasyLoadingIndicatorType.fadingCircle
              ..loadingStyle = EasyLoadingStyle.custom
              ..indicatorSize = 45.0
              ..radius = 15.0
              ..maskType = EasyLoadingMaskType.black
              ..progressColor = AppColors.active
              ..backgroundColor = AppColors.basic
              ..indicatorColor = AppColors.active
              ..textColor = AppColors.black
              ..maskColor = Colors.black
              ..userInteractions = false
              ..animationStyle = EasyLoadingAnimationStyle.opacity
              ..dismissOnTap = false;
            return FlutterEasyLoading(child: child);
          },
        );
      },
    );
  }
}
