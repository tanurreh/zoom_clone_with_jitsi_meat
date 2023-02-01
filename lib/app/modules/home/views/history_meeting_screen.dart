import 'package:clone_zoom/app/modules/home/controllers/create_meeting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class HistoryMeetingScreen extends StatelessWidget {
   HistoryMeetingScreen({Key? key}) : super(key: key);
  final CreateMeetingController _createMeetingController = Get.find<CreateMeetingController>();


  @override
  Widget build(BuildContext context) {
    return 
    
     StreamBuilder(
      stream: _createMeetingController.meetingHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              'Room Name: ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
            ),
            subtitle: Text(
              'Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
            ),
          ),
        );
      },
    );
  }
}