
import 'dart:io';

import 'package:attento_news/data/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatefulWidget {
  NewsModel news;
  int index;
   NewsDetailsPage({Key? key,required this.news,required this.index}) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
        ),
        leading: IconButton(onPressed: (){},icon: Icon(Icons.menu_outlined),),
        title: Text("Audento News"),
        centerTitle: true,
        flexibleSpace:FlexibleSpaceBar(
          background: widget.news.articles[widget.index].urlToImage.toString()=="null"
              ?Image.asset("assets/noImage.png")
              : ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                child: Image.network(widget.news.articles[widget.index].urlToImage.toString(),
            fit: BoxFit.cover,),
              ),
        ),
        actions: [
          Icon(Icons.notifications),
          Padding(padding:const EdgeInsets.symmetric(horizontal: 3),child: Icon(Icons.search)),
          Padding(padding:const EdgeInsets.only(right: 3) ,child: Icon(Icons.location_pin)),
        ],
        bottom: PreferredSize(
        preferredSize: Size.fromHeight(280),
    child: Container(
    height: 280,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
    ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50,),
            Spacer(),
      Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
            widget.news.articles[widget.index].title.toString(),
             style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white70),
          // overflow: TextOverflow.ellipsis,
        ),
      ),
        ),
        ]
      ),
    )
      )
      ),

      body: Center(
        child: Column(
          children: [
            Text("Description",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
              child: Text(
                  widget.news.articles[widget.index].description.toString(),
                 style: TextStyle(
                   fontSize: 20
                 ),
              ),
            ),
            Spacer(),
            Text("To Read the News in Detail Please visit Website",style: TextStyle(color: Colors.black.withOpacity(0.6)),)
          ],
        ),
      ),
      floatingActionButton: GestureDetector(

        onTap: ()async{
          Uri uri =  Uri.parse(widget.news.articles[widget.index].url.toString());
          String url = widget.news.articles[widget.index].url.toString();
          print(uri);

          if(Platform.isAndroid)
            if(!await canLaunchUrl(uri)){
              await launchUrl(uri,mode: LaunchMode.externalApplication,);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to launch")));
            }
        },
        child: Container(
          height: 60,
          width: 150,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.greenAccent,Colors.blue]),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Center(child: Text("Visit Website"),),
        ),
      ),
    );
  }

}
