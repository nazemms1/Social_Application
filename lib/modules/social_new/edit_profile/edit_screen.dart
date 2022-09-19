import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/cubit/cubit.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';
import 'package:socia_new/shared/components/components.dart';
import 'package:socia_new/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialNewCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = SocialNewCubit.get(context).profileImage;
        var coverImage = SocialNewCubit.get(context).coverImage;
        var usermodel = SocialNewCubit.get(context).userModel;
        nameController.text = usermodel!.name!;
        bioController.text = usermodel.bio!;
        phoneController.text = usermodel.phone!;
        emailController.text = usermodel.email!;
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            titleSpacing: 5.0,
            actions: [
              defaultTextButton(
                  function: () {
                    SocialNewCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                        email: emailController.text);
                  },
                  text: 'Update'),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 270,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                    height: 240,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                      ),
                                      image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(
                                          '${usermodel.cover}',
                                        )
                                            : FileImage(coverImage)
                                        as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      SocialNewCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 20,
                                      ),
                                    ))
                              ],
                            )),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                  '${usermodel.image}',
                                )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialNewCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 15,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.name,
                      label: 'Bio',
                      prefix: IconBroken.Info_Square,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.name,
                      label: 'Phone',
                      prefix: IconBroken.Call,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  if (SocialNewCubit.get(context).profileImage != null ||
                      SocialNewCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialNewCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      text: 'Upload profile ',
                                      function: () {
                                        SocialNewCubit.get(context)
                                            .uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                      }),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                    height: 5,
                                  ),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              )),
                        SizedBox(
                          width: 20,
                        ),
                        if (SocialNewCubit.get(context).coverImage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      text: 'Upload cover ', function: () {
                                    SocialNewCubit.get(context)
                                        .uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  }),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                    height: 5,
                                  ),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              )),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
