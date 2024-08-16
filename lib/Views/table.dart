import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';



class My_Table extends StatefulWidget {
  double h;
  bool edit;
  New_Quotation_Model quotation;
  Data_controller controller;

  My_Table(this.quotation,this.controller,this.h,{ this.edit =false});

  @override
  State<My_Table> createState() => _My_TableState(quotation,controller, edit,h);
}

class _My_TableState extends State<My_Table> {
  double h;
  bool edit;
  Data_controller controller;

  New_Quotation_Model quotation;

  _My_TableState(this.quotation,this.controller, this.edit,this.h);

  List <Item_Model> items=[];

  List <int>ui=[1];

  TextEditingController item=TextEditingController();
  TextEditingController quantity=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController total=TextEditingController();
  TextEditingController add_index=TextEditingController();


  List<TextEditingController> items_ui=[];
  List <TextEditingController>quantity_ui=[];
  List <TextEditingController>price_ui=[];
  List<TextEditingController> total_ui=[];

@override
void initState() {
  ui=quotation.ui;
int sum=ui.fold(0, (sum, item) => sum + item);
items_ui=List.generate(sum, (index) => TextEditingController());
quantity_ui=List.generate(sum, (index) => TextEditingController());
price_ui=List.generate(sum, (index) => TextEditingController());
total_ui=List.generate(ui.length, (index) => TextEditingController());

items=quotation.quotation.items.isEmpty?[Item_Model(item: '', quantity: 1, price: 1,id: '')]:quotation.quotation.items;


for (int i=0; i< items.length;i++){
  setState(() {
    items_ui[i].text=items[i].item;
    quantity_ui[i].text=items[i].quantity.toString();
    price_ui[i].text=items[i].price.toString();
  });

}

}
int sum=0;
int sum2=0;
int ui_index=0;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
            children: [
              Column(
                children: ui.asMap().map((key, value) {
                  sum=key==0?0:sum+ui[key-1];
                  return MapEntry(key, key==0?first_table(items.sublist(0, ui[key]),key,controller,preview: !edit):secound_table(items.sublist(sum, (sum)+ui[key]),key,controller,preview:  !edit));
                }).values.toList(),
              ),
            edit?  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        add_new_row();

                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Text('Add new package',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ):SizedBox(),
            ],
          ),
    )
      ;
  }

  Widget first_table(List<Item_Model> e,int key,Data_controller controller,{bool preview=true}){

    double sum_total=IterableZip([price_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(), quantity_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b);
    return Table(
        border: TableBorder.symmetric(
                      inside: BorderSide(width: h/2000, color: Colors.black),
                      outside: BorderSide(width: h/2000, color: Colors.black)
                  ),
      columnWidths: preview?{

        0:FlexColumnWidth(5),
        1:FlexColumnWidth(4),
        2:FlexColumnWidth(4),

      }:{

        0:FlexColumnWidth(5),
        1:FlexColumnWidth(4),
        2:FlexColumnWidth(4),
        3:FlexColumnWidth(4),

      },


      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [

       TableRow(

           children: preview?[
        text_custum('Item',header: true),
        text_custum('Quantity'),
        text_custum('Total'),

      ]:[
           text_custum('Item',header: true),
          text_custum('Quantity'),
          text_custum('Price'),
          text_custum('Total'),

        ]
       ),
          TableRow(children:
          preview?[
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(

                    children:[ Center(child: Stack(
                      children: [
                        edit? TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (i){
                            e[index].item=items_ui[index+sum].text;
                            update_total(controller);


                            setState(() {

                            });
                          },
                          controller: items_ui[index+sum],):
                        text_custum(items_ui[index+sum].text),
                        edit?   theme_pop_up(index+sum):SizedBox(),

                      ],
                    ))]),)),
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit?  TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (i){
                    e[index].quantity=double.parse(quantity_ui[index+sum].text);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: quantity_ui[index+sum],): text_custum(quantity_ui[index+sum].text)
                )
                ]),)),
            Center(child: text_custum(sum_total.toString())),
          ]:[
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(

                    children:[ Center(child: Stack(
                      children: [
                        edit? TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (i){
                            e[index].item=items_ui[index+sum].text;
                            update_total(controller);


                            setState(() {

                            });
                          },
                          controller: items_ui[index+sum],):
                        text_custum(items_ui[index+sum].text),
                        edit?   theme_pop_up(index+sum):SizedBox(),

                      ],
                    ))]),)),
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit?  TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (i){
                    e[index].quantity=double.parse(quantity_ui[index+sum].text);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: quantity_ui[index+sum],): text_custum(quantity_ui[index+sum].text)
                )
                ]),)),
           Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit? TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (w){
                    e[index].price=double.parse(price_ui[index+sum].text);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: price_ui[index+sum],): text_custum(price_ui[index+sum].text),
                )]),)),
            Center(child: text_custum(sum_total.toString())),
          ]

          ),
    ]);

  }
  Widget secound_table(List<Item_Model> e,int key,Data_controller controller,{bool preview=false}){

    double sum_total=IterableZip([price_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(), quantity_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b);
    return Table(
        border: TableBorder.symmetric(
            inside: BorderSide(width: h/2000, color: Colors.black),
            outside: BorderSide(width: h/2000, color: Colors.black)
        ),
        columnWidths: preview?{

          0:FlexColumnWidth(5),
          1:FlexColumnWidth(4),
          2:FlexColumnWidth(4),


        }:{

          0:FlexColumnWidth(5),
          1:FlexColumnWidth(4),
          2:FlexColumnWidth(4),
          3:FlexColumnWidth(4),

        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
       TableRow(children: preview? [


        SizedBox(),
        SizedBox(),

        SizedBox(),
      ]:[


           SizedBox(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
        ]
       ),
          TableRow(children:
          preview?[
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(

                    children:[ Center(child: Stack(
                      children: [
                        edit? TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (i){
                            e[index].item=items_ui[index+sum].text;
                            update_total(controller);


                            setState(() {

                            });
                          },
                          controller: items_ui[index+sum],):
                        text_custum(items_ui[index+sum].text),
                        edit?   theme_pop_up(index+sum):SizedBox(),

                      ],
                    ))]),)),
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit?  TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (i){
                    e[index].quantity=double.parse(quantity_ui[index+sum].text);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: quantity_ui[index+sum],): text_custum(quantity_ui[index+sum].text)
                )
                ]),)),
            Center(child: text_custum(sum_total.toString())),
          ]:[
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(

                    children:[ Center(child: Stack(
                      children: [
                        edit? TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (i){
                            e[index].item=items_ui[index+sum].text;
                            update_total(controller);


                            setState(() {

                            });
                          },
                          controller: items_ui[index+sum],):
                        text_custum(items_ui[index+sum].text),
                        edit?   theme_pop_up(index+sum):SizedBox(),

                      ],
                    ))]),)),
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit?  TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (i){
                    e[index].quantity=double.parse(quantity_ui[index+sum].text);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: quantity_ui[index+sum],): text_custum(quantity_ui[index+sum].text)
                )
                ]),)),
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit? TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (w){
                    e[index].price=double.parse(price_ui[index+sum].text);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: price_ui[index+sum],): text_custum(price_ui[index+sum].text),
                )]),)),
            Center(child: text_custum(sum_total.toString())),
          ]

          ),
    ]);
  }

