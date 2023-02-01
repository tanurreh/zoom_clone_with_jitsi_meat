import 'dart:math';

import 'package:clone_zoom/app/modules/home/controllers/auth_controller.dart';
import 'package:clone_zoom/app/modules/home/services.dart/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class CreateMeetingController extends GetxController {
  final AuthController _authController = Get.find();
  DatabaseServices db = DatabaseServices();

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory =>
      db.userCollection
          .doc(_authController.user!.uid)
          .collection('meetings')
          .snapshots();

  void createMeeting({
    String roomName = '',
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      var random = Random();
      String newroomName = (random.nextInt(10000000) + 10000000).toString();
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      String roomname;
      if (username.isEmpty) {
        name = _authController.user!.displayName!;
      } else {
        name = username;
      }
      if (roomName.isEmpty) {
        roomname = newroomName;
      } else {
        roomname = roomName;
      }
      var options = JitsiMeetingOptions(room: roomname)
        ..userDisplayName = name
        ..userEmail = _authController.user!.email
        ..userAvatarURL = _authController.user!.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      addMeetingToHistory(roomname);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }

  void addMeetingToHistory(String meetingName) async {
    try {
      await db.userCollection
          .doc(_authController.user!.uid)
          .collection('meetings')
          .add({'meetingName': meetingName, 'createdAt': DateTime.now()});
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
