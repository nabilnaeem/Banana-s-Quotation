import 'package:banana/Views/requests/quote%20requ.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Requests'),
        centerTitle: true,
        actions: [
          Hero(
              tag: 'logo',
              child: Image(image: AssetImage('images/logo.png')))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Quote_requ()));
              },
              title: Text('Quotation Requests'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              title: Text('Clients Requests'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              title: Text('Change Status Quotation Requests'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
