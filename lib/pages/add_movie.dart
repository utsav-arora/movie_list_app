import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_add/constants.dart';
import 'package:movie_add/templates/button_template.dart';
import 'package:movie_add/templates/movie_model.dart';

class AddMovie extends StatelessWidget {


  String uid;
  AddMovie({required this.uid});
  String movieName='';
  String directorName='';
  String movieImage='';
  List<MovieModel> allMovies=[];
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add movie'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding:const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius:const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    movieName=value;
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Movie Name',
                  ),
                ),
                const SizedBox(height: 25.0,),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    directorName=value;
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Director Name',
                  ),
                ),
               const SizedBox(height: 25.0,),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    movieImage=value;
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter the image URL',
                  ),
                ),
                const SizedBox(height: 30.0,),
                ButtonTemplate(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: 'Add',
                  onPress: () async{
                    MovieModel movie = MovieModel(
                        directorName: directorName,
                        movieImage: movieImage,
                        movieName: movieName
                    );
                    allMovies.add(movie);


                    await firestore.collection('movies').add({
                       'movie':movieName,
                       'director':directorName,
                       'image':movieImage,
                      'uid':uid
                     });
                    Navigator.pop(context , allMovies);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
