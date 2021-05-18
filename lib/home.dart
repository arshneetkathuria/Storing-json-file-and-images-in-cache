import 'package:cache_app/api/apiServices.dart';
import 'package:cache_app/podo/datum.dart';
import 'package:cache_app/podo/response.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ApiServices _api_service_provider=new ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Cache Images"),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<Response>(
        future:_api_service_provider.getUser() ,
        builder: (context,snapshot)
         {
          if(snapshot.hasData) {
            List<Datum>? list=snapshot.data?.data;
            return ListView.builder(
              itemCount: list?.length,
                itemBuilder:(context,index)
            {
              Datum user=list![index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:CachedNetworkImageProvider(user.avatar.toString()) ,
                  ),
                  title: Text(user.firstName+" "+user.lastName),
                  subtitle: Text(user.email),
                ),
              );
            });
          }

              return Center(
                child:CircularProgressIndicator()
              );
        },
      ),
    );
  }
}
