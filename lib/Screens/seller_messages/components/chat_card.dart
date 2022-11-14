import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/data/dummy_data.dart';
import 'package:dumper/services/database.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({Key key, this.chatroomId, this.press}) : super(key: key);
  final String chatroomId;
  final VoidCallback press;
  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  Stream<QuerySnapshot> chats;
  String myUsername = '';

  @override
  void initState() {
    HelperFunctions.getUserNameSharedPreference().then((value) => {
          setState(() {
            myUsername = value;
          })
        });
    chats = DatabaseMethods().getOtherUserChats(widget.chatroomId, myUsername);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: StreamBuilder(
          stream: chats,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var timeStamp = snapshot.data.docs.last.data()["time"].toDate();
              var time = DateFormat.jm().format(timeStamp);
              return Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(myUrlAvatar),
                      ),
                      if (true)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  width: 3),
                            ),
                          ),
                        )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.docs.last.data()["sendBy"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Opacity(
                            opacity: 0.64,
                            child: Text(
                              snapshot.data.docs.last.data()["message"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.64,
                    child: Text(time),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
