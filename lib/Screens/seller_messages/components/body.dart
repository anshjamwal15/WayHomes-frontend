import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/services/database.dart';
import 'package:flutter/material.dart';
import 'chat_card.dart';

class Body extends StatefulWidget {
  Body({Key key,this.username}) : super(key: key);
  String username;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool addNew = false;
  Stream<QuerySnapshot> chatRooms;
  @override
  void initState() {
    chatRooms = DatabaseMethods().getUserChats(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              kDefaultPadding, 10, kDefaultPadding, 10),
          color: white,
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    addNew = !addNew;
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: addNew ? kPrimaryColor : white,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  "Recent Messages",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.5,
                    color: addNew ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: kDefaultPadding),
            ],
          ),
        ),
        StreamBuilder(
          stream: chatRooms,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      // var data = snapshot.data.docs[index].data()["users"].
                      return ChatCard(
                        username: widget.username,
                        chatroomId: snapshot.data.docs[index].data()["chatroomId"],
                      );
                    }),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}
