import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/preview.dart';
import 'package:banana/Views/requests/view%20quote%20requ.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quote_requ extends StatefulWidget {
  const Quote_requ({Key? key}) : super(key: key);

  @override
  State<Quote_requ> createState() => _Quote_requState();
}

class _Quote_requState extends State<Quote_requ> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Data_controller>(
      builder:(controller)=> Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.transparent,
          elevation: 0,

          centerTitle: true,
          actions: [
            Hero(
                tag: 'logo',
                child: Image(image: AssetImage('images/logo.png')))
          ],
        ),
        body: Column(
          children:controller.quote_Request.map((e) => ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=>View_quote_requ(e)));
            },
            title: Text(e.quotation!.client_model.name),
            leading: CircleAvatar(
              child: Text(e.user.name[0]),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          )).toList(),

        ),
      ),
    );
  }

}

