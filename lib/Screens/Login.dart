import 'package:flutter/material.dart';
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

  bool _phoneValid = true;
  bool _passwordValid = true;
  bool _obscureText = true;

  bool _submitValidPhone = false;
  bool _submitValidPassword = false;

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

  bool numberValidator(number){
    setState(() {
    const pattern = r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
    final regExp = RegExp(pattern);
    if(regExp.hasMatch(number)){
      _submitValidPhone = true;
      return _phoneValid = true;
    } else{
      _submitValidPhone = false;
      return _phoneValid = false;
    }
    });
  }

  bool passwordValidator(password){
    setState(() {
      if(password.length >= 8){
        _submitValidPassword = true;
        return _passwordValid = true;
      }
      else{
        _submitValidPassword = false;
        return _passwordValid = false;
      }
    });
  }

  bool submitChecker(){
    if((_submitValidPhone && _submitValidPassword) == true){
      return true;
    }else{
      return false;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/drawerRide.png'),
                  Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  Divider(),
                  //Phone Number Field
                  TextField(
                    onChanged: (_myNumber){
                      print('Phone Number: $_myNumber');
                      numberValidator(_myNumber);
                    },
                    keyboardType: TextInputType.phone,
                    controller: _myNumber,
                    decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        errorText: _phoneValid ? null : "Invalid Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Password Field
                  TextField(
                    onChanged: (_myPassword){
                      print('Password: $_myPassword');
                      passwordValidator(_myPassword);
                    },
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
                      errorText: _passwordValid ? null : 'Atleast 8 characters',
                    ),
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
                            if(submitChecker() == true){
                              Future.delayed(Duration(
                                  seconds: 2), () { //call back after 500  microseconds
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (context) => new HomeScreen()));
                                _myNumber.clear(); // clear textfield
                                _myPassword.clear();
                                Focus.of(context).unfocus();
                              },
                              );
                          }else{
                              print('NO access');
                            }
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

    );
  }
}