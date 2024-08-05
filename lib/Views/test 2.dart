import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
List <Item_Model> items=[
  Item_Model(item: 'item 1', quantity: 1, price: 200),
  Item_Model(item: 'item 2', quantity: 2, price: 200),
  Item_Model(item: 'item 3', quantity: 3, price: 200),
  Item_Model(item: 'item 4', quantity: 4, price: 200),
  Item_Model(item: 'item 5', quantity: 5, price: 200),
  Item_Model(item: 'item 6', quantity: 6, price: 200),
  Item_Model(item: 'item 7', quantity: 7, price: 200),

];

  List <int>ui=[2,5];

  TextEditingController item=TextEditingController();
  TextEditingController quantity=TextEditingController();
  TextEditingController total=TextEditingController();
  TextEditingController add_index=TextEditingController();


  List<TextEditingController> items_ui=[];
  List <TextEditingController>quantity_ui=[];
  List<TextEditingController> total_ui=[];

@override
void initState() {
int sum=ui.fold(0, (sum, item) => sum + item);
items_ui=List.generate(sum, (index) => TextEditingController());
quantity_ui=List.generate(sum, (index) => TextEditingController());
total_ui=List.generate(ui.length, (index) => TextEditingController());
for (int i=0; i< items.length;i++){
  setState(() {
    items_ui[i].text=items[i].item;
    quantity_ui[i].text=items[i].quantity.toString();
  });

}
}
int sum=0;
int sum2=0;
int ui_index=0;
bool stop=false;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Column(
                children: ui.asMap().map((key, value) {
                  sum=key==0?0:sum+ui[key-1];
                  return MapEntry(key, key==0?first_table(items.sublist(0, ui[key])):secound_table(items.sublist(sum, (sum)+ui[key])));
                }).values.toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        ui_index=0;
                        sum2=0;
                        for(int i =0;double.parse(add_index.text).toInt()>=sum2;i++){
                          sum2=sum2+ui[i];
                          ui_index=double.parse(add_index.text).toInt()<=sum2?i:0;
                        }
                        setState(() {
                          ui[ui_index]++;
                          items.insert(double.parse(add_index.text).toInt(), Item_Model(item: '', quantity: 0, price: 0));
                          items_ui.insert(double.parse(add_index.text).toInt(), TextEditingController());
                          quantity_ui.insert(double.parse(add_index.text).toInt(), TextEditingController());

                        });

                      }, child: Row(
                        children: [
                          Text('Add index'),
                          SizedBox(width: 20,),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              controller: add_index,
                            ),
                          )

                        ],
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){

                        setState(() {
                          items.add( Item_Model(item: '', quantity: 0, price: 0));
                          items_ui.add( TextEditingController());
                          quantity_ui.add( TextEditingController());
                          ui.add(1);
                        });

                      }, child: Text('Add new row'))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget first_table(List<Item_Model> e){
    return Table(
      

      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(), children: [
      const TableRow(children: [
        Center(child: Text('id')),
        Center(child: Text('item')),
        Center(child: Text('quantity')),
        Center(child: Text('total')),
      ]),
      TableRow(children: [
        Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
          decoration: InputDecoration(
              hintText: (index+sum).toString()
          ),
          textAlign: TextAlign.center,
        ))]),)),
        Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(textAlign: TextAlign.center,controller: items_ui[index],))]),)),
        Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(textAlign: TextAlign.center,controller: quantity_ui[index],))]),)),
        Center(child: Text(e.map((item) => item.price).reduce((a, b) => a + b).toString())),
      ]),
    ]);
  }
  Widget secound_table(List<Item_Model> e){
    return Table(border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
      const TableRow(children: [
        SizedBox(),
        SizedBox(),
        SizedBox(),
        SizedBox(),
      ]),
          TableRow(children: [
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
              decoration: InputDecoration(
                hintText: (index+sum).toString()
              ),
              textAlign: TextAlign.center,
             ))]),)),
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
              textAlign: TextAlign.center,
              controller: items_ui[index+sum],))]),)),
            Table(border: TableBorder.all(), children: List.generate(e.length, (index) => TableRow(children:[ Center(child: TextFormField(
              textAlign: TextAlign.center,
              controller: quantity_ui[index+sum],))]),)),
            Center(child: Text(e.map((item) => item.price).reduce((a, b) => a + b).toString())),
          ]),
    ]);
  }
}