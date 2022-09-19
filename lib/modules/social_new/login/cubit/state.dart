abstract class SocialLoginNewStates{}
class SocialLoginNewInitialState extends SocialLoginNewStates{}

class SocialLoginNewLoadingState extends SocialLoginNewStates{}
class SocialLoginNewSuccessState extends SocialLoginNewStates
{
 final String uId;
 SocialLoginNewSuccessState(this.uId);
}
class SocialLoginNewErrorState extends SocialLoginNewStates{
 late final String error;
 SocialLoginNewErrorState(this.error);

}
