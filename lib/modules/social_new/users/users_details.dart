import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/cubit/cubit.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';

import '../../../models/social_new/social_user_model.dart';
import '../../../shared/components/components.dart';
import '../../../styles/icon_broken.dart';

class UsersDetailsScreen extends StatelessWidget {
  SocialUserModel? usermodel;

  UsersDetailsScreen({required this.usermodel});

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialNewCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = usermodel!.name!;
        phoneController.text = usermodel!.phone!;
        bioController.text = usermodel!.bio!;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Text('Users Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: IconBroken.User,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: bioController,
                    type: TextInputType.name,
                    label: 'Bio',
                    prefix: IconBroken.Message,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: IconBroken.Call,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                // defaultButton(
                //     text: 'Update',
                //     function: () {
                //       SocialNewCubit.get(context).updateUser(
                //         name: nameController.text,
                //         phone: phoneController.text,
                //         bio: bioController.text,
                //       );
                //       if (state is SocialUserUpdateLoadingState)
                //         SizedBox(
                //           height: 5,
                //         );
                //       if (state is SocialUserUpdateLoadingState)
                //       LinearProgressIndicator(
                //       backgroundColor: Colors.white,
                //       );
                //     }),
              ],
            ),
          ),
        );
      },
    );
  }
}
