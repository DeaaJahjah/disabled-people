import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

extension FirebaseContext on BuildContext {
  /// get user id
  String? get userUid => FirebaseAuth.instance.currentUser!.uid;

  /// get the current user
  User? get currentUser => FirebaseAuth.instance.currentUser;

  /// Get user token.
  String? get userToken => FirebaseAuth.instance.currentUser!.displayName;
}
