import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_apps/core/enums/update_user.dart';
import 'package:education_apps/core/errors/exceptions.dart';
import 'package:education_apps/core/utils/constants/constants.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_platform_interface/src/providers/email_auth.dart'
    as emailAuth;

abstract class AuthRemoteSource {
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullname,
    required String password,
  });

  Future<void> forgotPassword(String email);

  Future<void> updateUser({
    required EnumUpdateUser action,
    required dynamic userData,
  });
}

class AuthRemoteSourceImpl extends AuthRemoteSource {
  AuthRemoteSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Error Ocuured',
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw const ServerException(
          statusCode: 'Unknown Error',
          message: 'Please try again later',
        );
      }

      var userData = await _getUserData(result.user!.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      await _setUserData(result.user!, email);
      userData = await _getUserData(result.user!.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Error Ocuured',
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.updateDisplayName(fullname);
      await userCred.user?.updatePhotoURL(ConstantUser.defaultAvatar);
      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Error Ocuured',
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> updateUser({
    required EnumUpdateUser action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case EnumUpdateUser.email:
          await _authClient.currentUser
              ?.verifyBeforeUpdateEmail(userData as String);
          await _updateUserData({'email': userData});
        case EnumUpdateUser.displayname:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'email': userData});
        case EnumUpdateUser.password:
          if ((_authClient.currentUser?.email ?? '').isEmpty) {
            throw const ServerException(
              statusCode: 'Insuficient Permission',
              message: 'User does not exist',
            );
          } else {
            final newData = jsonEncode(userData as String) as DataMap;
            await _authClient.currentUser?.reauthenticateWithCredential(
              emailAuth.EmailAuthProvider.credential(
                email: _authClient.currentUser!.email!,
                password: newData['newPassword'] as String,
              ),
            );

            await _authClient.currentUser?.updatePassword(
              newData['newPassword'] as String,
            );
          }
        case EnumUpdateUser.bio:
          await _updateUserData({'bio': userData as String});
        case EnumUpdateUser.profilePic:
          final ref = _dbClient
              .ref()
              .child('profile_picts/${_authClient.currentUser?.uid}');

          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profile_pic': url});
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Someting went wrong',
      );
    }
  }

  /// helper
  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreClient.collection('user').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            points: 0,
            profilePic: user.photoURL,
            fullname: user.displayName ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient
        .collection('users')
        .doc(
          _authClient.currentUser?.uid,
        )
        .update(data);
  }
}
