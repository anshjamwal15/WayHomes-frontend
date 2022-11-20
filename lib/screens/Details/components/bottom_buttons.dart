import 'package:dumper/Screens/buyer_messages/chat_detail_page.dart';
import 'package:dumper/model/property_model.dart';
import 'package:dumper/services/firebase_database.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class BottomButtons extends StatefulWidget {
  final Content house;

  const BottomButtons({Key key, this.house}) : super(key: key);

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  createChatroom(String userName) async {
    String name = await HelperFunctions.getUserNameSharedPreference();

    String chatRoomId = getChatRoomId(userName, name);

    List<String> users = [userName, name];

    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId,
      "time": DateTime.now()
    };
    databaseMethods.createChatRoom(chatRoomMap, chatRoomId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailPage(
          chatRoomId: chatRoomId,
          username: widget.house.user.username,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        createChatroom(widget.house.user.username);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: appPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.4,
              height: 60,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: darkBlue.withOpacity(0.6),
                        offset: const Offset(0, 10),
                        blurRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    (Icons.mail_rounded),
                    color: white,
                  ),
                  Text(
                    ' Message',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.4,
              height: 60,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: darkBlue.withOpacity(0.6),
                        offset: const Offset(0, 10),
                        blurRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    (Icons.call_rounded),
                    color: white,
                  ),
                  Text(
                    ' Call',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
