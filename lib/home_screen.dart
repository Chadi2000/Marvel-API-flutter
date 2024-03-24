import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercouse/Models/mcu_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var marvelApiUrl = "https://mcuapi.herokuapp.com/api/v1/movies";
  List<McuModels> mcuMoviesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarvelMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: mcuMoviesList.isNotEmpty ?
        GridView.builder(
          itemCount: mcuMoviesList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2/3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
          ),
          itemBuilder: (BuildContext context,int index){
            return
              ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child:
              mcuMoviesList[index].coverUrl != null ?
              CachedNetworkImage(
                imageUrl: mcuMoviesList[index].coverUrl.toString(),
                placeholder: (context, url) => Image.asset('images/placeHolder.jpg'),

              ):
              Image.asset('images/placeHolder.jpg'),
            );
          },
        )
          : Center(
        child: Container(
          width: 50,
          height: 50,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white,),
          ),
        ),
      ),
    );
  }

  void getMarvelMovies(){
    debugPrint('======= Function Running =======');
     final uri = Uri.parse(marvelApiUrl);
     http.get(uri).then((response){
       if(response.statusCode ==200){
          final responseBody = response.body;
          final decodedData = jsonDecode(responseBody);
          final marvelData = decodedData['data'];
          for(var i = 0; i<marvelData.length ;i++){
            final mcuMovie = McuModels.fromJson(marvelData[i] as Map<String, dynamic>);
            mcuMoviesList.add(mcuMovie);
            print(mcuMoviesList);
            setState(() {

            });
          }
       }else{

       }
     }).catchError((err){
       debugPrint('=======$err=======');
     });
  }

}

