import 'package:dio/dio.dart';

class ApiProvider {
  //Dio _dio;
  String aToken = '';

  final BaseOptions options = BaseOptions(
    baseUrl: 'http://3.8.141.177:6001/gateway',
    connectTimeout: 15000,
    receiveTimeout: 13000,
  );

  //static late final ApiProvider _instance = ApiProvider._internal();

  //actory ApiProvider() => _instance;

  // ApiProvider._internal() {
  //   _dio = Dio(options);
  //   _dio.interceptors.add(InterceptorsWrapper(
  //       onRequest:(Options options) async {
  //         // to prevent other request enter this interceptor.
  //         _dio.interceptors.requestLock.lock();
  //         // We use a new Dio(to avoid dead lock) instance to request token.
  //         //Set the cookie to headers
  //         options.headers["cookie"] = aToken;
  //
  //         _dio.interceptors.requestLock.unlock();
  //         return options; //continue
  //       }
  //   ));
  // }

  Future login() async {
    final request = {
      "userName": "Chinmay@gmail.com",
      "password": "123456",
      "token": "123456"
    };
    //final response = await _dio.post('/user/login', data: request);
    //get cooking from response
    //final cookies = response.headers.map['set-cookie'];
    //   if (cookies.isNotEmpty && cookies.length == 2) {
    //     final authToken = cookies[1].split(';')[0]; //it depends on how your server sending cookie
    //     //save this authToken in local storage, and pass in further api calls.
    //
    //     aToken = authToken; //saving this to global variable to refresh current api calls to add cookie.
    //     print(authToken);
    //   }
    //
    //   print(cookies);
    //   //print(response.headers.toString());
    // }

    /// If we call this function without cookie then it will throw 500 err.
    Future getRestaurants() async {
      //final response = await _dio.post('/restaurant/all');

      //print(response.data.toString());
    }
  }
}