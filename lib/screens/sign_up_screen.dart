import 'package:vartalap/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signup_screen';

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  late String email, password;
  bool spin=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: SafeArea(
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
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextInputDecoration.copyWith(
                            hintText: 'Enter your Email')),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextInputDecoration),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButtons(
                        color: kSignUp,
                        text: 'Sign Up',
                        onPressed: () async{
                          setState(() {
                            spin=true;
                          });
                          try{
                            final newUser =await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                            if(newUser!=null){
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              spin=false;
                            });
                          }
                          catch(e){
                            print(e);
                          }

                        })
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
