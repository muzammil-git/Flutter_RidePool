import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ridepool/Screens/Login.dart';
import 'package:ridepool/Screens/RidingPanel.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _emailAddress = TextEditingController();
  final _cnicNumber = TextEditingController();
  final _myNumber= TextEditingController();
  final _myPassword= TextEditingController();
  bool _obscureText = true;
  Color _visibilityIconColor = Colors.grey;

  void changeObscure(){
    setState(() {
      if(_obscureText==true){
        _obscureText = false;
        _visibilityIconColor = Colors.lightBlueAccent[600];
      }
      else {
        _obscureText = true;
        _visibilityIconColor = Colors.grey;
      }
      return;
    });
  }


  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Login()),
          ),
        ),
        // title: Text('Booking'),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: _deviceWidth,
              height: _deviceHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/drawerRide.png'),
                    Text('Register',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                    Divider(),
                    Row(
                      children:[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8),
                          child: Text('-Must fill all the fields',
                          style: TextStyle(
                            fontSize: 12, color: Colors.red, letterSpacing: 0.5),
                          ),
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _firstName,
                            decoration: InputDecoration(
                                hintText: 'First Name',
                                prefixIcon: Icon(Icons.perm_identity),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                            ),
                          ),
                        ),

                        SizedBox(width: 10,),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _lastName,
                            decoration: InputDecoration(
                                hintText: 'Last Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 30,),

                    TextField(
                      controller: _myNumber,
                      decoration: InputDecoration(
                          hintText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                      ),
                    ),

                    SizedBox(height: 30,),

                    TextField(
                      controller: _cnicNumber,
                      decoration: InputDecoration(
                          hintText: 'CNIC Number',
                          prefixIcon: Icon(Icons.credit_card_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                      ),
                    ),

                    SizedBox(height: 30,),

                    TextField(
                      controller: _emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email Address',
                          prefixIcon: Icon(Icons.credit_card_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                      ),
                    ),

                    SizedBox(height: 30,),

                    TextField(
                      controller: _myPassword,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off, color: _visibilityIconColor),
                          onPressed: (){
                            changeObscure();
                          },
                        ),
                        prefixIcon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            RaisedButton(
                                onPressed: (){
                                Future.delayed(Duration(seconds: 2),(){//call back after 500  microseconds

                              Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomeScreen()));
                                _myNumber.clear();// clear textfield
                                _myPassword.clear();
                                _cnicNumber.clear();
                                _emailAddress.clear();
                                },
                              );

                                },
                              color: Color(0xffEE7B23),
                              child: Text('Register',style: TextStyle(color: Colors.white),),
                            ),
                          ]
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }

}


