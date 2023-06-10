import 'package:vartalap/constants.dart';
import 'package:vartalap/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LogIn extends StatefulWidget {
  static const String id = 'login_screen';

  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late String email, password;
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
          inAsyncCall:showSpinner,
        child:SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 150,
                      width: 100,
                      child: Image.asset('images/chat.png'),
                    ),
                  ),
                  SizedBox(height: 100),
                  TextField(
                      onChanged: (value) {
                        email=value;
                      },
                      decoration: kTextInputDecoration.copyWith(
                          hintText: 'Enter your Email')),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: true,
                      onChanged: (value) {
                        password=value;
                      },
                      decoration: kTextInputDecoration),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButtons(color: kLogin, text: 'Log In', onPressed: () async{
                    setState(() {
                      showSpinner=true;
                    });

                    try{
                      final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user!=null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner=false;
                      });
                    }catch(e){
                      print(e);
                    }

                  })
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
