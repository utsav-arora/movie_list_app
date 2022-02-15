import 'package:flutter/material.dart';
import 'package:movie_add/pages/home_page.dart';
import 'package:movie_add/templates/button_template.dart';
import 'package:movie_add/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  final _auth = FirebaseAuth.instance;

  bool showSpinner= false;
  late String email;
  late String password;

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
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your e-mail',
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
                password = value;
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ButtonTemplate(
                buttonColor: Colors.lightBlueAccent,
                buttonText: 'Register',
                onPress: () async {
                  setState(() {
                    showSpinner=true;
                  });
                  try {
                    UserCredential cred = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (cred != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(
                        uid: cred.user!.uid,
                      )),);
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
