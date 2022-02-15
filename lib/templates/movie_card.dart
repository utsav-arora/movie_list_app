
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieCard extends StatelessWidget {

  String movieName;
  String directorName;
  String urlToImage;

  MovieCard({Key? key,
    required this.movieName,
    required this.directorName,
    required this.urlToImage,
  }) : super(key: key);

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:const EdgeInsets.all(12.0),
      decoration:const  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Material(
        borderRadius:const BorderRadius.all(Radius.circular(10.0)),
        elevation: 3.0,
        child: Container(
          margin:const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: SizedBox(
                  height: 100.0,
                  width: 80.0,
                  child: Image(image: NetworkImage(urlToImage,),
                    height: 200,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10.0,),
              Flexible(
                child: Column(
                  children: [
                    Text(movieName,style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,color: Colors.white),),
                   const SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Icon(Icons.star,
                        color: Colors.yellow[700],),
                       const SizedBox(width: 3.0,),
                        Icon(Icons.star,
                          color: Colors.yellow[700],),
                       const SizedBox(width: 3.0,),
                        Icon(Icons.star,
                          color: Colors.yellow[700],),
                       const SizedBox(width: 3.0,),
                        Icon(Icons.star,
                          color: Colors.yellow[700],),
                       const SizedBox(width: 3.0,),
                      ],
                    ),
                   const SizedBox(height: 10.0,),
                    Text(directorName,style: TextStyle( fontSize: 15.0,color: Colors.grey[500]),),
                  ],
                ),
              ),
              const SizedBox(width: 50.0,),
              IconButton(
                onPressed:() async{
                  // String name;
                  // DocumentSnapshot documentSnapshot;
                 await firestore.collection('movies').doc(auth.currentUser!.uid).delete();
                 },
                icon:const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
