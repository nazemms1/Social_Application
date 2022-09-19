import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/social_layout.dart';
import 'package:socia_new/modules/social_new/login/login_screen.dart';

import '../../../shared/components/components.dart';
import '../../../styles/colors.dart';
import '../../../styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class RegisterSocialNew extends StatelessWidget {
  late var forkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubitNew(),
      child: BlocConsumer<SocialRegisterCubitNew, SocialRegisterNewStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLoginNew());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Register',
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: forkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 230,
                          width: double.infinity,
                          child:
                          Image(image: NetworkImage('https://as2.ftcdn.net/v2/jpg/04/08/56/51/1000_F_408565186_GjJDq5hBGbdQY4sFFtR2efXt4f2YU3Qb.jpg'

                          ),fit: BoxFit.cover,
                          ),
                        ),
                        // Text(
                        //   'Register',
                        //   style: TextStyle(fontSize: 30,fontWeight:
                        //   FontWeight.bold,color: defaultColor),
                        // ),
                        Text(
                          'Register now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: IconBroken.Add_User,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: IconBroken.Message,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Email  Address';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        defaultFormField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: IconBroken.Password,
                          sufix: IconBroken.Show,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: IconBroken.Call,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your  Phone';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        //   (state is SocialLoginNewLoadingState)?const Center(child:
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
                        //           SocialLoginCubitNew.get(context).userLoginNew
                        //             (email: emailController.text, password:
                        //           passController.text);
                        //         }navigateAndFinish(context, SocialLayoutNew());
                        //       }),
                        // ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterNewLoadingState,
                          builder: (context) => defaultButton(
                            text: 'Register',
                            function: () {
                              if (forkey.currentState!.validate()) {
                                SocialRegisterCubitNew.get(context)
                                    .userRegisterNew(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text,
                                );

                                // navigateTo(context, const SocialLayoutNew());
                              }
                              // (state is SocialRegisterNewErrorState) {
                              //   Fluttertoast.showToast(
                              //     msg: 'Error',
                              //     toastLength: Toast.LENGTH_LONG,
                              //     gravity: ToastGravity.BOTTOM,
                              //     timeInSecForIosWeb: 5,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.black,
                              //     fontSize: 16.0,
                              //   );
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
