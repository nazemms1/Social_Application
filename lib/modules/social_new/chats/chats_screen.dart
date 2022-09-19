import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/cubit/cubit.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';
import 'package:socia_new/models/social_new/social_user_model.dart';
import 'package:socia_new/modules/social_new/chats_details/chat_details.dart';
import 'package:socia_new/shared/components/components.dart';

import '../../../styles/icon_broken.dart';

class ChatsScreenNew extends StatelessWidget {
  const ChatsScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialNewCubit,SocialStates>(listener: (context, state) {},
        builder: (context,state)
        {
          var model=SocialNewCubit.get(context).userModel;
          return ConditionalBuilder(condition: SocialNewCubit.get(context)
              .users.length>0,
              builder: (context)=>ListView.separated(itemBuilder: (context, index)
              =>buildChatItem(SocialNewCubit.get(context)
                  .users[index],context),
                  separatorBuilder: (context,state)=>myDivider(),
                  itemCount:SocialNewCubit.get(context)
                      .users.length),
              fallback:(context)=>Center(child: CircularProgressIndicator(),),);
        },
    );
  }
  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    child: Padding(padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.4,fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 20,
          ),

        ],
      ),),
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(usermodel: model));
    },
  );
}
