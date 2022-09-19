import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/modules/social_new/login/cubit/state.dart';

class SocialLoginCubitNew extends Cubit<SocialLoginNewStates> {
  SocialLoginCubitNew() : super(SocialLoginNewInitialState());

  static SocialLoginCubitNew get(context) => BlocProvider.of(context);

  void userLoginNew({
    required String email,
    required String password,
  }) {
    emit(SocialLoginNewLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
  ).then((value)
  {
    print(value.user?.uid);
    print(value.additionalUserInfo);

    emit(SocialLoginNewSuccessState(value.user!.uid));
  }).catchError((error){emit(SocialLoginNewErrorState(error.toString()));});

  }
}
