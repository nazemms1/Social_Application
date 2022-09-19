import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/modules/social_new/login/login_screen.dart';
import 'package:socia_new/modules/social_new/new_post/posts_screen.dart';

import '../../shared/components/components.dart';
import '../../styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialNewLayout extends StatelessWidget {
  const SocialNewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialNewCubit, SocialStates>(
        listener: (context, state) {
          if(state is SocialNewPostState)
            {
              navigateTo(context, PostScreenNew());
            }
        },
        builder: (context, state) {
var cubit=SocialNewCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.currentIndex],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.Notification,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.Search,
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
            iconSize: 25.0,
              showSelectedLabels: true,
              selectedFontSize: 15,
              enableFeedback: true,
              elevation: 70,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chat',
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Posts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Setting',

                ),
              ],
            ),

          );
        });
  }
}
