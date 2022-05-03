import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumper/Screens/message_two/chat_detail_page.dart';
import 'package:dumper/Screens/message_two/components/chat_card.dart';
import 'package:dumper/Screens/message_two/components/fill_outline_button.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/services/database.dart';
import 'package:flutter/material.dart';

class MessageListBody extends StatefulWidget {
  const MessageListBody({Key key}) : super(key: key);

  @override
  State<MessageListBody> createState() => _MessageListBodyState();
}

class _MessageListBodyState extends State<MessageListBody> {
  Stream<QuerySnapshot> chats;
  @override
  void initState(){
    chats = DatabaseMethods().getUserChats("riya");
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              const SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: chats,
            builder: (context, snapshot) {
              if (snapshot != null && snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => ChatCard(
                    chats: snapshot.data.docs[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatDetailPage(),
                      ),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
