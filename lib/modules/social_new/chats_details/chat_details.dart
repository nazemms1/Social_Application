import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/cubit/cubit.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';
import 'package:socia_new/models/social_new/message_model.dart';
import 'package:socia_new/models/social_new/social_user_model.dart';
import 'package:socia_new/styles/colors.dart';
import 'package:socia_new/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? usermodel;

  ChatDetailsScreen({required this.usermodel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialNewCubit.get(context).getMessages(receiverId: usermodel!.uId);
        return BlocConsumer<SocialNewCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        '${usermodel!.image}',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('${usermodel!.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition:SocialNewCubit.get(context).messages.length>=0 ,
                builder: (context)=>Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                     Expanded(child: ListView.separated(itemBuilder: (context, index)
                     {
                       var message=SocialNewCubit.get(context).messages[index];
                       if(SocialNewCubit.get(context).userModel!.uId==message.senderId)
                       {
                         return buildMyMessage(message);
                       }
                       else
                       {
                         return buildMessage(message);
                       }
                     },
                       separatorBuilder:(context, index) =>SizedBox(height:
                       10,),
                       itemCount: SocialNewCubit.get(context).messages
                           .length,),),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '     type your message here ...',
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 48.0,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialNewCubit.get(context).sendMessage(
                                      receiverId: usermodel!.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator(),),
              )
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(5),
              ),
              color: Colors.grey[300]),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Text('${model.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                bottomStart: Radius.circular(10),
                bottomEnd: Radius.circular(6),
              ),
              color: defaultColor.withOpacity(0.4)),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Text('${model.text}'),
        ),
      );
}
