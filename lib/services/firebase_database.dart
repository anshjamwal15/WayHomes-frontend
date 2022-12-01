import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  Future<bool> createChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatroomId) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  getOtherUserChats(String chatroomId, String myUserName) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomId)
        .collection("chats")
        .where('sendBy', isNotEqualTo: myUserName)
        .orderBy("sendBy")
        .orderBy("time")
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String myUsername) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: myUsername)
        .orderBy("time")
        .snapshots();
  }

  String propImage(int propId) {
    var ref = FirebaseStorage.instance.ref().child("properties/prop-$propId");
    String url = ref.getDownloadURL().toString();
    return url;
  }
}
