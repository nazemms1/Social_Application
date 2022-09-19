import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/cubit/cubit.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';
import 'package:socia_new/shared/components/components.dart';
import 'package:socia_new/styles/icon_broken.dart';

import '../../../styles/colors.dart';

class PostScreenNew extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialNewCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialNewCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Text('Create Post'),
            actions: [
              defaultTextButton(
                function: () {
                  if (SocialNewCubit.get(context).postImage == null) {
                    SocialNewCubit.get(context).createPost(
                        dateTime: now.toString(), text: textController.text);
                  } else {
                    SocialNewCubit.get(context).uploadPostImage(
                        dateTime: now.toString(), text: textController.text);
                  }
                },
                text: 'post',
              ),
            ],
          ),
          body: Padding(

              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    SizedBox(
                      height: 5,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${model!.image}'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                height: 1.4,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.center,
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'what is on your mind..',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (SocialNewCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ),
                              image: DecorationImage(
                                image: FileImage(SocialNewCubit.get(context)
                                    .postImage!)
                                as
                                ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            )),
                        IconButton(
                            onPressed: () {
                              SocialNewCubit.get(context).removePostImage();
                            },
                            icon: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: Icon(
                                IconBroken.Close_Square,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {SocialNewCubit.get(context)
                              .getPostImage();},
                          child: Row(
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photo'),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.tag_sharp),
                              SizedBox(
                                width: 5,
                              ),
                              Text('TAGS'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        );
      },
    );
  }
}
