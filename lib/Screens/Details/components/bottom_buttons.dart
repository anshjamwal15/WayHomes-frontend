import 'package:dumper/Screens/messages/chat_detail_page.dart';
import 'package:dumper/constants/utils.dart';
import 'package:dumper/services/database.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({Key key}) : super(key: key);

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {

  DatabaseMethods databaseMethods = DatabaseMethods();

  createChatroomAndStartConversation({String userName}) {
    String chatRoomId = getChatRoomId(userName, Utils.myUsername);

    List<String> users = [userName, Utils.myUsername];

    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatDetailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatDetailPage(),
          ),
        );
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
