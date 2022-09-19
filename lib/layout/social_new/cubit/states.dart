abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  late final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

//createPost
class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialPostImageSuccessState extends SocialStates {}

class SocialPostImageErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}



class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  late final String error;

  SocialGetPostsErrorState(this.error);
}
//LIKE POSTS
class SocialLikePostsSuccessState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates {
  late final String error;

  SocialLikePostsErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  late final String error;

  SocialGetAllUserErrorState(this.error);
}

//Chats

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {}


class SocialCommentsPostsSuccessState extends SocialStates {}
class SocialCommentsPostsLoadingState extends SocialStates {}

class SocialCommentsPostsErrorState extends SocialStates {
  late final String error;

  SocialCommentsPostsErrorState(this.error);
}
