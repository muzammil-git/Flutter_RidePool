import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ridepool/Screens/Login.dart';

class display extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('RidePool'),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: const EdgeInsets.fromLTRB(0,130,100,100),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Text(
                      'What are you looking for ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 20,
                      ),
                    ),
                  ),
                ),

                RaisedButton(
                  onPressed:(){Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new Login()),
                  );},

                  padding: EdgeInsets.fromLTRB(50,0,50,0),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1)),
                  child: const Text('Give a Ride',
                    style: TextStyle(
                        fontSize: 20,color: Colors.white),
                  ),
                ),

                SizedBox(height: 40,),
                RaisedButton(
                  onPressed:(){},
                  padding: EdgeInsets.fromLTRB(50,0,50,0),
                  color: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1)),
                  child: const Text('Want a Ride',
                    style: TextStyle(fontSize: 20),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

