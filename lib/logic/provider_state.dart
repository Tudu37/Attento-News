
import 'package:attento_news/data/models/news_model.dart';
import 'package:attento_news/data/repositories/news_repository.dart';
import 'package:attento_news/sharedPreferenceHelper.dart';
import 'package:flutter/cupertino.dart';

class ProviderState extends ChangeNotifier{

   NewsModel? headlineNews;
   NewsModel? healthNews;
   NewsModel? scienceNews;
   NewsModel? sportsNews;
   NewsModel? tecnologyNews;
  bool isLoading = true;
  int page=0;
  int tpage =0;

   int he_apiPage =1;
   int hl_apiPage =1;
   int sc_apiPage =1;
   int sp_apiPage =1;
   int te_apiPage =1;

  ProviderState(){
    getHeadlineNews();
    getHealthNews();
    getScienceNews();
    getSportsNews();
    getTechnologyNews();
  }

  /*void updateApiPage(){
    apiPage++;
    notifyListeners();
  }*/

  updatePage(int mpage)async{
    page = mpage;
    notifyListeners();
  }

   updateTpage(int ttpage)async{
     tpage = ttpage;
     notifyListeners();
   }

  Future<void> getHeadlineNews()async{
    String country = SharedPreferenceHelper.getCountry();
    String category = "general";
    int pageSize = 10;

    headlineNews = await NewsRepository().fetchNews(country, category, he_apiPage, pageSize);
    isLoading = false;
    notifyListeners();
  }


  Future<void> getHealthNews()async{
    String country = SharedPreferenceHelper.getCountry();
    String category = "health";
    int pageSize = 10;

    healthNews = await NewsRepository().fetchNews(country, category, hl_apiPage, pageSize);
    isLoading = false;
    notifyListeners();
  }


  Future<void> getScienceNews()async{
    String country = SharedPreferenceHelper.getCountry();
    String category = "science";
    int pageSize = 10;

    scienceNews = await NewsRepository().fetchNews(country, category, sc_apiPage, pageSize);
    isLoading = false;
    notifyListeners();
  }




  Future<void> getSportsNews()async{
    String country = SharedPreferenceHelper.getCountry();
    String category = "sports";
    int pageSize = 10;

    sportsNews = await NewsRepository().fetchNews(country, category, sp_apiPage, pageSize);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getTechnologyNews()async{
    String country = SharedPreferenceHelper.getCountry();
    String category = "technology";
    int pageSize = 10;

    tecnologyNews = await NewsRepository().fetchNews(country, category, te_apiPage, pageSize);
    isLoading = false;
    notifyListeners();
  }

  void updateCustomApiPage(tab)async{
    if(tab==0){
      he_apiPage++;
    }else if(tab==1){
      hl_apiPage++;
    }else if(tab==1){
      sc_apiPage++;
    }else if(tab==1){
      sp_apiPage++;
    }else if(tab==1){
      te_apiPage++;
    }

  }


}