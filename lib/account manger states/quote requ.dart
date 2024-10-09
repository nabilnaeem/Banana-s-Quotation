import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/preview.dart';
import 'package:banana/Views/requests/view%20quote%20requ.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quote_req extends StatefulWidget {
  const Quote_req({Key? key}) : super(key: key);

  @override
  State<Quote_req> createState() => _Quote_reqState();
}

class _Quote_reqState extends State<Quote_req> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Data_controller>(
      builder:(controller)=> Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Your Quotation's Requests "),
          centerTitle: true,
          actions: [
            Hero(
                tag: 'logo',
                child: Image(image: AssetImage('images/logo.png')))
          ],
        ),
        body:list(controller).isNotEmpty? Column(
          children:list(controller).map((e) => ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=>View_quote_requ(e)));
            },
            title: Text("${e.quotation!.client_model.name} / ${e.quotation!.dec}"),
            leading: CircleAvatar(
              child: Text(e.user.name,style: TextStyle(fontSize: 10),),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          )).toList(),

        ):Center(child: Text("You don't have any quotation request !"),),
      ),
    );
  }
 List list(Data_controller controller){
    List req=[];
    req=controller.quote_Request.where((element) => element.quotation.account_manger_model.e_mail==controller.current_user.email).toList();
    return req;
  }

}

