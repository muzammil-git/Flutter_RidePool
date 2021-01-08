import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ridepool/Helper/Datalogin.dart';
import 'package:ridepool/Screens/Login.dart';
import 'package:string_validator/string_validator.dart';
import 'package:ridepool/Screens/RidingPanel.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  DataLogin _Data = new DataLogin();
  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

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

  String checkName(String _nameValue){
    if(_nameValue.isEmpty ){
      return 'Enter some text';
    }
    else if(!isAlpha(_nameValue)){
      return 'Alphabets only';
    }
    return null;
  }

  String checkNumber(String _phoneNumber){
    const pattern = r'^(\+92|0|92|00)[3]{1}[0-4]{1}[0-9]{8}$';
    final regExp = RegExp(pattern);
    if(regExp.hasMatch(_phoneNumber)){
      return null;
    } else{
      return 'Enter Valid Number';
    }
  }

  String checkCnicCard(String _cnicNumber){
    const pattern = r'^[0-9]{5}-[0-9]{7}-[0-9]$';
    final regExp = RegExp(pattern);
    if(regExp.hasMatch(_cnicNumber)){
      return null;
    }
    else{
      return 'Pattern has not been Followed';
    }
  }

  String checkEmailAddress(String _email){
    if(isEmail(_email)){
      return null;
    }
    else{
      return 'Invalid Email Address';
    }
  }

  String checkPassword(String password) {
    if(password.length < 8){
      return 'Atleast 8 characters';
    }
  }

  void onPressedRegister(context){
    var form = formKey.currentState;
    if (form.validate()){
      form.save();
      _Data.check();

      FocusScopeNode currentFocus = FocusScope.of(context);//Keyboard disappears
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      Future.delayed(Duration(seconds: 2),(){//call back after 500  microseconds

        Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomeScreen(data: _Data,)));
        _myNumber.clear();// clear textfield
        _myPassword.clear();
        _cnicNumber.clear();
        _emailAddress.clear();
        _firstName.clear();
        _lastName.clear();
      },
      );

      var snackbar = SnackBar(content: Text(
          'Phone Number: ${_myNumber.text}, Email: ${_emailAddress.text}, Password: ${_myPassword.text}'),
      duration: Duration(milliseconds: 5000),
      );
      mainKey.currentState.showSnackBar(snackbar);
      } else {
      print('No');
      }
  }


  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;
    double boxSize = 80;
    double fieldGap = 05;

    return Scaffold(
      key: mainKey,
      resizeToAvoidBottomPadding: true,
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
              color: Colors.white,
              // width: _deviceWidth,
              // height: _deviceHeight,//This is causing overflow when error text appears
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  key: formKey,
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
                            child: SizedBox(
                              height: boxSize,
                              child: TextFormField(
                                controller: _firstName,
                                decoration: InputDecoration(
                                    hintText: 'First Name',
                                    prefixIcon: Icon(Icons.perm_identity),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )
                                ),
                                validator:(_nameValue){
                                  return checkName(_nameValue);
                                },
                                onChanged: (_nameValue){
                                  print(_nameValue);
                                  // checkName(_nameValue)(_nameValue);
                                },
                                onSaved: (_nameValue){
                                  _Data.firstName = _nameValue;
                                },
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: boxSize,
                              child: TextFormField(
                                controller: _lastName,
                                decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )
                                ),
                                validator: (_lastName){
                                  return checkName(_lastName);
                                },
                                onSaved: (_lastName){
                                  _Data.lastName = _lastName;

                                },
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: fieldGap,),

                      SizedBox(
                        height: boxSize,
                        child: TextFormField(
                          controller: _myNumber,
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )
                          ),
                          validator: (_phoneNumber){
                            return checkNumber(_phoneNumber);
                          },
                          onSaved: (_phoneNumber){
                            _Data.phone = _phoneNumber;
                          },
                        ),

                      ),

                      SizedBox(height: fieldGap,),

                      SizedBox(
                        height: boxSize,
                        child: TextFormField(
                          controller: _cnicNumber,
                          decoration: InputDecoration(
                              hintText: 'CNIC Number',
                              prefixIcon: Icon(Icons.credit_card_sharp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )
                          ),
                          validator: (_cnicNumber){
                            return checkCnicCard(_cnicNumber) ;
                          },
                          onSaved: (_cnicNumber){
                            _Data.cnic = _cnicNumber;
                          },
                        ),
                      ),

                      SizedBox(height: fieldGap,),

                      SizedBox(
                        height: boxSize,
                        child: TextFormField(
                          controller: _emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email Address',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )
                          ),
                          validator: (_email){
                            return checkEmailAddress(_email);
                          },
                          onSaved: (_email){
                            _Data.email = _email;
                          },
                        ),
                      ),

                      SizedBox(height: fieldGap,),

                      SizedBox(
                        height: boxSize,
                        child: TextFormField(
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
                          validator: (_password){
                            return checkPassword(_password);
                          },
                          onSaved: (_password){
                            _Data.password = _password;
                          },
                        ),
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        
                        padding: EdgeInsets.all(8),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              RaisedButton(
                                  onPressed: (){
                                    onPressedRegister(context);//Function which validates the form
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
      ),
    );
  }

}