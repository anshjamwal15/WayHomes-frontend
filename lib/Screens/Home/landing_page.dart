import 'package:dumper/Screens/Home/components/body.dart';
import 'package:dumper/components/loading_circle.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const LoadingCircle(size: 800)
          : Stack(
              alignment: Alignment.bottomCenter,
              children: const [
                Body(),
              ],
            ),
    );
  }
}
