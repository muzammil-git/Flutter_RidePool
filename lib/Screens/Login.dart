import 'package:flutter/material.dart';
import 'package:ridepool/Helper/Data.dart';
import 'package:ridepool/Screens/Register.dart';
import 'package:ridepool/Screens/RidingPanel.dart';
import 'package:ridepool/Screens/configureScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _myNumber= TextEditingController();
  TextEditingController _myPassword= TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  DataLogin _login = new DataLogin();

  bool _obscureText = true;

  Color _visibilityIconColor = Colors.grey;


  void initState(){
    super.initState();
  }

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

  String numberValidator(number){
    const pattern = r'^(\+92|0|92|00)[3]{1}[0-4]{1}[0-9]{8}$';
    final regExp = RegExp(pattern);
    if(regExp.hasMatch(number)){
      return null;
    } else{
      return 'Invalid Number';
    }
  }

  String checkPassword(String password) {
    if(password.length < 8){
      return 'Atleast 8 characters';
    }
  }

  void onPressedLogin(context) {
    var form = _loginFormKey.currentState;
    if (form.validate()) {
      form.save();
      _login.check();

      FocusScopeNode currentFocus = FocusScope.of(
          context); //Keyboard disappears
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      Future.delayed(
        Duration(seconds: 2), () { //call back after 500  microseconds

        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => new HomeScreen(data: _login,)));
        _myNumber.clear(); // clear textfield
        _myPassword.clear();
      },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new display()));
          },

        ),
        // title: Text('Booking'),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: _deviceWidth,
            // height: _deviceHeight*0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth*0.1),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/drawerRide.png'),
                    Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                    Divider(),
                    //Phone Number Field
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _myNumber,
                      decoration: InputDecoration(
                          hintText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                      ),
                      validator:(_phoneNumber){
                        return numberValidator(_phoneNumber);
                      },
                      onChanged: (_phoneNumber){
                        print('Phone Number: $_phoneNumber');
                      },
                      onSaved: (_phoneNumber){
                        _login.phone = _phoneNumber;
                        _login.firstName ='Test';
                        _login.lastName ='User';
                      },

                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //Password Field
                    TextFormField(
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
                      validator: (_myPassword){
                        return checkPassword(_myPassword);
                      },
                      onChanged: (_myPassword){
                        print('Password: $_myPassword');
                      },
                      onSaved: (_myPassword){
                        _login.password = _myPassword;
                      },
                    ),
                    SizedBox(height: 30,),
                    //Forget Password Field & Login
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text(
                            'Forget Password?' ,
                            style: TextStyle(fontSize: 12,decoration: TextDecoration.underline,),
                          ),

                          //Login Button
                          RaisedButton(
                            onPressed: (){
                              onPressedLogin(context);
                            },
                            color: Color(0xffEE7B23),
                            child: Text('Login',style: TextStyle(color: Colors.white),),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    //Register Button
                    InkWell(
                      onTap: (){
                          Future.delayed(Duration(milliseconds: 500),(){
                            Navigator.push(context, new MaterialPageRoute(builder: (context) => new Register()));
                            },
                          );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text.rich(
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                children:<TextSpan>[
                                  TextSpan(text: 'Register', style:TextStyle(fontWeight: FontWeight.bold))

                                ],
                              ),
                            ),
                          ),
                        ],
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