import 'package:flutter/material.dart';
const kPrimaryColor=Color(0xff7486a0);
const kLogin=Color(0xffC04F2B);
const kLoginLite=Color(0xffd7785c);
const kLoginInactive=Color(0xff488097);
//const kLoginInactive=Color(0xffBCA30B);
const kSignUp=Color(0xff044764);
const kSignUpInactive=Color(0xff488097);
const kChatScreenColor=Color(0xffc5e7e8);

 InputDecoration kTextInputDecoration=InputDecoration(
    hintText: 'Passcode',
    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30)
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kLoginInactive,width: 2),
        borderRadius: BorderRadius.circular(30)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kLogin,width: 2),
        borderRadius: BorderRadius.circular(30)
    )
);
