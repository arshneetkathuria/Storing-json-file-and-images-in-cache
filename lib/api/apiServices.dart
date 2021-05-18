import 'dart:convert';
import 'dart:io';

import 'package:cache_app/podo/response.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
class ApiServices
{
  var  url=Uri.parse("https://reqres.in/api/users");


  Future<Response> getUser() async{
    print("=========LOADING FROM CACHE FILE=============");
      String fileName = "userData.json";
      var dir = await getTemporaryDirectory();
      File file = new File(dir.path + "/" + fileName);
      if (file.existsSync()) {
        var jsonData = file.readAsStringSync();
        Response response = Response.fromJson(json.decode(jsonData));
        return response;
      }
      else {
        print("==========LOADING WITH API==============");
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var jsonResponse = response.body;
          Response res = Response.fromJson(json.decode(jsonResponse));
          //save locally in file

          file.writeAsStringSync(jsonResponse,flush: true,mode: FileMode.write);
          return res;
        }
      }


      throw
    {
      print("null value")
    };

}
}