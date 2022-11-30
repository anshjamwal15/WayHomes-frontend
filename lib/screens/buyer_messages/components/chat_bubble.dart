import 'package:dumper/constants/constants.dart';
import 'package:flutter/material.dart';


class ChatBubble extends StatefulWidget{
  final String message;
  final bool sendByMe;
  ChatBubble({Key key, this.message, this.sendByMe}) : super(key: key);
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: widget.sendByMe ? Alignment.topRight:Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.sendByMe ? Colors.grey.shade200:kPrimaryLightColor),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(widget.message),
        ),
      ),
    );
  }
}

