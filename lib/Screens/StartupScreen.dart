import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ridepool/Screens/configureScreen.dart';

class StartupScreen extends StatefulWidget {
  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {

  String _appVersion = 'Version: 1.0';
  String platform = "Android";
  final int futureDelay = 5;

  void pageNavigate() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => display()));
  }

  _routeTimer() async {
    var _duration = Duration(seconds: futureDelay);
    return Timer(_duration, pageNavigate);
  }

  @override
  void initState() {
    super.initState();
    _routeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('RidePool',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),),
                          Image.asset(
                            'images/drawerRide.png',
                            height: 300,
                            width: 300,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                        ],
                      )),
                ),
                CircularProgressIndicator(strokeWidth: 3,),
                SizedBox(height: 70,),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Spacer(),
                            RichText(text: TextSpan(text: _appVersion,
                                style: TextStyle(color: Colors.black, fontSize: 15,decoration: TextDecoration.underline))),
                            Spacer(flex: 4,),
                            RichText(text: TextSpan(text: platform,
                                style: TextStyle(color: Colors.black, fontSize: 15, decoration: TextDecoration.underline))),
                            Spacer(),
                          ]
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
          overflow: Overflow.clip,//handles the overflow in the stack and clips inside the bound
        ),
      ),
    );
  }
}