import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridepool/Screens/configureScreen.dart';
import 'package:ridepool/Screens/homeMap.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final CameraPosition _initialPosition = CameraPosition(target: LatLng(24.9204,67.1344));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
      ),


      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.arrow_back),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.pop(context, new MaterialPageRoute(builder: (context) => new display()),
          );
        },
      ),

      drawer: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Syed Muzammil Ali"),
              accountEmail: Text("03331373192"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Trips'),
              trailing: Icon(Icons.electric_car),
              tileColor: Colors.white70,
              onTap:(){
                Navigator.of(context).pop();
              },//TRIPS FUNCTION HERE
            ),

            ListTile(
              title: Text('FAQs'),
              trailing: Icon(Icons.info_outline),
              tileColor: Colors.white70,
              onTap: (){
                Navigator.of(context).pop();
              },//FAQS FUNCTION HERE
            ),

            IconButton(
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage()));
                },
                icon: Icon(Icons.arrow_back_ios_sharp)
            )

          ],
        ),
      ),
    );
  }
}

// class test extends StatefulWidget {
//   @override
//   _testState createState() => _testState();
// }
//
// class _testState extends State<test> {
//   Color _containerColor = Colors.yellow;
//
//   void changeColor(){
//     setState(() {
//       if(_containerColor == Colors.yellow){
//         _containerColor = Colors.red;
//         return;
//       }
//       _containerColor = Colors.yellow;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: _containerColor,
//       child: Center(
//         child: Column(
//             children: <Widget>[
//               FloatingActionButton(
//                 onPressed: changeColor,
//               ),
//
//               RaisedButton(onPressed: (){Navigator.of(context).pop();},)
//             ]
//         ),
//       ),
//     );
//   }
// }
//
