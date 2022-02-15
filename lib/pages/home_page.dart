import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_add/pages/add_movie.dart';
import 'package:movie_add/templates/movie_card.dart';
import 'package:movie_add/templates/movie_stream.dart';

class HomePage extends StatefulWidget {
  String uid;
  HomePage({Key? key,
  required this.uid
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  List movies=[];
   void updateList(List newMovieList){
     setState(() {
       movies = newMovieList;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: null,
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async{
                await _auth.signOut();
                Navigator.pop(context);
              }),
        ],
      ),
      body: SafeArea(
          child:Column(
            children: [
              Padding(padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 70.0,
                    child: Image.asset('images/logo.png'),
                  ),
                  const SizedBox(height:15.0),
                 const Text('Movies Watched'),
                ],
              ),),
               Expanded(child: Container(
                 decoration: BoxDecoration(
                   color: Colors.grey[700],
                   borderRadius:const BorderRadius.only(
                     topRight: Radius.circular(25.0),
                     topLeft: Radius.circular(25.0),
                   ),
                 ),
                 child: MovieStream(),
               ),),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
        List newList =await  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMovie(
          uid: widget.uid,
        ),),);
        updateList(newList);
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add,
        color: Colors.yellow[700],),
      ),
    );
  }
}
