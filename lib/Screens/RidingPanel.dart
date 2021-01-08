
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ridepool/Helper/Datalogin.dart';
import 'package:ridepool/Screens/AddressSearch.dart';
import 'package:ridepool/Screens/configureScreen.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  DataLogin data;
  HomeScreen({Key key, @required this.data}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(data);
}

class _HomeScreenState extends State<HomeScreen> {

  DataLogin data;
  _HomeScreenState(this.data);

  double bottomPaddingOfMap = 0;

  static final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(24.9204, 67.1344), zoom: 14);

  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};

  int _polylineIdCounter = 1;
  PolylineId selectedPolyline;
  GoogleMapController _controller;

  Position _currentPosition;

  final Geolocator _geolocator = Geolocator();


  _getCurrentLocation() async {
    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POSITION: $_currentPosition');

        // For moving the camera to current location
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    // double _deviceHeight = MediaQuery.of(context).size.height;

    return new Scaffold(
      // extendBodyBehindAppBar: true,

      appBar: new AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          padding: EdgeInsets.only(top: 350),
          polylines: Set<Polyline>.of(polylines.values),
          mapType: MapType.normal,
          initialCameraPosition: _initialPosition,
          compassEnabled: true,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          onTap: (coordinate)async {
            try{
            _controller.animateCamera(CameraUpdate.newLatLng(coordinate));}catch(e){print('onTap--> Coordinate error'); return;}
            _getCurrentLocation();
            },

        ),


        Positioned(
          width: _deviceWidth / 1.1,
          right: 10,
          top: 20,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: TextField(
              readOnly: true,
              style: TextStyle(
                fontSize: 15,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Enter Pickup',
                labelStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),

              onTap: ()async{
                final sessionToken = Uuid().v4();
                showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken));
                },

            ),
          ),
        ),
        Positioned(
          width: _deviceWidth / 1.1,
          right: 10,
          top: 100,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: TextField(
              readOnly: true,
              style: TextStyle(
                fontSize: 15,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Enter Dropoff',
                labelStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),

              onTap: ()async{
                final sessionToken = Uuid().v4();
                showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken));
                },
            ),
          ),
        )
      ]),
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        height: 300,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(),
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.keyboard_arrow_up)),
            Text("View Rides",
                style: TextStyle(
                  fontSize: 30,
                )),
            Container(
                padding: EdgeInsets.only(right: 20), child: Icon(Icons.list)),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.arrow_back),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.pop(
            context,
            new MaterialPageRoute(builder: (context) => new display()),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('${data.firstName + ' ' + data.lastName}'),
              accountEmail: Text('${data.phone}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  '${data.firstName[0]}',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Trips'),
              trailing: Icon(Icons.electric_car),
              tileColor: Colors.white70,
              onTap: () {
                Navigator.of(context).pop();
              }, //TRIPS FUNCTION HERE
            ),
            ListTile(
              title: Text('FAQs'),
              trailing: Icon(Icons.info_outline),
              tileColor: Colors.white70,
              onTap: () {
                Navigator.of(context).pop();
              }, //FAQS FUNCTION HERE
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_sharp))
          ],
        ),
      ),
    );
  }

  // void findPlace(String placeName) async{
  //   if (placeName.length > 1){
  //     String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapUseKey&sessiontoken=1234567890";
  //
  //     var response = await RequestAssistant.getRequest(autoCompleteUrl);
  //
  //   }
  // }
}
