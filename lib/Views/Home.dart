import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/Login.dart';
import 'package:banana/Views/View%20quots.dart';
import 'package:banana/Views/clients/clients.dart';
import 'package:banana/Views/history.dart';
import 'package:banana/Views/requests/quote%20requ.dart';
import 'package:banana/Views/requests/requests.dart';
import 'package:banana/account%20manger%20states/quote%20requ.dart';

import 'package:banana/models/account%20manger%20model.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'new quote.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final supabase=Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return GetBuilder<Data_controller>(
      builder:(controller)=> Scaffold(

        body: Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: h-50,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: ()async{
                            await supabase.auth.signOut().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Login())));
                          }, child: Text("LOGOUT",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                          SizedBox(
                            width: 100,
                            child: Hero(
                                tag: 'logo',
                                child: Image.asset('images/logo.png')),
                          )
                        ],
                      ),
                      Text(' Home ',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 15,),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>New_Quote(Quotation_Model(
                              ui: [1],
                              is_original: true,original_id: '',
                              id: 'iid', dec: 'dec', client_model: Client_Model(id: 'id', name: 'name', phone: 'phone', e_mail: 'e_mail',contact: ''), time: DateTime.now(), account_manger_model:Account_manger_Model(id: 'id', name: 'name', phone: 'phone', e_mail: 'e_mail'), total: 0, items: [
                            Item_Model(item: '', quantity: 0, price: 0,id: ''),

                          ]),false,controller,[1])));
                        },
                        title: Text('Create New Quotation'),trailing: Icon(Icons.arrow_forward_ios_rounded),),
                      Divider(),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Quote_req()));
                        },
                        title: Text('Pending Quotations'),trailing: Icon(Icons.arrow_forward_ios_rounded),),
                      Divider(),
                      controller.current_user.admin? ListTile(trailing: Icon(Icons.arrow_forward_ios_rounded),
                        title: Text('Quotation History'),onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (c)=>History(controller.Quotations)));},):SizedBox(),
                      controller.current_user.admin? Divider():SizedBox(),
                      controller.current_user.admin?  ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>History(controller.Quotations.where((element) => element.status=='Cancelled').toList())));
                        },
                        title: Text('Cancelled Quotation'),trailing: Icon(Icons.arrow_forward_ios_rounded),):SizedBox(),
                      controller.current_user.admin?  Divider():SizedBox(),
                      controller.current_user.admin? ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>History(controller.Quotations.where((element) => element.status=='Active').toList())));

                        },
                        title: Text('Approved Quotation'),trailing: Icon(Icons.arrow_forward_ios_rounded),):SizedBox(),
                      controller.current_user.admin? Divider():SizedBox(),
                      ListTile(title: Text('Clients'), onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Clients()));
                      },
                        trailing: Icon(Icons.arrow_forward_ios_rounded),),
                      controller.current_user.admin?  Divider():SizedBox(),
                      controller.current_user.admin? ListTile(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Quote_requ()));

                        },
                        title: Text('Requests'),trailing: Icon(Icons.arrow_forward_ios_rounded),):SizedBox(),


                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.current_user.name),
                    Text(controller.current_user.Department),
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
