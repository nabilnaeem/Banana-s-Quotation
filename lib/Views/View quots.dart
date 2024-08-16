import 'package:banana/Views/preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../Controllers/Data controller.dart';
import '../Controllers/widgets.dart';
import '../models/quote model.dart';

class View_Quotations extends StatefulWidget {
  List<Quotation_Model> Quotations;
  String title;

  View_Quotations(this.Quotations, this.title);



  @override
  State<View_Quotations> createState() => _View_QuotationsState(Quotations,title);
}

class _View_QuotationsState extends State<View_Quotations> {
  List<Quotation_Model> Quotations;
  String title;

  _View_QuotationsState(this.Quotations, this.title);

  List<Quotation_Model> output=[];

  DateTime selectedDate_from=DateTime.now();
  DateTime selectedDate_to=DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    if(Quotations.length!=0){
      init();
    }
  }
  init(){
    selectedDate_from=Quotations.first.time;
    selectedDate_to=Quotations.last.time;
    Quotations=Quotations..sort((a, b) => a.time.compareTo(b.time));
    output=Quotations;
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  GetBuilder<Data_controller>(
        builder:(controller)=> Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black87,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(title),
            centerTitle: true,
            actions: [
              Hero(
                  tag: 'logo',
                  child: Image(image: AssetImage('images/logo.png')))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child:w>700? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              selectedDate_from == null
                                  ? 'Select a date from : '
                                  : 'Selected Date from :  ${selectedDate_from!.day}/${selectedDate_from!.month}/${selectedDate_from!.year}',
                              style: TextStyle(fontWeight: FontWeight.bold),

                            ),
                            SizedBox(height: 20.0),
                            IconButton(onPressed: ()async{
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate_from ?? DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null ) {
                                setState(() {
                                  selectedDate_from = picked;
                                  output = Quotations.toList().where((event) =>
                                  event.time.isAfter(selectedDate_from.subtract(Duration(seconds: 1))) &&
                                      event.time.isBefore(selectedDate_to.add(Duration(days: 1)))).toList();
                                });

                              }
                            }, icon: Icon(Icons.date_range)),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              selectedDate_to == null
                                  ? 'Select a date to : '
                                  : 'Selected Date to :  ${selectedDate_to!.day}/${selectedDate_to!.month}/${selectedDate_to!.year}',
                              style: TextStyle(fontWeight: FontWeight.bold),

                            ),
                            SizedBox(height: 20.0),
                            IconButton(onPressed: ()async{
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate_to ?? DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null ) {
                                setState(() {
                                  selectedDate_to = picked;
                                  output = Quotations.toList().where((event) =>
                                  event.time.isAfter(selectedDate_from.subtract(Duration(seconds: 1))) &&
                                      event.time.isBefore(selectedDate_to.add(Duration(days: 1)))).toList();
                                });
                              }
                            }, icon: Icon(Icons.date_range)),

                          ],
                        ),
                      ),
                    ],
                  ):Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              selectedDate_from == null
                                  ? 'Select a date from : '
                                  : 'Selected Date from :  ${selectedDate_from!.day}/${selectedDate_from!.month}/${selectedDate_from!.year}',
                              style: TextStyle(fontWeight: FontWeight.bold),

                            ),
                            SizedBox(height: 20.0),
                            IconButton(onPressed: ()async{
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate_from ?? DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null ) {
                                setState(() {
                                  selectedDate_from = picked;
                                  // output = Quotations.toList().where((event) =>
                                  // event.time.isAfter(selectedDate_from.subtract(Duration(seconds: 1))) &&
                                  //     event.time.isBefore(selectedDate_to.add(Duration(days: 1)))).toList();
                                  //
                                });

                              }
                            }, icon: Icon(Icons.date_range)),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              selectedDate_to == null
                                  ? 'Select a date to : '
                                  : 'Selected Date to :  ${selectedDate_to!.day}/${selectedDate_to!.month}/${selectedDate_to!.year}',
                              style: TextStyle(fontWeight: FontWeight.bold),

                            ),
                            SizedBox(height: 20.0),
                            IconButton(onPressed: ()async{
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate_to ?? DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null ) {
                                setState(() {
                                  selectedDate_to = picked;
                                  // output = Quotations.toList().where((event) =>
                                  // event.time.isAfter(selectedDate_from.subtract(Duration(seconds: 1))) &&
                                  //     event.time.isBefore(selectedDate_to.add(Duration(days: 1)))).toList();
                                  //
                                });
                              }
                            }, icon: Icon(Icons.date_range)),

                          ],
                        ),
                      ),
                    ],
                  ),

                ),
                SizedBox(
                  height: (((w/get_width_length(w))/0.707070)*((filterEvents().length<get_width_length(w)?get_width_length(w):filterEvents().length)/get_width_length(w)).ceil())+100,
                  child: GridView.builder(

                      padding: EdgeInsets.all(20),
                      itemCount: filterEvents().where((element) => element.is_original).length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: get_width_length(w),mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 0.7),
                      itemBuilder: (c,i){
                        List <Quotation_Model> quotes=get_quotes_updates(filterEvents()[i]);
                        int edits=filterEvents().where((element) => element.original_id==filterEvents()[i].id).toList().length;
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>QuotePdf(
                                true,
                                quotes.map((e) => New_Quotation_Model(quotation: e, ui: [1])).toList()
                            )));
                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Quotation_item(filterEvents()[i],((w/get_width_length(w))/0.707070)-50,controller,[1]),
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Text(filterEvents()[i].status,style: TextStyle(fontSize:10,color: get_color(filterEvents()[i].status),fontWeight: FontWeight.bold),)),
                                  edits==0?SizedBox():
                                  Positioned(
                                    top: 2,right: 2,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius: BorderRadius.circular(100)
                                        ),
                                        child: Text('${edits.toString()}${edits==1? ' update':' updates'}',style: TextStyle(fontSize:10,color: Colors.blue,fontWeight: FontWeight.bold),)),
                                  ),

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text('${filterEvents()[i].client_model.name} _ ${filterEvents()[i].dec}',style: TextStyle(fontWeight: FontWeight.w600),),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),

        ),
      );

  }
  List <Quotation_Model> get_quotes_updates(Quotation_Model item){
    List <Quotation_Model> updates=[];
    updates=filterEvents().where((element) => element.original_id==item.id).toList();
    updates.insert(0,item);
    return updates;
  }
  List<Quotation_Model> filterEvents() {
    List<Quotation_Model> events=Quotations.toList().where((element) =>  element.approval==true).toList();
    DateTime startDate =selectedDate_from;
    DateTime endDate =selectedDate_to;


    return events.where((event) {
      bool matchesDate = true;
      bool matchesSearch = true;
      bool matchesStatus = true;

      if (startDate != null && endDate != null) {
        matchesDate = event.time.isAfter(startDate.subtract(Duration(seconds: 1))) && event.time.isBefore(endDate.add(Duration(days: 1)));
      }


      return matchesDate && matchesSearch && matchesStatus;
    }).toList();
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
  int get_width_length(w){

    if(w<600){
      w=2;

    }else if(w<800){
      w=3;

    }else if(w<1100){
      w=4;

    }else if(w<1500){
      w=5;

    }else if(w<1700){
      w=6;

    }else if(w<1900){
      w=7;

    }else{
      w=8;

    }
    return w;
  }
}
