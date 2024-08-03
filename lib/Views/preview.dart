import 'dart:html' as html; // For web-specific HTML functionality
import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
import 'package:banana/Views/new%20quote.dart';
import 'package:banana/models/account%20manger%20model.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class QuotePdf extends StatefulWidget {
  bool edit;
  List<Quotation_Model> quotation;


  QuotePdf(this.edit, this.quotation);

  @override
  _QuotePdfState createState() => _QuotePdfState(quotation,edit);
}

class _QuotePdfState extends State<QuotePdf> {
  List<Quotation_Model> quotation;
  bool edit;


  _QuotePdfState(this.quotation, this.edit);

  final pdf = pw.Document();
  Map total={};
List list=[1,2];
  final supabase=Supabase.instance.client;
@override
  void initState() {
    // TODO: implement initState
  quotation.sort((a, b) => b.time.compareTo(a.time));

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
                  Add_quote();
                }else{
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>New_Quote(quotation[0],true,controller)));}
          }):SizedBox(),
        body: ListView.builder(
          itemCount: quotation.length,
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


                      child: Banner(
                        color: get_color(quotation[i].status),
                        message: quotation[i].status,
                          location: BannerLocation.topStart,
                          child: Quotation_item(quotation[i],h )),
                    ),
                    quotation[i].is_original?  Positioned(

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
                               Navigator.of(context).push(MaterialPageRoute(builder: (c)=>New_Quote(quotation[i],true,controller)));},
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
                                  children: status.map((e) => e==quotation[i].status?SizedBox():ListTile(title: Text(e),onTap: ()async{
                                    if(controller.current_user!=null){
                                      if(controller.current_user?.admin==true){
                                        Navigator.pop(context);
                                        pop_up_dialog('Status Changed', 'Done', context, false);
                                      }else {
                                       await send_req(i,e);
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
            )),

      ),
    );
  }
send_req(int i,select)async{
  try{
    await supabase.from('Requests').insert({'quote':quotation[i].id,'comment':'Please change this Status to ${select}'}).select();
  }catch(e){
    print(e);
    
  }
  
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
  Future Add_quote()async{
    try{
      final id =
          await supabase.from('quote').upsert(quotation[0].tojson()).select();
      print('passs 1');

     !quotation[0].is_original? await supabase.from('quote').update({'original_id':quotation[0].original_id}).eq('id', id[0]['id']).select():{};
      print('pass 2');
      await supabase.from('items').insert(
          quotation[0].items.map((e) => e.tojson(id[0]['id'])).toList());
      print('pass 3');
    }catch(e){
      print(e);
    }
    _generateAndDownloadPdf(quotation[0],620,true);


  }
}

void _generateAndDownloadPdf(Quotation_Model quotation,h,bool _download) async {
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
                          "Client: ${quotation.client_model.name}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 65,
                          ),
                        ),
                        pw.SizedBox(height: h / 40),
                        pw.Text(
                          "Contact: ${quotation.client_model.name}",
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
                          "Date : ${(quotation.time.day)}/${(quotation.time.month)}/${(quotation.time.year)}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 65,
                          ),
                        ),
                        pw.SizedBox(height: h / 40),
                        pw.Text(
                          "Description: ${quotation.dec}",
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
              padding: pw.EdgeInsets.only(
                top: h / 30,
                bottom: 0,
                right: h / 18,
                left: h / 18,
              ),
              child: pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black, width: h / 2000),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.only(top: h/100,left:h/100,right: h/100,bottom: 0 ),
                        child: pw.Text(
                          'Item',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 85,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(h / 100),
                        child: pw.Text(
                          'Quantity',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 85,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(h / 100),
                        child: pw.Text(
                          'Price',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 85,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(h / 100),
                        child: pw.Text(
                          'Total',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: h / 85,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // Generate rows from your data list
                  ...quotation.items.map(
                     // Replace with your data length
                        (index) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(h / 100),
                          child: pw.Text(
                            '${index.item}',
                            style: pw.TextStyle(
                              fontSize: h / 85,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(h / 100),
                          child: pw.Text(
                            '${index.quantity}',
                            style: pw.TextStyle(
                              fontSize: h / 85,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(h / 100),
                          child: pw.Text(
                            '${index.price}',
                            style: pw.TextStyle(
                              fontSize: h / 85,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(h / 100),
                          child: pw.Text(
                            '${index.quantity*index.price}',
                            style: pw.TextStyle(
                              fontSize: h / 85,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                                          padding: pw.EdgeInsets.symmetric(horizontal: h / 20, vertical:h/500),
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
                                                '${quotation.total}', // Replace with actual total value
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




