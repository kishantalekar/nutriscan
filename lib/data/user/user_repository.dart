import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutriscan/features/authentication/models/user_model.dart';
import 'package:nutriscan/utils/exceptions/firebase_exceptions.dart';
import 'package:nutriscan/utils/exceptions/format_exceptions.dart';
import 'package:nutriscan/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../auth/authentication_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //save user data to firestore
  saveUserData(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  //get user details based on specific id

  Future<UserModel> fetchUserDetails() async {
    try {
      log("${AuthenticationRepository.instance.currentUser?.uid.toString()} fetchUserDetails function ");
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.currentUser?.uid)
          .get();
      print(documentSnapshot.data());

      if (documentSnapshot.exists) {
        return UserModel.fromMap(documentSnapshot.data()!);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      print(e);
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      print(e);
      throw TFormatException();
    } on PlatformException catch (e) {
      print(e);
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e);
      log(e.toString());
      throw "Something went wrong";
    }
  }
  //update user detail

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      log("updateUserDetails $e");
      throw "Something went wrong";
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.currentUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
