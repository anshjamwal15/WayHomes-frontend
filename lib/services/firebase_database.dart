import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseMethods {
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  Future<void> createChatRoom(chatRoom, chatRoomId) async {
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
      throw e;
    });
  }

  Future getMessageCount(String username) async {
    QuerySnapshot documentCount = await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: "radha")
        .get();
    List<DocumentSnapshot> messageCount = documentCount.docs;
    return messageCount.length;
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
