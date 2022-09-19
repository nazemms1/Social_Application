import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socia_new/layout/social_new/cubit/states.dart';
import 'package:socia_new/models/social_new/message_model.dart';
import 'package:socia_new/models/social_new/post_model.dart';
import 'package:socia_new/modules/social_new/chats/chats_screen.dart';
import 'package:socia_new/modules/social_new/feeds/feeds_screen.dart';
import 'package:socia_new/modules/social_new/new_post/posts_screen.dart';
import 'package:socia_new/modules/social_new/settings/setting_screen.dart';
import 'package:socia_new/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../models/social_new/social_user_model.dart';
import '../../../modules/social_new/users/users_screen.dart';

class SocialNewCubit extends Cubit<SocialStates> {
  SocialNewCubit() : super(SocialInitialState());

  static SocialNewCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreenNew(),
    ChatsScreenNew(),
    PostScreenNew(),
    UsersScreenNew(),
    SettingScreenNew(),
  ];
  List<String> title = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');

      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //    emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        // emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //    emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageSuccessState());
    });
  }

  // void updateUserImages(
  //     {required String name,
  //     required String phone,
  //     required String bio,
  //     String? cover,
  //     String? image,
  //     String? email}) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
    String? email}) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      isEmailVerified: false,
      uId: userModel!.uId,
      email: userModel!.email,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //    emit(SocialUploadProfileImageSuccessState());
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    emit(SocialCreatePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> Likes = [];

  void getPost() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          Likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialLikePostsSuccessState());
        }).catchError((error) {
          emit(SocialLikePostsErrorState(error.toString()));
        });
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String ?receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
    //My Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });
//Receiver Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel>messages = [];

  void getMessages({
    required String ? receiverId,
  }) {
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId)
        .collection
      ('chats').doc(receiverId).collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }


}
