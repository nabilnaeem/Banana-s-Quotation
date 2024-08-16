import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/clients/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Data_controller>(
      builder:(controller)=> Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Clients'),
          centerTitle: true,
          actions: [
            Hero(
                tag: 'logo',
                child: Image(image: AssetImage('images/logo.png')))
          ],
        ),
        body: Column(
          children: controller.Clints2.map((e) => Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Client(e)));
                },
                title: Text(e.name),trailing: Icon(Icons.arrow_forward_ios_rounded),),
              SizedBox(height: 5,),
              Divider(),
            ],
          )).toList(),
        ),
      ),
    );
  }
}
