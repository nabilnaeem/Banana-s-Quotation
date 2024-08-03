import 'dart:html';

import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
import 'package:banana/Views/preview.dart';
import 'package:banana/models/account%20manger%20model.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends StatefulWidget {
  List<Quotation_Model> Quotations;


  History(this.Quotations);

  @override
  State<History> createState() => _HistoryState(Quotations);
}

class _HistoryState extends State<History> {
  TextEditingController search_input=TextEditingController() ;
  var search_by;
  List Search_by=['Description','Client','status','Account Manger'];


  List<Quotation_Model> Quotations;

  _HistoryState(this.Quotations);

  DateTime selectedDate_from=DateTime.now();
  DateTime selectedDate_to=DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
   Quotations= Quotations..sort((a, b) => b.time.compareTo(a.time));
    selectedDate_from=Quotations.last.time;
    selectedDate_to=Quotations.first.time;



  }
  List radioo=['All','Active','Pending','Cancelled'];
  int radio=0;


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;



    return GetBuilder<Data_controller>(

      builder:(controller)=> Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('History'),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: TextFormField(

                        controller: search_input,
                        onChanged: (e){
                          setState(() {

                          });
                          // List <Quotation_Model>list=Quotations.toList().where((event) =>
                          // event.time.isAfter(selectedDate_from.subtract(Duration(seconds: 1))) &&
                          //     event.time.isBefore(selectedDate_to.add(Duration(days: 1)))&& event.status.toLowerCase().contains(radioo[radio]=='All'?'':radioo[radio]))  .toList();
                          // setState(() {
                          //   output=list.toList().where((i) {
                          //     String title=search_by=='Description'?i.dec.toLowerCase():
                          //     search_by=='Client'?i.client_model.name.toLowerCase():
                          //     search_by=='status'?i.status.toLowerCase():
                          //     search_by=='Account Manger'?i.account_manger_model.name.toLowerCase():'';
                          //     String input=search_input.text.toLowerCase();
                          //
                          //     return title.contains(input);
                          //   }).toList();
                          //
                          // });

                        },
                        decoration: InputDecoration(
                          hintText:'Search by Client , Description or Account manger ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    )),

                  ],
                ),
              ),
              w<700? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(

                          activeColor: Colors.black,
                          title: Text('All'),
                            value: 0, groupValue: radio, onChanged: (e){
                          setState(() {
                            radio=e!;
                          });
                        }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            activeColor: Colors.green,
                          title: Text('Active'),
                            value: 1, groupValue: radio, onChanged: (e){
                          setState(() {
                            radio=e!;
                          });
                        }),
                      ),


                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                            activeColor: Colors.orange,
                            title: Text('Pending'),
                            value: 2, groupValue: radio, onChanged: (e){
                          setState(() {
                            radio=e!;
                            // output=Quotations.toList().where((element) => element.status==radioo[radio]).toList();

                          });
                        }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            activeColor: Colors.red,
                            title: Text('Cancelled'),
                            value: 3, groupValue: radio, onChanged: (e){
                          setState(() {
                            radio=e!;
                            // output=Quotations.toList().where((element) => element.status==radioo[radio]).toList();

                          });
                        }),
                      ),

                    ],
                  ),
                ],
              ):
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(

                        activeColor: Colors.black,
                        title: Text('All'),
                        value: 0, groupValue: radio, onChanged: (e){
                      setState(() {
                        radio=e!;
                      });
                    }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        activeColor: Colors.green,
                        title: Text('Active'),
                        value: 1, groupValue: radio, onChanged: (e){
                      setState(() {
                        radio=e!;
                      });
                    }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        activeColor: Colors.orange,
                        title: Text('Pending'),
                        value: 2, groupValue: radio, onChanged: (e){
                      setState(() {
                        radio=e!;
                        // output=Quotations.toList().where((element) => element.status==radioo[radio]).toList();

                      });
                    }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        activeColor: Colors.red,
                        title: Text('Cancelled'),
                        value: 3, groupValue: radio, onChanged: (e){
                      setState(() {
                        radio=e!;
                        // output=Quotations.toList().where((element) => element.status==radioo[radio]).toList();

                      });
                    }),
                  ),

                ],
              ),
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
                               
                              });
                            }
                          }, icon: Icon(Icons.date_range)),

                        ],
                      ),
                    ),
                  ],
                ):
                Column(
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
                  physics: NeverScrollableScrollPhysics(),

                  padding: EdgeInsets.all(20),
                  itemCount: filterEvents().length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: get_width_length(w),mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 0.7),
                    itemBuilder: (_,i){
                    List <Quotation_Model> quotes=get_quotes_updates(filterEvents()[i]);
                    int edits=Quotations.where((element) => element.original_id==filterEvents()[i].id).toList().length;
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>QuotePdf(
                            true,
                          quotes
                        )));
                      },
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Quotation_item(filterEvents()[i],((w/get_width_length(w))/0.707070)-50),
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
                            child: Text('${filterEvents()[i].client_model.name} / ${filterEvents()[i].dec}',style: TextStyle(fontWeight: FontWeight.w600),),
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
    updates=Quotations.where((element) => element.original_id==item.id).toList();
    updates.insert(0,item);
    return updates;
}
  List<Quotation_Model> filterEvents() {
    List<Quotation_Model> events=Quotations.toList().where((element) => element.is_original==true ).toList();
    DateTime startDate =selectedDate_from;
    DateTime endDate =selectedDate_to;
    String searchTerm=search_input.text;
    String? status= radioo[radio];

    return events.where((event) {
      bool matchesDate = true;
      bool matchesSearch = true;
      bool matchesStatus = true;

      if (startDate != null && endDate != null) {
        matchesDate = event.time.isAfter(startDate.subtract(Duration(seconds: 1))) && event.time.isBefore(endDate.add(Duration(days: 1)));
      }

      if (searchTerm != null && searchTerm.isNotEmpty) {
        matchesSearch =event.dec.toLowerCase().contains(searchTerm.toLowerCase()) ||
            event.client_model.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
            event.account_manger_model.name.toLowerCase().contains(searchTerm.toLowerCase())
      ;
      }

      if ( status!='All') {
        matchesStatus = event.status.toLowerCase() == status!.toLowerCase();
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
