import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/table.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cinet model.dart';

Widget Quotation_item(Quotation_Model quotation , h,List <int>ui){


  return GetBuilder<Data_controller>(
    builder:(controller)=> Container(
      clipBehavior: Clip.hardEdge,
      height: h,
      width: h*0.70707070,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 15,
             color: Colors.grey.shade500
            )
          ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: h/4,
                child:Image.asset('images/logo2.png'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Quotation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/55),)
            ],),
          Padding(
            padding:  EdgeInsets.only(top: h/20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: h/20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Clint : ${quotation.client_model.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/70),),
                      SizedBox(height: h/40,),
                      Text("Contact : ${quotation.client_model.contact}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/70),),

                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: h/10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date : ${(quotation.time.day)}/${(quotation.time.month)}/${(quotation.time.year)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/65),),
                      SizedBox(height: h/40,),
                      Text("Description : ${quotation.dec}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/70,),),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: h/30,bottom: 10,right: h/18,left: h/18),
            child: My_Table(quotation.copy(), controller,h,quotation.items),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("ALL PRICES EXCLUDE 14% VAT",style: TextStyle(fontWeight: FontWeight.w900,fontSize: h/95,fontStyle: FontStyle.italic),),
                  SizedBox(
                      width:(h*0.70707070)/1.3,
                      child: Divider(
                        height: h/100,
                        thickness: h/600,color: Colors.black,)),
                  Text("All prices are valid for 48 Hours",
                    style: TextStyle(

                      color: Colors.red,fontWeight: FontWeight.bold,fontSize: h/95,),),
                  SizedBox(
                      width: (h*0.70707070)/1.3,
                      child: Divider(
                        height: h/100,
                        thickness: h/600,color: Colors.yellow,)),
                  Text("(+202) 24 19 2307- (+202) 24 19 23017 103 Omar Ibn El-khattab St., 2nd Floor, Almaza, Heliopolis, Cairo, Egypt.",
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: h/100,),),


                ],
              )
            ],
          )
        ],
      ),

    ),
  );
}
pop_up_dialog(String body,String title,context,child_bool, {  child}){

  return showDialog(


      context: context,

      builder: (c) => AlertDialog(


        backgroundColor: Colors.transparent,
        elevation: 0,

        content:child_bool?Container(
          child: IntrinsicHeight(
            child: IntrinsicWidth(child: child),
          ),
        ): Container(
          child: IntrinsicHeight(
            child: IntrinsicWidth(child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(title),
                  SizedBox(height: 5,),
                  Divider(),
                  SizedBox(height: 5,),
                  Text(body,textAlign: TextAlign.center,),
                ],
              ),
            )),
          ),
        ) ,
      ));
}
