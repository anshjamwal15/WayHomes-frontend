import 'package:dumper/Screens/seller_messages/components/body.dart';
import 'package:dumper/components/global_app_bar.dart';
import 'package:dumper/constants/constants.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key key,this.username}) : super(key: key);
  String username;
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Body(username: widget.username),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
    );
  }
}
