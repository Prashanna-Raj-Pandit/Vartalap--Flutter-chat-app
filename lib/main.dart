import 'package:vartalap/screens/chat_screen.dart';
import 'package:vartalap/screens/login_screen.dart';
import 'package:vartalap/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_scree.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        LogIn.id:(context)=>LogIn(),
        SignUp.id:(context)=>SignUp(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        ChatScreen.id:(context)=>ChatScreen()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}
