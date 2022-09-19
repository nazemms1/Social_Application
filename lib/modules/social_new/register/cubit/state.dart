
abstract class SocialRegisterNewStates{}
class SocialRegisterNewInitialState extends SocialRegisterNewStates{}

class SocialRegisterNewLoadingState extends SocialRegisterNewStates{}
class SocialRegisterNewSuccessState extends SocialRegisterNewStates {}
class SocialRegisterNewErrorState extends SocialRegisterNewStates{
 late final String error;
 SocialRegisterNewErrorState(this.error);

}

class SocialCreateUserSuccessState extends SocialRegisterNewStates {}
class SocialCreateUserErrorState extends SocialRegisterNewStates{
 late final String error;
 SocialCreateUserErrorState(this.error);

}