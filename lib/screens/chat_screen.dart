import 'package:vartalap/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  CollectionReference _firestore =
      FirebaseFirestore.instance.collection('messages');
  late Stream<QuerySnapshot> messageList;

  //final _db=FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser; // User is the FirebaseUser
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    messageList = _firestore.snapshots();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kChatScreenColor,
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                //messageStream();
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
        title: Text('Chat section'),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  messageStreamBuilder(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color:kPrimaryColor, width: 2.0),
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                hintText: 'Type your message here...',
                                border: InputBorder.none,
                              ),
                              controller: messageTextController,
                              onChanged: (value) {
                                messageText = value;
                              },
                            )),
                        OutlinedButton(
                          onPressed: () async {
                            messageTextController.clear();
                            await _firestore.add({
                              'sender': loggedInUser.email,
                              'text': messageText,
                            });
                          },
                          style: ButtonStyle(
                          ),
                          child: Text('send',style: TextStyle(color: kSignUp),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> messageStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.active) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
              querySnapshot.docs;

          return ListView.builder(
              itemCount: listQueryDocumentSnapshot.length,
              shrinkWrap: true,
              reverse: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot document =
                    listQueryDocumentSnapshot[index];
                bool isMe = loggedInUser.email == document['sender'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        document['sender'],
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      Material(
                        borderRadius: isMe? BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20)):
                        BorderRadius.only(bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        elevation: 5,
                        color: isMe ? kPrimaryColor : kSignUpInactive,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            document['text'],
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                // return ListTile(
                //   onTap: (){},
                //   //leading: Icon(Icons.person),
                //   subtitle: Text(document['text']),
                // );
              });
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
      stream: messageList,
    );
  }
}
