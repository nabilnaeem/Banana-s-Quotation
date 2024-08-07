import 'package:banana/Controllers/widgets.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

// void main() {
//
//   runApp(Home());
//
// }
// class Home extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: My_Table(),
//     );
//   }
// }

class My_Table extends StatefulWidget {
  New_Quotation_Model quotation;

  My_Table(this.quotation);

  @override
  State<My_Table> createState() => _My_TableState(quotation);
}

class _My_TableState extends State<My_Table> {
  New_Quotation_Model quotation;

  _My_TableState(this.quotation);

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
int sum=ui.fold(0, (sum, item) => sum + item);
items_ui=List.generate(sum, (index) => TextEditingController());
quantity_ui=List.generate(sum, (index) => TextEditingController());
price_ui=List.generate(sum, (index) => TextEditingController());
total_ui=List.generate(ui.length, (index) => TextEditingController());
ui=quotation.ui;
items=quotation.quotation.items.isEmpty?[Item_Model(item: '', quantity: 1, price: 0)]:quotation.quotation.items;
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: ui.asMap().map((key, value) {
                sum=key==0?0:sum+ui[key-1];
                return MapEntry(key, key==0?first_table(items.sublist(0, ui[key]),key):secound_table(items.sublist(sum, (sum)+ui[key]),key));
              }).values.toList(),
            ),
            Row(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget first_table(List<Item_Model> e,int key){
    double sum_total=IterableZip([price_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(), quantity_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b);
    return Table(
        border: TableBorder.all(),
      columnWidths: {

        0:FlexColumnWidth(5),
        1:FlexColumnWidth(4),
        2:FlexColumnWidth(4),
        3:FlexColumnWidth(4),

      },
      

      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
       
      const TableRow(

           children: [




        Center(child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 8),
          child: Text('Item',style: TextStyle(fontSize: 20),),
        )),
        Center(child: Text('Quantity',style: TextStyle(fontSize: 20),)),
        Center(child: Text('Price',style: TextStyle(fontSize: 20),)),
        Center(child: Text('Total',style: TextStyle(fontSize: 20),)),
      ]),
          TableRow(children: [
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: Stack(


              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (e){
                    setState(() {

                    });
                  },
                  controller: items_ui[index+sum],),
                theme_pop_up(index+sum),

              ],
            ))]),)),
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (e){
                setState(() {

                });
              },
              controller: quantity_ui[index+sum],))]),)),
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (e){
                setState(() {

                });
              },
              controller: price_ui[index+sum],))]),)),
            Center(child: Text(sum_total.toString())),
          ]),
    ]);
  }
  Widget secound_table(List<Item_Model> e,int key){
    double sum_total=IterableZip([price_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList(), quantity_ui.sublist(sum, (sum)+ui[key]).map((e) => e.text.isNotEmpty?double.parse(e.text):0.0).toList()]) .map((list) => list[0] * list[1]).reduce((a, b) => a + b);
    return Table(
        border: TableBorder.all(),
        columnWidths: {

          0:FlexColumnWidth(5),
          1:FlexColumnWidth(4),
          2:FlexColumnWidth(4),
          3:FlexColumnWidth(4),

        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
      const TableRow(children: [


        SizedBox(),
        SizedBox(),
        SizedBox(),
        SizedBox(),
      ]),
          TableRow(children: [
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: Stack(


              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (e){
                    setState(() {

                    });
                  },
                  controller: items_ui[index+sum],),
                theme_pop_up(index+sum),

              ],
            ))]),)),
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (e){
                setState(() {

                });
              },
              controller: quantity_ui[index+sum],))]),)),
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (e){
                setState(() {

                });
              },
              controller: price_ui[index+sum],))]),)),
            Center(child: Text(sum_total.toString())),
          ]),
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
print(index);
  for(int i =0;index>=sum2;i++){

    sum2=sum2+ui[i];
    ui_index=index<=sum2?i:0;
  }

  setState(() {
    items.insert(index, Item_Model(item: '', quantity: 0, price: 0));
    items_ui.insert(index, TextEditingController());
    quantity_ui.insert(index, TextEditingController());
    price_ui.insert(index, TextEditingController());
    ui[ui_index]++;

  });




}
on_below(int index){

  ui_index=0;
  sum2=0;

  for(int i =0;index>=sum2;i++){
    sum2=sum2+ui[i];
    ui_index=index<=sum2?i:0;
  }

  setState(() {
    items.insert(index+1, Item_Model(item: '', quantity: 0, price: 0));
    items_ui.insert(index+1, TextEditingController());
    quantity_ui.insert(index+1, TextEditingController());
    price_ui.insert(index+1, TextEditingController());
    ui[ui_index]++;
  });




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
}
add_new_row(){
    setState(() {
      ui.add(1);
      items.add(Item_Model(item: 'item', quantity: 0, price: 0));
      items_ui.add(TextEditingController());
      quantity_ui.add(TextEditingController());
      price_ui.add(TextEditingController());
      items_ui.add(TextEditingController());

    });
}
}