Widget theme_pop_up(int index){
    List items=['insert row above','insert row below','remove'];
  return PopupMenuButton(
      position: PopupMenuPosition.under,
      icon: Icon(Icons.more_vert_sharp),
      onSelected: (e){

       switch(e){
         case 'insert row above':on_above(index);
         break;
         case 'insert row below':on_below(index);
         break;
         case 'remove':on_delete(index);

       }
      },
      itemBuilder: (BuildContext bc) {
        return items.map((e) =>  PopupMenuItem(
          child: Center(child: Text(e)),
          value: e,
        ),).toList();
      });

}
on_above(int index){

  ui_index=0;
  sum2=0;
  for(int i =0;index>=sum2;i++){

    sum2=sum2+ui[i];
    ui_index=index<=sum2?i:0;
  }

  setState(() {
    items.insert(index, Item_Model(id:'',item: '', quantity: 0, price: 0));
    items_ui.insert(index, TextEditingController());
    quantity_ui.insert(index, TextEditingController());
    price_ui.insert(index, TextEditingController());
    ui[ui_index]++;

  });

  update_total(controller);




}
on_below(int index){

  ui_index=0;
  sum2=0;

  for(int i =0;index>=sum2;i++){
    sum2=sum2+ui[i];
    ui_index=index<=sum2?i:0;
  }

  setState(() {
    items.insert(index+1, Item_Model(item: '', quantity: 0, price: 0,id: ''));
    items_ui.insert(index+1, TextEditingController());
    quantity_ui.insert(index+1, TextEditingController());
    price_ui.insert(index+1, TextEditingController());
    ui[ui_index]++;
  });
  update_total(controller);




}
on_delete(int index){
  ui_index=0;
  sum2=0;
  for(int i =0;index>=sum2;i++){
    sum2=sum2+ui[i];
    ui_index=index<=sum2?i:0;
  }
  setState(() {
    items.removeAt(index);
    items_ui.removeAt(index);
    quantity_ui.removeAt(index);
    price_ui.removeAt(index);
    ui[ui_index]==1?ui.removeAt(ui_index):ui[ui_index]--;

  });
  update_total(controller);
}
add_new_row(){
    setState(() {
      ui.add(1);
      items.add(Item_Model(item: 'item', quantity: 0, price: 0,id: ''));
      items_ui.add(TextEditingController());
      quantity_ui.add(TextEditingController());
      price_ui.add(TextEditingController());
      items_ui.add(TextEditingController());

    });
    update_total(controller);
}
update_total(Data_controller controller){


   if(price_ui.isNotEmpty || quantity_ui.isNotEmpty){
     controller.get_total_quote(price_ui.map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(),quantity_ui.map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(),true);
     setState(() {

     });

   }


controller.update_table_ui(ui);
controller.update_table_items(items);
  }
Widget text_custum(String text,{bool header=false}){
    return   Center(child: Padding(
      padding:  EdgeInsets.all(header? h/80:h/85),
      child: Text(text,style: TextStyle(fontSize:  h/60,fontWeight: FontWeight.bold),),
    ));
}






}