import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:disaoled_people/features/auth/providers/auth_state_provider.dart';
import 'package:disaoled_people/features/auth/screens/login_screen.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:disaoled_people/features/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart' as stream_sdk;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FlutterFireAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    await stream_sdk.StreamChatCore.of(context).client.disconnectUser();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  Future<void> signIn({required String email, required String password, required context}) async {
    Provider.of<AuthSataProvider>(context, listen: false).changeAuthState(newState: AuthState.waiting);

    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      context.read<AuthSataProvider>().changeAuthState(newState: AuthState.notSet);
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
      print(e.message);
    }
    return;
  }

  Future<UserCredential?> signUp({required UserModle userModle, context}) async {
    try {
      var user =
          await _firebaseAuth.createUserWithEmailAndPassword(email: userModle.email, password: userModle.password);
      await UserDbServices().creatUser(user: userModle, context: context);

      return user;
    } on FirebaseAuthException catch (e) {
      showErrorSnackBar(context, e.toString());
    }
    return null;
  }
}
