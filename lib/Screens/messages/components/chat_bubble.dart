import 'package:dumper/Screens/messages/chat_detail_page.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/model/chat_message.dart';
import 'package:flutter/material.dart';


class ChatBubble extends StatefulWidget{
  ChatMessage chatMessage;
  ChatBubble({Key key, this.chatMessage}) : super(key: key);
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type  == MessageType.Receiver?kPrimaryLightColor:Colors.grey.shade200),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(widget.chatMessage.message),
        ),
      ),
    );
  }
}

