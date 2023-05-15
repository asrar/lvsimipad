// import 'dart:async';
// import 'dart:convert';
// //import 'package:http/http.dart' as http;
// //import 'package:email_client/todo/Todo.dart';
//
// class TestJSONService {
//   static String _url = 'https://jsonplaceholder.typicode.com/todos';
//   // URL
//
//   static Future browse() async {
//     print("printing from service >>>");
//     Map<String,String> header = {
//       "Content-Type" : "application/json",
//     };
//
//     Map<String,String> data = {
//       "user_id": "3",
//       "item_category_id": "2",
//       "post_date": "21-04-2021",
//       "api_token": "dKz99vl2FrdIpccgb1GUbXcNgfzpqvLrEg6gs5EscioQzy2iwdezfWEuLUY2",
//
//     };
//
//     Map<String,String> userHeader = {"Content-type": "application/json", "Accept": "application/json"};
//
//
//        Uri _urlString  = Uri.http("welldoneapps.net", "/7min/public/api/getposts",data);
//     http.Response response = await http.post(_urlString,
//         headers: userHeader);
//     String content = response.body;
//     print("##################################################");
//     print("${content}");
//     print("##################################################");
//
//        return null;
//   }
//
// }
//
// void main() {
//
//   TestJSONService.browse();
// }
