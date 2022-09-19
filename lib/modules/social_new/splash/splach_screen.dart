import 'package:flutter/material.dart';
import 'package:socia_new/modules/social_new/login/login_screen.dart';
import 'package:socia_new/shared/components/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen>{
      @override
  void initState()
  {
    super.initState();
    navigatetohome();
  }

      navigatetohome()async
      {
        await Future.delayed(Duration(milliseconds: 150000),(){});
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>SocialLoginNew()));
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:

              Container(
                child:Image(image: NetworkImage(
                    'https://img.freepik.com/premium-vector/thumbs-up-heart-label-with-cartoon-smile_399089-406.jpg?w=1380'
                ),
                fit: BoxFit.cover,width: 1500,)
            ),
   ),
    );
  }
}
