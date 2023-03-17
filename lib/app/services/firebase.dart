import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship_task/app/models/map_zone_model.dart';
import 'package:internship_task/app/services/user.dart';

import '../models/users/user_model.dart';

class FirebaseFireStore extends GetxController {
  static FirebaseFireStore get to => Get.find();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUser(UserModel user) async {
    await fireStore.collection("Users").doc(user.uid).set(user.toJson());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await fireStore.collection("Users").doc(uid).get();
    return doc.exists ? UserModel.fromJson(doc.data()!) : null;
  }

  Stream<QuerySnapshot> getUserByUserName(String username) {
    return fireStore
        .collection("Users")
        .where("uid", isNotEqualTo: UserStore.to.uid)
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future<bool> handleSignIn(String email, String password) async {
    UserModel? userModel;
    try {
      log("hlo");
      UserCredential userValue = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      log("hlo");
      userModel = await getUser(userValue.user!.uid);
      await UserStore.to.saveProfile(userModel!.uid);
      log("hlo");
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'account-exists-with-different-credential') {
        return false;
      } else if (e.code == 'invalid-credential') {
        return false;
      }
      return false;
    } catch (e) {
      log('$e Occurred');
      return false;
    }
  }

  Future<bool> handleSignUp(String email, String password, String username,
      String phoneNumber) async {
    UserModel? userModel;
    try {
      UserCredential userValue = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userModel = UserModel(
        uid: userValue.user!.uid,
        username: username,
        email: email,
        photoId: '',
        phoneNumber: phoneNumber,
      );
      await addUser(userModel);
      await UserStore.to.saveProfile(userModel.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return false;
      } else if (e.code == 'invalid-credential') {
        return false;
      }
      return false;
    } catch (e) {
      log('$e Occurred');
      return false;
    }
  }

  void uploadZoneData(String zoneName, List<LatLng> zonePoints) async {
    List<ZonePoints> zonePoint = [];
    for (var point in zonePoints) {
      log('Hello');
      zonePoint.add(ZonePoints(
          latitude: point.latitude,
          longitude: point.longitude));
    }
    var docId = fireStore.collection("mapZone").doc().id;
    await fireStore.collection('mapZone').doc(docId).set(
        MapZone(zoneName: zoneName, zoneId: docId, zonePoints: zonePoint).toJson());
  }
}
