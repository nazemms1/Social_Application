import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/layout/social_new/cubit/cubit.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';
import 'package:socia_new/models/social_new/post_model.dart';
import 'package:socia_new/styles/icon_broken.dart';

class FeedsScreenNew extends StatelessWidget {

  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialNewCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialNewCubit.get(context).posts.length > 0,
            builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/happy-handsome-young-man-pink-tshirt-with-beard-tattoo-hand-looking-pointing-down-by-two-fingers-yellow-wall_295783-14412.jpg?w=900&t=st=1660648977~exp=1660649577~hmac=613a163544f8ece734510bef0800b936aa38c466b3fd834ca616d03c02f0bd4f'),
                              fit: BoxFit.cover,
                              height: 280,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Communicate With Friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        elevation: 10,
                        margin: EdgeInsets.all(8.0),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPostItem(
                              SocialNewCubit.get(context).posts[index],
                              context,index
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: SocialNewCubit.get(context).posts.length),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildPostItem(PostModel model, context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.verified,
                              size: 15,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconBroken.More_Circle,
                      size: 25,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 10),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 9),
                        child: Container(
                          height: 20,
                          child: MaterialButton(
                            height: 30,
                            minWidth: 1.0,
                            textColor: Colors.blue,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#Software_development',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 9),
                        child: Container(
                          height: 20,
                          child: MaterialButton(
                            height: 30,
                            minWidth: 1.0,
                            textColor: Colors.blue,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#Flutter',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5,
                  ),
                  child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: NetworkImage('${model.postImage}'),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 25,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialNewCubit.get(context)
                                    .Likes[index]} Likes',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 25,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '0 Comments',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 2.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                '${SocialNewCubit.get(context).userModel!.image}'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'write a comment..',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 25,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      SocialNewCubit.get(context)
                          .likePost(SocialNewCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        elevation: 30,
        margin: EdgeInsets.symmetric(horizontal: 8),
      );
}
