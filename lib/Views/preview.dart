import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:html' as html; // For web-specific HTML functionality
import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
import 'package:banana/Views/Home.dart';
import 'package:banana/Views/new%20quote.dart';
import 'package:banana/Views/table.dart';
import 'package:banana/models/account%20manger%20model.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:banana/models/resqust_model.dart';
import 'package:banana/models/user_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class QuotePdf extends StatefulWidget {

  bool update;
  bool edit;

  List<New_Quotation_Model> quotation;


  QuotePdf(this.update, this.quotation,{this.edit=false});

  @override
  _QuotePdfState createState() => _QuotePdfState(quotation,update,edit);
}

class _QuotePdfState extends State<QuotePdf> {
  List<New_Quotation_Model> quotation;
  bool update;
  bool edit;


  _QuotePdfState(this.quotation, this.update,this.edit);

  final pdf = pw.Document();

bool loding=false;
  final supabase=Supabase.instance.client;
@override
  void initState() {
    // TODO: implement initState
 quotation.sort((a, b) => b.quotation.time.compareTo(a.quotation.time));
 print(quotation[0].quotation.client_model.tojson());

  }
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height-100;
    double w=MediaQuery.of(context).size.width;
    return GetBuilder<Data_controller>(
      builder:(controller)=> Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          title: Text('Preview',style: TextStyle(color: Colors.white),),


        ),
        floatingActionButton:floating_widget(controller),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: quotation.map((e) => e.quotation).length,
              itemBuilder: (_,i)=>Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            boxShadow: [ BoxShadow(
                                blurRadius: 15,
                                color: Colors.grey.shade500
                            )]
                        ),


                        child:Quotation_item(quotation[i].quotation, h, controller, quotation[i].ui),
                      ),
                      quotation[i].quotation.is_original?  Positioned(

                        top: 10,right: 10,
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Text('Original',style: TextStyle(fontSize:10,color: Colors.white,fontWeight: FontWeight.bold),)),
                      ):SizedBox(),
                      update? Positioned(
                        left: 20,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.black87,
                            child: theme_pop_up(i, controller)),
                      ):SizedBox(),
                      update? Positioned(
                        right: 20,
                        bottom: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(20)
                          ),
                         
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),

                          child: Text(quotation[i].quotation.status,style: TextStyle(color: get_color(quotation[i].quotation.status)),),
                        ),
                      ):SizedBox(),

                    ],
                  ),
                ),
              ),

            ),
            loding?loading(h,w):SizedBox(),

          ],
        ),
    ));
  }
  Widget theme_pop_up(int index,Data_controller controller){
    List items1=['Copy & Update','edit','Download','Active','Cancel'];
    List items2=['Copy & Update','Download'];
    List items=controller.current_user.admin?items1:items2;
    return PopupMenuButton(
        position: PopupMenuPosition.under,
        icon: Icon(Icons.more_vert_sharp,color: Colors.white,),
        onSelected: (e){

          switch(e){
            case 'Copy & Update':on_update(index, controller);
            break;
            case 'Download':on_download(index);
            break;
            case 'edit':on_edit(controller,index);
            break;
            case 'Active':on_change_status('Active',controller,index);
            break;
            case 'Cancel':on_change_status('Cancelled',controller,index);

          }
        },
        itemBuilder: (BuildContext bc) {
          return items.map((e) =>  PopupMenuItem(
            child: Center(child: Text(e)),
            value: e,
          ),).toList();
        });

  }
  on_update(i,controller){
    Navigator.of(context).push(MaterialPageRoute(builder: (c)=>New_Quote(quotation[i].quotation,true,controller,[1])));
}
on_download(i){
  generateAndDownloadPdf(quotation[i], 620, true);

}
  on_edit(Data_controller controller,int index)async{
    // try{
    //   await supabase
    //       .from('quote_requ')
    //       .update({'approval': true})
    //       .eq('id', quotation.id)
    //       .select().then((value) {
    //         controller.quote_requ();
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
    //   });
    // }catch(e){
    //   print(e);
    // }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>New_Quote(quotation[index].quotation, false, controller, quotation[index].quotation.ui,edit: true,)));
    print(true);
  }
