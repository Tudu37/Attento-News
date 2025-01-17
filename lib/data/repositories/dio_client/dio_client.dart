
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient{

  Dio _dio = Dio();

  DioClient(){
    _dio.options.baseUrl = "https://newsapi.org";
    _dio.interceptors.add(PrettyDioLogger());
  }
  
  Dio get dio {
    return _dio;
  }

}