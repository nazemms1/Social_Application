import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socia_new/layout/social_new/social_layout.dart';
import 'package:socia_new/modules/social_new/login/cubit/state.dart';
import 'package:socia_new/shared/network/local/cache_helper.dart';
import 'package:socia_new/styles/colors.dart';

import '../../../shared/components/components.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';

class SocialLoginNew extends StatelessWidget {
    SocialLoginNew({Key? key}) : super(key: key);
var formkey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=> SocialLoginCubitNew(),

    child: BlocConsumer<SocialLoginCubitNew,SocialLoginNewStates>
      (
      listener: (context, state)
      {
        if(state is SocialLoginNewErrorState)
          {
            ShowTost(text:state.error,states:ToastStates.ERROR,);
          }
        if(state is SocialLoginNewSuccessState)
          {
           CacheHelper.saveData(key: 'uId',
               value: state.uId,
           ).then((value){
             navigateAndFinish(context, SocialNewLayout());
           });
          }
      },
      builder: (context,state)
      {
        return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        height: 180,
                        width: double.infinity,
                        child:
                        Image(image: NetworkImage('https://img.freepik.com/free-vector/developers-testing-software_74855-4782.jpg?w=996&t=st=1660685217~exp=1660685817~hmac=1e4c0b480c7d72c47625db1b8f9bb0672b5fc8735fac7483c3761025eb83d2c8'

                        ),fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                    Text(
                          'Login',
                          style: TextStyle(fontSize: 30,fontWeight:
                          FontWeight.bold,color: defaultColor),
                        ),

                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login now to communicate with friends',
                        style:
                        Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validate: (  value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                          onSubmit: (String value) {
                            print(value);
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock,
                          sufix: Icons.visibility_outlined,
                          isPassword: true,
                          validate: (  value) {
                            if (value!.isEmpty) {
                              return ' password is too short';
                            }
                          },
                          onSubmit: (value) {
                            if (formkey.currentState!.validate())
                            {
                              // SocialLoginCubitNew.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passController.text,
                              // );
                            }
                          }),
                      SizedBox(
                        height: 30.0,
                      ),


                      //   (state is ShopLoginNewLoadingState)?const Center(child:
                      //   CircularProgressIndicator()):Container(
                      //   width: double.infinity,
                      //   color: Colors.blue,
                      //   child: MaterialButton(
                      //       child: const Text(
                      //         "loge in",
                      //         style:
                      //         TextStyle(fontSize: 25, color: Colors.white),
                      //       ),
                      //       onPressed: () {
                      //         if(forkey.currentState!.validate()){
                      //           ShopLoginCubitNew.get(context).userLoginNew
                      //             (email: emailController.text, password:
                      //           passController.text);
                      //         }navigateAndFinish(context, ShopLayoutNew());
                      //       }),
                      // ),
                      ConditionalBuilder(
                        condition:state is !SocialLoginNewLoadingState,
                        builder: (context) => defaultButton (
                          text: 'login',
                          function: () {
                            if (formkey.currentState!.validate())
                            {
                              SocialLoginCubitNew.get(context).userLoginNew(
                                  email: emailController.text,
                                  password: passController.text);
                            }
                            //navigateAndFinish(context, SocialLayoutNew());
                          },

                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont have any acount?',
                          ),
                          defaultTextButton(
                            function: () {
                                  navigateTo(context, RegisterSocialNew());
                            },
                            text: 'Register',
                          ),

                        ],
                      )
                       ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    )
    );
  }
}
