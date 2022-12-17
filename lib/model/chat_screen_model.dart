import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreenModel {
  String sendBy;
  Timestamp time;

  // List<Messages> messageList;
  String message;

  ChatScreenModel({this.sendBy, this.time, this.message});
}

// class Messages {
//   String message;
//   Messages({this.message});
// }
