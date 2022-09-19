import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/cubit/cubit.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';
import 'package:socia_new/modules/social_new/login/login_screen.dart';
import 'package:socia_new/modules/social_new/new_post/posts_screen.dart';
import 'package:socia_new/shared/components/components.dart';
import 'package:socia_new/styles/icon_broken.dart';

import '../edit_profile/edit_screen.dart';

class SettingScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialNewCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var usermodel = SocialNewCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            children: [
              Container(
                height: 270,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
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
                              image: NetworkImage(
                                '${usermodel!.cover}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          '${usermodel.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${usermodel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${usermodel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '161 ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '2K ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10K ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100 ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () {
                      navigateTo(context, PostScreenNew());
                    },
                    child: Text('Add Photos'),
                    autofocus: true,
                    style: ButtonStyle(alignment: AlignmentDirectional.center),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: (){
                    FirebaseMessaging.instance.subscribeToTopic('announcements');
                  },
                      child: Text('subscribe'),),
                  SizedBox(width: 15,),
                  OutlinedButton(onPressed: ()
                  {
                    FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

                  },
                    child: Text('unsubscribe'),),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
