
import 'package:attento_news/data/models/news_model.dart';
import 'package:attento_news/data/repositories/dio_client/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsRepository{

  DioClient dioClient = DioClient();

  Future<NewsModel> fetchNews(String country,String category,int apiPage,int pageSize,)async{

    String url = "/v2/top-headlines?country=${country}&category=${category}&apiKey=c63e1e8d748748fab07d0a4f2c8fdf47&page=${apiPage}&pageSize=${pageSize}";

    try{
      Response response = await dioClient.dio.get(url);
      var data = response.data;
      return NewsModel.fromJson(data);
    }on DioException catch(ex){
     throw ex;
    }
  }

}