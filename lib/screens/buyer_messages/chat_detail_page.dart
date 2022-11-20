import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumper/Screens/buyer_messages/components/chat_bubble.dart';
import 'package:dumper/Screens/buyer_messages/components/chat_detail_page_appbar.dart';
import 'package:dumper/Screens/buyer_messages/components/send_menu_items.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/constants/utils.dart';
import 'package:dumper/services/firebase_database.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatRoomId;
  final String username;
  const ChatDetailPage({Key key, this.chatRoomId, this.username})
      : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String myUsername = Utils().myUsername;
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = TextEditingController();

  List<SendMenuItems> menuItems = [
    SendMenuItems(
        text: "Photos & Videos", icons: Icons.image, color: Colors.amber),
    SendMenuItems(
        text: "Document", icons: Icons.insert_drive_file, color: Colors.blue),
    SendMenuItems(text: "Audio", icons: Icons.music_note, color: Colors.orange),
    SendMenuItems(
        text: "Location", icons: Icons.location_on, color: Colors.green),
    SendMenuItems(text: "Contact", icons: Icons.person, color: Colors.purple),
  ];

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: const Color(0xff737373),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemCount: menuItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: menuItems[index].color.shade50,
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(
                              menuItems[index].icons,
                              size: 20,
                              color: menuItems[index].color.shade400,
                            ),
                          ),
                          title: Text(menuItems[index].text),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    chats = DatabaseMethods().getChats(widget.chatRoomId);
    HelperFunctions.getUserNameSharedPreference().then((value) => {
          setState(() {
            myUsername = value;
          })
        });
    super.initState();
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": myUsername,
        "message": messageEditingController.text,
        "time": DateTime.now(),
      };
      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    } else {
      print("Controller not working");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(username: widget.username),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: chats,
            builder: (context, snapshot) {
              if (snapshot != null && snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: snapshot.data.docs[index].data()["message"],
                      sendByMe: myUsername ==
                          snapshot.data.docs[index].data()["sendBy"],
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 16, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showModal();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageEditingController,
                      decoration: InputDecoration(
                          hintText: "Type message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.only(right: 20, bottom: 15),
              child: FloatingActionButton(
                onPressed: () {
                  addMessage();
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                backgroundColor: kPrimaryColor,
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
