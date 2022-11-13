import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumper/model/chat_screen_model.dart';

class DatabaseMethods {
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

  Future<List<ChatScreenModel>> getAllUserChats(String myUsername) async {
    final docRef = FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: myUsername)
        .get();
    final snap = await docRef;
    List<ChatScreenModel> chats = [];
    var mymessage = '';
    for (int i = 0; i < snap.docs.length; i++) {
      var newCol = snap.docs[i].reference
          .collection('chats')
          .where('sendBy', isNotEqualTo: myUsername)
          .snapshots();
      print(newCol);
      // ChatScreenModel model = ChatScreenModel();
      // newCol.forEach((element) {
      //   mymessage = element.docs.first.data()['message'];
      // });
      // newCol.f((event) {
      //   model.message = event.docs.first.data()['message'];
      //   mymessage = event.docs.first.data()['message'];
      // });
      // newCol.first.then((value) => {
      //   model.message = value.docs.first.data()['message'],
      //   mymessage = value.docs.first.data()['message']
      // });
      // newCol.then((value) {
      //   model.message = value.docs.first.data()['message'];
      //   model.sendBy = value.docs.first.data()['sendBy'];
      //   model.time = value.docs.first.data()['time'];
      // });
      // chats.add(model);
    }
    // print(chats.length);
    // print(chats.last.sendBy);
    return chats;
  }
}
