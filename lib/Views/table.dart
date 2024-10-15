import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';



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
  List <GlobalKey> table_space=[];
  List<double> table_heigth=[];
@override
void initState() {

  ui=quotation.ui;
int sum=ui.fold(0, (sum, item) => sum + item);
items_ui=List.generate(sum, (index) => TextEditingController());
quantity_ui=List.generate(sum, (index) => TextEditingController());
price_ui=List.generate(sum, (index) => TextEditingController());
total_ui=List.generate(ui.length, (index) => TextEditingController());
items=quotation.quotation.items.isEmpty?[Item_Model(item: '', quantity: 1, price: 1,id: '')]:quotation.quotation.items;
table_space=List.generate(items.length, (index) => GlobalKey());
table_heigth=List.generate(table_space.length, (index) => 0.0);


for (int i=0; i< items.length;i++){
  setState(() {
    items_ui[i].text=items[i].item;
    quantity_ui[i].text=items[i].quantity.toString();
    price_ui[i].text=items[i].price.toString();
  });

}
  WidgetsBinding.instance.addPostFrameCallback((_) {
    for (int i = 0; i < items.length; i++) {
      final RenderBox renderBox = table_space[i].currentContext?.findRenderObject() as RenderBox;
      if (renderBox != null) {
        setState(() {
          table_heigth[i] = renderBox.size.height; // Get the height for each row
        });

    }}
    controller.height=table_heigth;
    controller.update();
  });

}
int sum=0;
int sum2=0;
int ui_index=0;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<Data_controller>(
      builder:(controller)=> SingleChildScrollView(
        child: Column(
              children: [
                Column(
                  children: ui.asMap().map((key, value) {

                    print(key);
                     sum=key==0?0:sum+ui[key-1];
                     print(items.sublist(sum, (sum)+ui[key]));
                    return MapEntry(key, key==0?first_table(items.sublist(0, ui[key]),key,controller,h,preview: !edit):
                    secound_table(items.sublist(sum, (sum)+ui[key]),key,controller,h,preview:  !edit));
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
                ):therd_table(h),
              ],
            ),
      ),
    )
      ;
  }


  Widget first_table(List<Item_Model> e,int key,Data_controller controller,h,{bool preview=true}){



    double sum_total0=IterableZip([price_ui.sublist(0, ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(), quantity_ui.sublist(0, ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b);
    String sum_total = NumberFormat('#,###').format(double.parse(sum_total0.toString()));


    return Table  (
        border: TableBorder(
          left: BorderSide(width: h / 2000, color: Colors.black),
          right: BorderSide(width: h / 2000, color: Colors.black),
          top: BorderSide(width: h / 2000, color: Colors.black),
          bottom: BorderSide.none, // No top border
          horizontalInside: BorderSide(width: h / 2000, color: Colors.black), // No horizontal inside borders
          verticalInside: BorderSide(width: h / 2000, color: Colors.black), // No vertical inside borders

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
             text_custum('Item',h,header: true),
             text_custum('Quantity',h),

             text_custum('Total',h),

      ]:[
           text_custum('Item',h,header: true),
          text_custum('Quantity',h),
          text_custum('Price',h),
          text_custum('Total',h),

        ]
       ),
          TableRow(

              children:
          preview?[
            Table(




                border: TableBorder(
                  left: BorderSide(width: h / 2000, color: Colors.black),
                  right: BorderSide(width: h / 2000, color: Colors.black),
                  top: BorderSide(width: h / 2000, color: Colors.black),
                  bottom: BorderSide.none, // No top border
                  horizontalInside: BorderSide(width: h / 2000, color: Colors.black), // No horizontal inside borders
                  verticalInside: BorderSide(width: h / 2000, color: Colors.black), // No vertical inside borders

                ),
                children: List.generate(e.length, (index) => TableRow(


                    children:[ Center(child: Stack(
                      children: [
                        edit? TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (i){
                            e[index].item=items_ui[index].text;
                            update_total(controller);


                            setState(() {

                            });
                          },
                          controller: items_ui[index],):
                        Container(
                          key: table_space[index],
                            child: text_custum(items_ui[index].text,h)),
                        edit?   theme_pop_up(index):SizedBox(),

                      ],
                    ))]),)),
            Table(


              border: TableBorder(
                left: BorderSide(width: h / 2000, color: Colors.black),
                right: BorderSide(width: h / 2000, color: Colors.black),
                top: BorderSide(width: h / 2000, color: Colors.black),
                bottom: BorderSide.none, // No top border
                horizontalInside: BorderSide(width: h / 2000, color: Colors.black), // No horizontal inside borders
                verticalInside: BorderSide(width: h / 2000, color: Colors.black), // No vertical inside borders

              ),
                children:  List.generate(e.length, (index) =>TableRow(
children: [
  edit?  Container(

          alignment: Alignment.center,
          child: TextFormField(
            textAlign: TextAlign.center,
            onChanged: (i){
              e[index].quantity=double.parse(quantity_ui[index].text);
              update_total(controller);
              setState(() {

              });
            },
            controller: quantity_ui[index],),
        ):  Container(
           height: table_heigth[index],
      child: text_custum(quantity_ui[index].text,h))]

                )),),
            Center(child: text_custum(double.parse(sum_total0.toString())==0?"F.O.C":sum_total.toString()+" "+"EGP",h)),
          ]:[
            Table(

                children: List.generate(e.length, (index) => TableRow(

                    children:[ Center(child: Stack(
                      children: [
                        edit? TextFormField(

                          textAlign: TextAlign.center,
                          onChanged: (i){

                            e[index].item=i;
                            update_total(controller);


                            setState(() {

                            });
                          },
                          controller: items_ui[index],):
                        text_custum(items_ui[index].text,h),
                        edit?   theme_pop_up(index):SizedBox(),

                      ],
                    ))]),)),
            Table(


                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit?  TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    DecimalInputFormatter(), // Allow numbers with a decimal point
                  ],
                  textAlign: TextAlign.center,
                  onChanged: (i){


                    e[index].quantity=double.parse(i);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: quantity_ui[index],): text_custum(quantity_ui[index].text,h)
                )
                ]),) ,


            ),
            Table(

                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit? TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    DecimalInputFormatter(), // Allow numbers with a decimal point
                  ],
                  textAlign: TextAlign.center,
                  onChanged: (w){

                    e[index].price=double.parse(w);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: price_ui[index],): text_custum(price_ui[index].text,h),
                )]),)),
            Center(child: text_custum(double.parse(sum_total0.toString())==0?"F.O.C":sum_total.toString()+" "+"EGP",h)),
          ]

          ),
    ]);

  }
  Widget secound_table(List<Item_Model> e,int key,Data_controller controller,h,{bool preview=false}){

    double sum_total0=IterableZip([price_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(), quantity_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b);
    String sum_total = NumberFormat('#,###').format(sum_total0);
    return Table(
        border: TableBorder(
          left: BorderSide(width: h / 2000, color: Colors.black),
          right: BorderSide(width: h / 2000, color: Colors.black),
          bottom: BorderSide(width: h / 2000, color: Colors.black),
          top: BorderSide.none, // No top border
          horizontalInside: BorderSide(width: h / 2000, color: Colors.black), // No horizontal inside borders
          verticalInside: BorderSide(width: h / 2000, color: Colors.black), // No vertical inside borders

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

           children: preview? [

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
                border: TableBorder(
                  left: BorderSide(width: h / 2000, color: Colors.black),
                  right: BorderSide(width: h / 2000, color: Colors.black),
                  bottom: BorderSide(width: h / 2000, color: Colors.black),
                  top: BorderSide.none, // No top border
                  horizontalInside: BorderSide(width: h / 2000, color: Colors.black), // No horizontal inside borders
                  verticalInside: BorderSide(width: h / 2000, color: Colors.black), // No vertical inside borders

                ),

                children: List.generate(e.length, (index) => TableRow(

                    children:[
                      Center(child: Stack(
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
                        Container(
                          key: table_space[index+sum],
                            child: text_custum(items_ui[index+sum].text,h)),
                        edit?   theme_pop_up(index+sum):SizedBox(),

                      ],
                    ))]),)),
            Table(
                border: TableBorder(
                  left: BorderSide(width: h / 2000, color: Colors.black),
                  right: BorderSide(width: h / 2000, color: Colors.black),
                  bottom: BorderSide(width: h / 2000, color: Colors.black),
                  top: BorderSide.none, // No top border
                  horizontalInside: BorderSide(width: h / 2000, color: Colors.black), // No horizontal inside borders
                  verticalInside: BorderSide(width: h / 2000, color: Colors.black), // No vertical inside borders

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
                  controller: quantity_ui[index+sum],): Container(
                  height: table_heigth[index+sum],
                    child: text_custum(quantity_ui[index+sum].text,h))
                )
                ]),)),
            Center(child: text_custum(double.parse(sum_total0.toString())==0?"F.O.C":sum_total.toString()+" "+"EGP",h)),
          ]:[
            Table(

                children: List.generate(e.length, (index) => TableRow(

                    children:[ Center(child: Stack(
                      children: [
                        edit? TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (i){
                            print(index+sum);

                            e[index].item=i;
                            print(items_ui[index+sum].text);
                            update_total(controller);


                            setState(() {

                            });
                          },
                          controller: items_ui[index+sum],):
                        text_custum(items_ui[index+sum].text,h),
                        edit?   theme_pop_up(index+sum):SizedBox(),

                      ],
                    ))]),)),
            Table(

                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit?  TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    DecimalInputFormatter(), // Allow numbers with a decimal point
                  ],
                  textAlign: TextAlign.center,
                  onChanged: (i){

                    e[index].quantity=double.parse(i);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: quantity_ui[index+sum],): text_custum(quantity_ui[index+sum].text,h)
                )
                ]),)),
            Table(

                children: List.generate(e.length, (index) => TableRow(children:[ Center(child:
                edit? TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    DecimalInputFormatter(), // Allow numbers with a decimal point
                  ],
                  onChanged: (w){
                    print(index+sum);
                    e[index].price=double.parse(w);
                    update_total(controller);
                    setState(() {

                    });
                  },
                  controller: price_ui[index+sum],): text_custum(price_ui[index+sum].text,h),
                )]),)),
            Center(child: text_custum(double.parse(sum_total0.toString())==0?"F.O.C":sum_total.toString()+" "+"EGP",h)),
          ]

          ),
    ]);
  }
  Widget therd_table(h){
    String sum_total = NumberFormat('#,###').format(quotation.quotation.total);
    return Table(
        border: TableBorder.symmetric(
            inside: BorderSide(width: h/2000, color: Colors.black),
            outside: BorderSide(width: h/2000, color: Colors.black)
        ),
        columnWidths: {

          0:FlexColumnWidth(9),
          1:FlexColumnWidth(4),



        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
       TableRow(children: [


        SizedBox(),
        SizedBox(),
      ]
       ),
          TableRow(children: [
            Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(width: h/2000, color: Colors.black),
                    outside: BorderSide(width: h/2000, color: Colors.black)
                ),
                children: [ TableRow(

                    children:[
                      Center(child:

                        text_custum('Total',h),

                    )])]),
            // Center(child: text_custum(quotation.quotation.total.toString()+" "+"EGP")),
            Center(child: text_custum(double.parse(quotation.quotation.total.toString())==0?"F.O.C":sum_total.toString()+" "+"EGP",h)),
          ]

          ),
    ]);
  }
  Widget text_custum(String text,h,{bool header=false}){

    // print(h);
    return   Center(child: Padding(
      padding:  EdgeInsets.all(header? h/80:h/85),
      child: Text(text,style: TextStyle(fontSize:  h/60,fontWeight: FontWeight.bold),),
    ));
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

print(ui);
controller.update_table_ui(ui);
controller.update_table_items(items);
  }







}

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression to match valid decimal numbers
    final regex = RegExp(r'^\d*\.?\d*$');

    // Check if the new value matches the regex
    if (regex.hasMatch(newValue.text)) {
      return newValue; // Accept the new value
    }

    return oldValue; // Reject the new value
  }
}