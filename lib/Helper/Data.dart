import 'package:flutter/material.dart';

class DataLogin {
  String firstName;
  String lastName;
  String phone;
  String cnic;
  String email;
  String password;

  void check(){
    print(firstName);
    print(lastName);
    print(phone);
    print(cnic);
    print(email);
    print(password);
  }
  // DataLogin(this.phone,this.password);
  // DataLogin(this.firstName,this.lastName,this.phone, this.cnic,this.email,this.password);
  // DataLogin({this.firstName,this.lastName});
}