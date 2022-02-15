import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_add/templates/movie_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieStream extends StatelessWidget {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;


  void getCurrentUser()  {
    try{
      final user = _auth.currentUser;
      if(user != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }

    }
    catch(e){
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return StreamBuilder(
        stream: _firestore.collection('movies').snapshots(),
        builder: (context , snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          var movies = (snapshot.data as QuerySnapshot).docs;
          List<MovieCard> cardWidgets=[];
          for(var movie in movies){
            final name = movie['movie'];
            final director= movie['director'];
            // final messageTime = message['ts']==null ? Timestamp(2020,5) : (message['ts'] as Timestamp);
            final image =movie['image'];
            final cardWidget =MovieCard(
              movieName: name,
              directorName: director,
              urlToImage: image,

            );
            cardWidgets.add(cardWidget);
          }
          return  Expanded(
            child: ListView(

              children:cardWidgets,
            ),
          );
        }
    );
  }
}
