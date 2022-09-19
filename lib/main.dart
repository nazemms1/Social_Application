import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socia_new/modules/social_new/splash/splach_screen.dart';
import 'package:socia_new/shared/bloc_observer.dart';
import 'package:socia_new/shared/components/components.dart';
import 'package:socia_new/shared/components/constants.dart';
import 'package:socia_new/shared/cubit/cubit.dart';
import 'package:socia_new/shared/cubit/states.dart';
import 'package:socia_new/shared/network/local/cache_helper.dart';
import 'package:socia_new/shared/network/remote/dio_helper.dart';
import 'package:socia_new/styles/colors.dart';
import 'package:socia_new/styles/icon_broken.dart';
import 'package:socia_new/styles/themes.dart';

import 'layout/social_new/cubit/cubit.dart';
import 'layout/social_new/social_layout.dart';
import 'modules/social_new/login/login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message  ');
  print(message.data.toString());
  ShowTost(text: 'on background message ', states: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print('token:');
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    ShowTost(text: 'on message', states: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    ShowTost(text: 'on message opened app ', states: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget? widget;

  // bool ?onBoarding=CacheHelper.getData(key:'boarding');
  // print(onBoarding );

//String ? token =CacheHelper.getData(key:'token');
  uId = CacheHelper.getData(key: 'uId');

  // if(onBoarding !=null)
  //   {
  //     if(token !=null)
  //       {
  //         widget= const ShopLayoutNew();
  //       }
  //     else
  //     {
  //       widget=LoginShopNew();
  //     }
  //   }
  // else
  // {
  //   widget=const OnBoardingNewScreen();
  // }

  if (uId != null) {
    widget = SocialNewLayout();
  } else {
    widget = SocialLoginNew();
  }

  runApp(MyApp(
    isDark: isDark,
    starWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? starWidget;

  MyApp({
    //required this.isDark,
    required this.starWidget,
    required this.isDark,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
                // fromShared: isDark,
                ),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialNewCubit()
            ..getUserData()
            ..getPost(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme,
            darkTheme: darktheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            // themeMode: ThemeMode.dark,
            home:SplashScreen()
            // AnimatedSplashScreen(
            //   splash: Center(
            //     child: Container(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.home,
            //             size: 35,
            //             color: defaultColor,
            //           ),
            //           Column(
            //             children: [
            //               Text(
            //                 'Social App',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 40,
            //                     color: Colors.orange),
            //               )
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            //   duration: 6000,
            //   animationDuration: Duration(milliseconds: 3000),
            //   splashTransition: SplashTransition.rotationTransition,
            //   pageTransitionType: PageTransitionType.leftToRight,
            //   centered: true,
            //   curve: Curves.easeInOutQuint,
            //
            //   backgroundColor: Colors.white,
            //   // Center(s
            //   //   child: Container(
            //   //       child: Image(
            //   //     image: NetworkImage(
            //   //         'https://img.freepik.com/premium-vector/thumbs-up-heart-label-with-cartoon-smile_399089-406.jpg?w=1380'),
            //   //     fit: BoxFit.cover,
            //   //     width: 1500,
            //   //   )),
            //   // ),
            //   nextScreen: SocialLoginNew(),
            // ),
          );
        },
      ),
    );
  }
}
