import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
import 'package:banana/Views/Home.dart';
import 'package:banana/Views/new%20quote.dart';
import 'package:banana/Views/preview.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:banana/models/resqust_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class View_quote_requ extends StatefulWidget {
quotation_Request_Model quotation;


View_quote_requ(this.quotation);

  @override
  State<View_quote_requ> createState() => _View_quote_requState(quotation);
}

class _View_quote_requState extends State<View_quote_requ> {
  quotation_Request_Model quotation;

  _View_quote_requState(this.quotation);
  final supabase=Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height-100;
    double w=MediaQuery.of(context).size.width;
    return GetBuilder<Data_controller>(
      builder:(controller)=> Scaffold(
        appBar: AppBar(
          title: Text(quotation.comment),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Quotation_item(quotation.quotation, h, controller, quotation.quotation.ui),
                ],
              ),
              SizedBox(width: 10,),
              Divider(),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      approval(controller);
                    }, child: Text('Approve')),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: (){

                    }, child: Text('Refuse')),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: (){
                      generateAndDownloadPdf(New_Quotation_Model(quotation: quotation.quotation, ui: quotation.quotation.ui), h, true);
                    }, child: Text('Download')),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: (){
                      edit(controller, quotation.quotation);
                    }, child: Text('Edit')),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  approval(Data_controller controller)async{
    try{
      await supabase
          .from('quote_requ')
          .update({'approval': true})
          .eq('id', quotation.id)
          .select().then((value) {
            controller.quote_requ();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
      });
    }catch(e){
      print(e);
    }
  }
  Refuse(Data_controller controller)async{
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
  }
  edit(Data_controller controller,Quotation_Model quotation)async{
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>New_Quote(quotation, true, controller, quotation.ui,edit: true,)));
  }
}
