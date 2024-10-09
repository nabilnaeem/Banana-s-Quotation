import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/table.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/material.dart';

import '../models/cinet model.dart';

Widget Quotation_item(Quotation_Model quotation , h,Data_controller controller,List <int>ui){
  print(quotation.client_model.contact);
  return Container(
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
          child: IntrinsicHeight(
              child: My_Table(New_Quotation_Model(quotation: quotation, ui:ui), controller,h)),
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
// Container(
//                         height: h,
//                         width: h*0.70707070,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   blurRadius: 15,
//                                   color: Colors.grey.shade500
//                               )
//                             ]
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: h/4,
//                                   child:Image.asset('images/logo2.png'),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text("Quotation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/55),)
//                               ],),
//                             Padding(
//                               padding:  EdgeInsets.only(top: h/20),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding:  EdgeInsets.symmetric(horizontal: h/10),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Clint : ${quotation[i].quotation.client_model.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/65),),
//                                         SizedBox(height: h/40,),
//                                         Text("Contact : ${quotation[i].quotation.client_model.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/65),),
//
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:  EdgeInsets.only(right: h/8),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Date : ${(quotation[i].quotation.time.day)}/${(quotation[i].quotation.time.month)}/${(quotation[i].quotation.time.year)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/65),),
//                                         SizedBox(height: h/40,),
//                                         Text("Description : ${quotation[i].quotation.dec}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/65),),
//
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//
//
//                             Padding(
//                               padding:  EdgeInsets.only(top: h/30,bottom: 0,right: h/18,left: h/18),
//                               child: IntrinsicHeight(
//                                   child: Column(
//                                     children: quotation[i].ui.asMap().map((key, value) {
//                                        int sum=0;
//
//                                       sum=key==0?0:sum+quotation[i].ui[key-1];
//                                       return MapEntry(key, key==0?
//
//
//                                       Table(
//                                           border: TableBorder.symmetric(
//                                               inside: BorderSide(width: h/2000, color: Colors.black),
//                                               outside: BorderSide(width: h/2000, color: Colors.black)
//                                           ),
//                                           columnWidths: {
//
//                                             0:FlexColumnWidth(5),
//                                             1:FlexColumnWidth(4),
//                                             2:FlexColumnWidth(4),
//                                             3:FlexColumnWidth(4),
//
//                                           },
//
//
//                                           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                                           children: [
//
//                                             TableRow(
//
//                                                 children: [
//                                                   Center(child: Padding(
//                                                     padding:  EdgeInsets.all(h/90),
//                                                     child: Text('Item',style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                   )),
//                                                   Center(child: Padding(
//                                                     padding:  EdgeInsets.all(h/90),
//                                                     child: Text('Quantity',style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                   )),
//                                                   Center(child: Padding(
//                                                     padding:  EdgeInsets.all(h/90),
//                                                     child: Text('Price',style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                   )),
//                                                   Center(child: Padding(
//                                                     padding:  EdgeInsets.all(h/90),
//                                                     child: Text('Total',style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                   )),
//
//
//
//                                                 ]),
//                                             TableRow(children: [
//                                               Table(
//                                                   border: TableBorder.symmetric(
//                                                       inside: BorderSide(width: h/2000, color: Colors.black),
//                                                       outside: BorderSide(width: h/2000, color: Colors.black)
//                                                   ),
//                                                   children: List.generate(quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).length, (index) => TableRow(
//
//                                                       children:[ Center(child:  Center(child: Padding(
//                                                         padding:  EdgeInsets.all(h/85),
//                                                         child: Text(quotation[i].quotation.items[index].item,style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                       )),)]),)),
//                                               Table(
//                                                   border: TableBorder.symmetric(
//                                                       inside: BorderSide(width: h/2000, color: Colors.black),
//                                                       outside: BorderSide(width: h/2000, color: Colors.black)
//                                                   ),
//                                                   children: List.generate(quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).length, (index) => TableRow(
//
//                                                       children:[ Center(child:  Center(child: Padding(
//                                                         padding:  EdgeInsets.all(h/85),
//                                                         child: Text(quotation[i].quotation.items[index].quantity.toString(),style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                       )),)]),)),
//                                               Table(
//                                                   border: TableBorder.symmetric(
//                                                       inside: BorderSide(width: h/2000, color: Colors.black),
//                                                       outside: BorderSide(width: h/2000, color: Colors.black)
//                                                   ),
//                                                   children: List.generate(quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).length, (index) => TableRow(
//
//                                                       children:[ Center(child:  Center(child: Padding(
//                                                         padding:  EdgeInsets.all(h/85),
//                                                         child: Text(quotation[i].quotation.items[index].price.toString(),style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                       )),)]),)),
//                                               Center(child: Text(
//                                      IterableZip([quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).map((e) => e.quantity).toList(), quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).map((e) => e.price).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b).toString()
//
//
//                                               ,style: TextStyle(fontSize:  h/85),)),
//                                             ]),
//                                           ])
//                                           :Table(
//                                           border: TableBorder.symmetric(
//                                               inside: BorderSide(width: h/2000, color: Colors.black),
//                                               outside: BorderSide(width: h/2000, color: Colors.black)
//                                           ),
//                                           columnWidths: {
//
//                                             0:FlexColumnWidth(5),
//                                             1:FlexColumnWidth(4),
//                                             2:FlexColumnWidth(4),
//                                             3:FlexColumnWidth(4),
//
//                                           },
//
//
//                                           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                                           children: [
//
//                                             TableRow(
//
//                                                 children: [
//                                                   SizedBox(),
//                                                   SizedBox(),
//                                                   SizedBox(),
//                                                   SizedBox(),
//
//                                                 ]),
//                                             TableRow(children: [
//                                               Table(
//                                                   border: TableBorder.symmetric(
//                                                       inside: BorderSide(width: h/2000, color: Colors.black),
//                                                       outside: BorderSide(width: h/2000, color: Colors.black)
//                                                   ),
//                                                   children: List.generate(quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).length, (index) => TableRow(
//
//                                                       children:[ Center(child:  Center(child: Padding(
//                                                         padding:  EdgeInsets.all(h/85),
//                                                         child: Text(quotation[i].quotation.items[index].item,style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                       )),)]),)),
//                                               Table(
//                                                   border: TableBorder.symmetric(
//                                                       inside: BorderSide(width: h/2000, color: Colors.black),
//                                                       outside: BorderSide(width: h/2000, color: Colors.black)
//                                                   ),
//                                                   children: List.generate(quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).length, (index) => TableRow(
//
//                                                       children:[ Center(child:  Center(child: Padding(
//                                                         padding:  EdgeInsets.all(h/85),
//                                                         child: Text(quotation[i].quotation.items[index].quantity.toString(),style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                       )),)]),)),
//                                               Table(
//                                                   border: TableBorder.symmetric(
//                                                       inside: BorderSide(width: h/2000, color: Colors.black),
//                                                       outside: BorderSide(width: h/2000, color: Colors.black)
//                                                   ),
//                                                   children: List.generate(quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).length, (index) => TableRow(
//
//                                                       children:[ Center(child:  Center(child: Padding(
//                                                         padding:  EdgeInsets.all(h/85),
//                                                         child: Text(quotation[i].quotation.items[index].price.toString(),style: TextStyle(fontSize:  h/85,fontWeight: FontWeight.bold),),
//                                                       )),)]),)),
//                                               Center(child: Text(
//                                                 IterableZip([quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).map((e) => e.quantity).toList(), quotation[i].quotation.items.sublist( sum, (sum)+quotation[i].ui[key]).map((e) => e.price).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b).toString()
//
//
//                                                 ,style: TextStyle(fontSize:  h/85),)),
//                                             ]),
//                                           ])
//                                       );
//
//                                     }).values.toList().cast<Widget>(),
//                                   )),
//                             ),
//
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: h/18,vertical: h/400),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding:  EdgeInsets.symmetric(horizontal: h/18,vertical: h/400),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/80),),
//
//                                         Text("${quotation[i].quotation.total}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: h/80),),
//
//                                       ],
//                                     ),
//                                   ),
//
//                                   SizedBox(
//                                       width:(h*0.70707070)/1.2,
//                                       child: Divider(
//                                         height: h/100,
//                                         thickness: h/2000,color: Colors.black,)),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Text("ALL PRICES EXCLUDE 14% VAT",style: TextStyle(fontWeight: FontWeight.w900,fontSize: h/95,fontStyle: FontStyle.italic),),
//                                     SizedBox(
//                                         width:(h*0.70707070)/1.3,
//                                         child: Divider(
//                                           height: h/100,
//                                           thickness: h/600,color: Colors.black,)),
//                                     Text("All prices are valid for 48 Hours",
//                                       style: TextStyle(
//
//                                         color: Colors.red,fontWeight: FontWeight.bold,fontSize: h/95,),),
//                                     SizedBox(
//                                         width: (h*0.70707070)/1.3,
//                                         child: Divider(
//                                           height: h/100,
//                                           thickness: h/600,color: Colors.yellow,)),
//                                     Text("(+202) 24 19 2307- (+202) 24 19 23017 103 Omar Ibn El-khattab St., 2nd Floor, Almaza, Heliopolis, Cairo, Egypt.",
//                                       style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: h/100,),),
//
//
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//
//                       )