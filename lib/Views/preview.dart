import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:html' as html; // For web-specific HTML functionality
import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
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
  bool edit;
  List<New_Quotation_Model> quotation;


  QuotePdf(this.edit, this.quotation);

  @override
  _QuotePdfState createState() => _QuotePdfState(quotation,edit);
}

class _QuotePdfState extends State<QuotePdf> {
  List<New_Quotation_Model> quotation;
  bool edit;


  _QuotePdfState(this.quotation, this.edit);

  final pdf = pw.Document();


  final supabase=Supabase.instance.client;
@override
  void initState() {
    // TODO: implement initState
 quotation.sort((a, b) => b.quotation.time.compareTo(a.quotation.time));

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
        floatingActionButton:!edit? FloatingActionButton(
          backgroundColor: Colors.black,
          child:edit?Icon(Icons.edit,color: Colors.yellow,):Image.asset('images/logo.png'),
          onPressed: (){

                if(!edit){
                  Add_quote(controller);
                }else{
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>New_Quote(quotation[0].quotation,true,controller,quotation[0].ui)));}
          }):SizedBox(),
        body: ListView.builder(
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
                    edit? Positioned(
                     right: 20,left: 20,
                      bottom: 20,
                      child: SizedBox(
                        width:h*0.70707070 ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                _generateAndDownloadPdf(quotation[i], 620, true);
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Text('View & Download',style: TextStyle(fontSize:12,color: Colors.blue,fontWeight: FontWeight.bold),)),
                            ),

                            InkWell(
                              onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (c)=>New_Quote(quotation[i].quotation,true,controller,[1])));},
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Text('Update',style: TextStyle(fontSize:12,color: Colors.orange,fontWeight: FontWeight.bold),)),
                            ),
                            InkWell(
                              onTap: (){
                                List status=['Active','Pending','Cancelled'];
                                pop_up_dialog('', 'Choose', context, true,child: Container(
                                  color: Colors.white,
                                  child: Column(
                                  children: status.map((e) => e==quotation[i].quotation.status?SizedBox():ListTile(title: Text(e),onTap: ()async{
                                    if(controller.current_user!=null){
                                      if(controller.current_user?.admin==true){
                                        Navigator.pop(context);
                                        pop_up_dialog('Status Changed', 'Done', context, false);
                                      }else {
                                       // await send_req(i,e);
                                        Navigator.pop(context);
                                        pop_up_dialog('Waiting for Finance Approval', 'Done', context, false);
                                      }
                                    }


                                  },)).toList(),
                                ),));

                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Text('Change Status',style: TextStyle(fontSize:12,color: Colors.green,fontWeight: FontWeight.bold),)),
                            ),
                          ],
                        ),
                      ),
                    ):SizedBox(),

                  ],
                ),
              ),
            ),

      ),
    ));
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
  requst(Data_controller controller){
  if(controller.current_user.admin){
    Add_quote(controller);
  }else{
    Add_requst(controller);
  }
  }
  Future Add_quote(Data_controller controller)async{
    try{
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
      await supabase.from('Requests').upsert(Request_model(id: 'id', comment: 'comment',
          approval: controller.current_user.admin,
          client: Client_Model(id: '0', name: 'name', phone: 'phone', e_mail: 'e_mail'),
          user: controller.current_user, quotation: quotation[0].quotation).tojson_quote()).select();
      print('pass 5');
    }catch(e){
      print(e);
    }
   // _generateAndDownloadPdf(quotation[0],620,true);


  }
  Future Add_requst(Data_controller controller)async{
    try{
      // await Add_quote(controller);


      print('pass 1');
    }catch(e){
      print(e);
    }
   // _generateAndDownloadPdf(quotation[0],620,true);


  }

}






void _generateAndDownloadPdf(New_Quotation_Model quotation,h,bool _download) async {
  int sum = 0;
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
                          "Contact: ${quotation.quotation.client_model.name}",
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
                          ] as Iterable<Iterable>).map((list) => list[0] * list[1]).reduce((a, b) => a + b).toString(),
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
                  0: pw.FlexColumnWidth(5),
                  1: pw.FlexColumnWidth(4),
                  2: pw.FlexColumnWidth(4),
                  3: pw.FlexColumnWidth(4),
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
                          ] as Iterable<Iterable>).map((list) => list[0] * list[1]).reduce((a, b) => a + b).toString(),
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

      pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: h / 18),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                           pw.Column(
                                    children: [
                                      pw.SizedBox(
                                        width: (h * 0.70707070) / 1.1,
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: h / 15, vertical:h/500),
                                          child: pw.Row(
                                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                            children: [
                                              pw.Text(
                                                'Total',
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: h / 80,
                                                ),
                                              ),
                                              pw.Text(
                                                '${quotation.quotation.total}', // Replace with actual total value
                                                style: pw.TextStyle(
                                                  fontWeight: pw.FontWeight.bold,
                                                  fontSize: h / 80,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      pw.SizedBox(
                                        width: (h * 0.70707070) / 1.1,
                                        child: pw.Divider(
                                          height: h / 100,
                                          thickness: h / 2000,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ],
                                  ),

                        ],
                      ),
                    ),
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

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'example.pdf')
    ..click();

  html.Url.revokeObjectUrl(url);



}




