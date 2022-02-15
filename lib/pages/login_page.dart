import 'package:flutter/material.dart';
import 'package:movie_add/pages/home_page.dart';
import 'package:movie_add/templates/button_template.dart';
import 'package:movie_add/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;

  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const  SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email=value;
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your E-mail',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                password=value;
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ButtonTemplate(
                buttonColor: Colors.blueAccent,
                buttonText: 'Log In',
                onPress: () async {
                  try{
                    final userIn = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if (userIn != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(
                       uid: userIn.user!.uid,
                      )),);
                    }
                  }
                  catch(e){
                    print(e);
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
