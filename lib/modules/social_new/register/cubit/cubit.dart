import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/models/social_new/social_user_model.dart';
import 'package:socia_new/modules/social_new/register/cubit/state.dart';

class SocialRegisterCubitNew extends Cubit<SocialRegisterNewStates> {
  SocialRegisterCubitNew() : super(SocialRegisterNewInitialState());

  static SocialRegisterCubitNew get(context) => BlocProvider.of(context);

  void userRegisterNew({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterNewLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterNewErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image:
          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1660667482~exp=1660668082~hmac=c269bde556f9fbcf5ead1e19eca4c1d7010a6aa7100589ec4c4b7cafaf29cc70',
      bio: 'write you bio..', cover: 'https://img.freepik.com/free-photo/woman-hand-blue-sweater-breaking-through-paper-wall-pointing-copy-space_273609-46465.jpg?t=st=1660652158~exp=1660652758~hmac=879c6b03dd67bf1aaef1c63c358c075cc243b00ac9bdf3dec6906e5f964136e7',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
