import 'dart:math';

import 'package:clone_zoom/app/modules/home/controllers/create_meeting_controller.dart';
import 'package:clone_zoom/app/modules/home/views/video_call_screen.dart';
import 'package:clone_zoom/app/modules/home/widgets/home_meeting_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class MeetingScreen extends StatefulWidget {
  MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final CreateMeetingController _createMeetingController = Get.find<CreateMeetingController>();
 


  @override
  void dispose() {
    super.dispose();

    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: () {
                _createMeetingController.createMeeting(
                    isAudioMuted: true, isVideoMuted: true);
              },
              text: 'New Meeting',
              icon: Icons.videocam,
            ),
            HomeMeetingButton(
              onPressed: () {
                Get.to(()=> VideoCallScreen());
              },
              text: 'Join Meeting',
              icon: Icons.add_box_rounded,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: 'Schedule',
              icon: Icons.calendar_today,
            ),
            HomeMeetingButton(
              onPressed: () {},
              text: 'Share Screen',
              icon: Icons.arrow_upward_rounded,
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings with just a click!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
