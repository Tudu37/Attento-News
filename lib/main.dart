import 'package:attento_news/logic/provider_state.dart';
import 'package:attento_news/presentation/news_homepage.dart';
import 'package:attento_news/sharedPreferenceHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ProviderState(),
      child: MaterialApp(
        title: 'Attento News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AttentoNewsHomePage(),
      ),
    );
  }
}