on_change_status(String status,controller,i)async{

  try{
    setState(() {
      loding=true;
    });

    await supabase.from('status_requ').upsert(Status_Request_model(id: 'id', comment: 'Please change this status to ${status}',
        approval: controller.current_user.admin,
        user: controller.current_user, quotation: quotation[0].quotation, status: status).tojson_quote()).select();
    print('pass 1');
    await supabase.from('quote').update({'status':status}).eq('id', quotation[i].quotation.id).select();
    print('pass 2');
    setState(() {
      loding=false;
    });

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
    controller.current_user.admin?pop_up_dialog('Changed', 'Done', context, false):pop_up_dialog('Waiting for finance approval..', 'Done', context, false);

  }catch(e){
    print(e);
    setState(() {
      loding=false;
    });
  }
  generateAndDownloadPdf(quotation[0],620,true);


}

  Color get_color(String status){
    Color color=Colors.black87;
    switch(status){
      case 'Pending':color=Colors.orange;
      break;
      case 'Active':color=Colors.green;
      break;
      case 'Cancelled':color=Colors.red;
      break;
    }
    return color;
  }

  Future Add_quote(Data_controller controller)async{
  print('object');
    try{
      setState(() {
        loding=true;
      });
      final id =
          await supabase.from('quote').upsert(quotation[0].quotation.tojson()).select();
      print('pass 1');
     !quotation[0].quotation.is_original? await supabase.from('quote').update({'original_id':quotation[0].quotation.original_id}).eq('id', id[0]['id']).select():{};
      print('pass 2');
     await supabase.from('quote').update({'ui':controller.UI}).eq('id', id[0]['id']).select();
      print('pass 3');
      await supabase.from('items').insert(
          controller.Table_Items.map((e) => e.tojson(id[0]['id'])).toList());
      print('pass 4');
      quotation[0].quotation.id=id[0]['id'].toString();
      await supabase.from('quote_requ').upsert(quotation_Request_Model(id: 'id', comment: 'Please approve on this quote',
          approval: controller.current_user.admin,
          user: controller.current_user, quotation: quotation[0].quotation).tojson_quote()).select();
      print('pass 5');
      setState(() {
        loding=false;
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
      controller.current_user.admin?(){}: pop_up_dialog('Waiting for admin approval..', 'Done', context, false);

    }catch(e){
      print(e);
      setState(() {
        loding=false;
      });
    }
   generateAndDownloadPdf(quotation[0],620,controller.current_user.admin);


  }
  Future edit_quote(Data_controller controller)async{
    quotation[0].quotation.ui=quotation[0].ui;

    try{
      setState(() {
        loding=true;
      });
      final data=  await supabase.from('quote').select('*').eq('id', quotation[0].quotation.id).select('items(id)');
      print(data);
     List old =data[0]['items'].map((item) => item['id']!).toList();
     print(old);
     List newlist =quotation[0].quotation.items.map((e) => int.parse(e.id==''?'0':e.id)).toList();
      print(newlist);
      List remove_list=old.where((element) => !newlist.contains(element)).toList();
      print(remove_list);
      await supabase.from('quote').update(quotation[0].quotation.tojson()).eq('id', quotation[0].quotation.id).select();
      print('1');
     for(int i =0;i<quotation[0].quotation.items.length;i++){
       print('2');
        quotation[0].quotation.items[i].id==''?

        await supabase.from('items').insert(quotation[0].quotation.items[i].tojson(quotation[0].quotation.id)).select():
        await supabase.from('items').update(quotation[0].quotation.items[i].tojson(quotation[0].quotation.id)).eq('id', quotation[0].quotation.items[i].id).select();
       print('3');
        final data=  await supabase.from('quote').select('*').eq('id', quotation[0].quotation.id).select('quote_requ(id)');
       print('4');
       print(data);
       // await supabase.from('quote_requ').update({'approval': true}).eq('id', data[0]['quote_requ'][0]['id']).select();
       print('5');
     }
     for(int i =0;i<remove_list.length;i++){
       print('6 -${i}');
       await supabase.from('items').delete().eq('id', remove_list[i]).select();
     }
      setState(() {
        loding=false;
      });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
     controller.current_user.admin?(){}: pop_up_dialog('Waiting for admin approval..', 'Done', context, false);

    }catch(e){
      print(e);
      setState(() {
        loding=false;
      });
    }
    generateAndDownloadPdf(quotation[0],620,controller.current_user.admin);


  }

 Widget floating_widget(Data_controller controller) {
  Widget widget=SizedBox();
  if(edit || !update){
    widget=FloatingActionButton(
        backgroundColor: Colors.black,
        child:Image.asset('images/logo.png'),
        onPressed: (){

          if(edit){

            edit_quote(controller);
          }else if(update){
           Navigator.of(context).push(MaterialPageRoute(builder: (c)=>New_Quote(quotation[0].quotation,true,controller,quotation[0].quotation.ui)));
          }else{
            Add_quote(controller);
          }
        });
  }
  return widget;

  }

Widget loading(h,w){
  return Container(
    color: Colors.grey.shade100.withOpacity(0.5),
    height: h+100,width: w,
    padding: EdgeInsets.symmetric(horizontal: (w/2)-100,vertical:(w/2)-100 ),

    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
}






void generateAndDownloadPdf(New_Quotation_Model quotation,h,bool _download) async {
  int sum = 0;
  h=620;
  final pdf = pw.Document();
  final imageProvider = pw.MemoryImage(
    (await rootBundle.load('images/logo2.png')).buffer.asUint8List(),
  );



  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => pw.Container(

        child: pw.Column(
          children: [
            pw.Row(
              children: [
                pw.SizedBox(
                  width: h / 4,
                  child: pw.Image(imageProvider),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  "Quotation",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: h / 55,
                  ),
                ),
              ],
            ),
            pw.Padding(
              padding: pw.EdgeInsets.only(top: h / 20),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: h / 10),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Client: ${quotation.quotation.client_model.name}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 65,
                          ),
                        ),
                        pw.SizedBox(height: h / 40),
                        pw.Text(
                          "Contact: ${quotation.quotation.client_model.contact}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 65,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(right: h / 8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Date : ${(quotation.quotation.time.day)}/${(quotation.quotation.time.month)}/${(quotation.quotation.time.year)}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 65,
                          ),
                        ),
                        pw.SizedBox(height: h / 40),
                        pw.Text(
                          "Description: ${quotation.quotation.dec}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 65,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

      pw.Padding(
        padding: pw.EdgeInsets.only(top: h / 30, bottom: 0, right: h / 18, left: h / 18),
        child: pw.Column(
          children: quotation.ui.asMap().map((key, value) {
             sum = key == 0 ? 0 : sum + quotation.ui[key - 1];

            return MapEntry(
              key,
              key == 0
                  ? pw.Table(
                border: pw.TableBorder.symmetric(
                  inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                  outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                ),
                columnWidths: {
                  0: pw.FlexColumnWidth(6),
                  1: pw.FlexColumnWidth(4),
                  2: pw.FlexColumnWidth(4),

                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      pw.Center(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(h / 90),
                          child: pw.Text('Item', style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                        ),
                      ),
                      pw.Center(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(h / 90),
                          child: pw.Text('Quantity', style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                        ),
                      ),
                      pw.Center(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(h / 90),
                          child: pw.Text('Total', style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Table(
                        border: pw.TableBorder.symmetric(
                          inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                          outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                        ),
                        children: List.generate(
                          quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).length,
                              (index) {
                            final item = quotation.quotation.items[sum + index];
                            return pw.TableRow(
                              children: [
                                pw.Center(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(h / 85),
                                    child: pw.Text(item.item, style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      pw.Table(
                        border: pw.TableBorder.symmetric(
                          inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                          outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                        ),
                        children: List.generate(
                          quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).length,
                              (index) {
                            final item = quotation.quotation.items[sum + index];
                            return pw.TableRow(

                              children: [
                                pw.Center(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(h / 85),
                                    child: pw.Text(item.quantity.toString(), style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      pw.Center(
                        child: pw.Text(
            IterableZip([
            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.quantity).toList(),
            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.price).toList(),
            ] as Iterable<Iterable>).map((list) => list[0] * list[1]).reduce((a, b) => a + b)==0?"F.O.C": IterableZip([
                            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.quantity).toList(),
                            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.price).toList(),
                          ] as Iterable<Iterable>).map((list) => list[0] * list[1]).reduce((a, b) => a + b).toString()+" "+"EGP",
                          style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold),
                        ),
                      ),


                    ],
                  ),
                ],
              )
                  : pw.Table(
                border: pw.TableBorder.symmetric(
                  inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                  outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                ),
                columnWidths: {
                  0: pw.FlexColumnWidth(6),
                  1: pw.FlexColumnWidth(4),
                  2: pw.FlexColumnWidth(4)
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.SizedBox(),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Table(
                        border: pw.TableBorder.symmetric(
                          inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                          outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                        ),
                        children: List.generate(
                          quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).length,
                              (index) {
                            final item = quotation.quotation.items[sum + index];
                            return pw.TableRow(
                              children: [
                                pw.Center(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(h / 85),
                                    child: pw.Text(item.item, style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      pw.Table(
                        border: pw.TableBorder.symmetric(
                          inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                          outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                        ),
                        children: List.generate(
                          quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).length,
                              (index) {
                            final item = quotation.quotation.items[sum + index];
                            return pw.TableRow(
                              children: [
                                pw.Center(
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(h / 85),
                                    child: pw.Text(item.quantity.toString(), style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      pw.Center(
                        child: pw.Text(
                          IterableZip([
                            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.quantity).toList(),
                            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.price).toList(),
                          ] as Iterable<Iterable>).map((list) => list[0] * list[1]).reduce((a, b) => a + b)  ==0?"F.O.C":  IterableZip([
                            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.quantity).toList(),
                            quotation.quotation.items.sublist(sum, sum + quotation.ui[key]).map((e) => e.price).toList(),
                          ] as Iterable<Iterable>).map((list) => list[0] * list[1]).reduce((a, b) => a + b).toString()+" "+"EGP",
                          style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold),
                        ),
                      ),


                    ],
                  ),
                ],
              )
            );
          }).values.toList(),
        ),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.only(top: 0, bottom: 10, right: h / 18, left: h / 18),
        child: pw.Table(
              border: pw.TableBorder.symmetric(
                inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
              ),
              columnWidths: {
                0: pw.FlexColumnWidth(10),
                1: pw.FlexColumnWidth(4),
              },
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Table(
                      border: pw.TableBorder.symmetric(
                        inside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                        outside: pw.BorderSide(width: h / 2000, color: PdfColors.black),
                      ),
                      children: [pw.TableRow(
                        children: [
                          pw.Center(
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(h / 85),
                              child: pw.Text('Total', style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold)),
                            ),
                          ),
                        ],
                      )],
                    ),

                    pw.Center(
                      child: pw.Text(
  quotation.quotation.total==0?"F.O.C":  quotation.quotation.total.toString()+" "+"EGP",
                        style: pw.TextStyle(fontSize: h / 85, fontWeight: pw.FontWeight.bold),
                      ),
                    ),


                  ],
                ),
              ],
            ),),///new

      pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ALL PRICES EXCLUDE 14% VAT",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: h / 85,
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                    pw.SizedBox(
                      width: (h * 0.70707070) / 1.2,
                      child: pw.Divider(
                        height: h / 100,
                        thickness: h / 600,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Text(
                      "All prices are valid for 48 Hours",
                      style: pw.TextStyle(
                        color: PdfColors.red,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: h / 85,
                      ),
                    ),
                    pw.SizedBox(
                      width: (h * 0.70707070) / 1.2,
                      child: pw.Divider(
                        height: h / 100,
                        thickness: h / 600,
                        color: PdfColors.yellow,
                      ),
                    ),
                    pw.Text(
                      "(+202) 24 19 2307- (+202) 24 19 23017 103 Omar Ibn El-khattab St., 2nd Floor, Almaza, Heliopolis, Cairo, Egypt.",
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: h / 85,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  final pdfBytes = await pdf.save();
final blob = html.Blob([pdfBytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);

      if(_download){
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '${quotation.quotation.client_model.name}-${quotation.quotation.dec} Quotation.pdf')
      ..click();
  }

  html.Url.revokeObjectUrl(url);



}




