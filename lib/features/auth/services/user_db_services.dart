import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/utils/shared_pref.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/features/auth/models/benefactor.dart';
import 'package:disaoled_people/features/auth/models/charity.dart';
import 'package:disaoled_people/features/auth/models/patient.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:disaoled_people/features/auth/providers/auth_state_provider.dart';
import 'package:disaoled_people/features/auth/providers/user_provider.dart';
import 'package:disaoled_people/features/auth/screens/sms_verfication_screen.dart';
import 'package:disaoled_people/features/chat/services/stream_chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class UserDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = auth.FirebaseAuth.instance.currentUser;

  creatUser({required UserModle user, required context}) async {
    try {
      /// Create user documnet
      final userr = getUserType(user);
      await _db.collection('users').doc(firebaseUser!.uid).set(userr.toJson());

      /// Create user in Stream Chat
      final client = StreamChatCore.of(context).client;

      ///generate token id for this user
      var token = client.devToken(firebaseUser!.uid);

      /// save the token as a display name
      /// and update user photo

      await firebaseUser!.updateDisplayName(token.rawValue);
      if (user.image != null) firebaseUser!.updatePhotoURL(user.image);

      // connect user to [Stream SDK]
      await client.connectUser(
        User(
          id: firebaseUser!.uid,
          name: user.name,
          image: user.image,
        ),
        token.rawValue,
      );
      SharedPref.set('type', user.userType.name);
      if (user is Patient) {
        SharedPref.set('diseaseName', user.disease!.name);
      }

      Provider.of<AuthSataProvider>(context, listen: false).changeAuthState(newState: AuthState.notSet);

      Navigator.of(context).pushNamedAndRemoveUntil(SmsVerficationScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      Provider.of<AuthSataProvider>(context, listen: false).changeAuthState(newState: AuthState.notSet);

      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<UserModle?> getUser(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var user = await _db.collection('users').doc(id).get();
      String userType = user.data()!['user_type'];
      // SharedPref.set('type', userType);

      if (userType == UserType.benefactor.name) {
        sharedPreferences.setString('type', UserType.benefactor.name);

        return Benefactor.fromFirestore(user);
      }

      if (userType == UserType.patient.name) {
        final patient = Patient.fromFirestore(user);
        SharedPref.set('diseaseName', patient.disease!.name);
        sharedPreferences.setString('diseaseName', patient.disease!.name);
        sharedPreferences.setString('type', UserType.patient.name);

        return Patient.fromFirestore(user);
      }

      if (userType == UserType.charityOrg.name) {
        sharedPreferences.setString('type', UserType.charityOrg.name);

        return Charity.fromFirestore(user);
      }
    } on FirebaseException catch (e) {
      print(e);
    }
    return null;
  }

  //update user
  Future<void> updateUser(UserModle user, context) async {
    try {
      await _db.collection('users').doc(firebaseUser!.uid).update(getUserType(user).toJson());
      await StreamChatService().updateUser(user, context);
      Provider.of<UserProvider>(context, listen: false).getUserData();
      showSuccessSnackBar(context, 'تم التعديل بنجاح');
      Navigator.of(context).pop(true);
    } on FirebaseException {
      showErrorSnackBar(context, 'حدث خطأ');
    }
  }
}

getUserType(UserModle user) {
  switch (user.runtimeType) {
    case Benefactor:
      return user as Benefactor;
    case Charity:
      return user as Charity;
    case Patient:
      return user as Patient;

    default:
  }
}
