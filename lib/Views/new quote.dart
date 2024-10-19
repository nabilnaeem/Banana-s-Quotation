import 'dart:html';

import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/preview.dart';
import 'package:banana/Views/table.dart';
import 'package:banana/models/account%20manger%20model.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


class New_Quote extends StatefulWidget {
Quotation_Model quotation;
bool update;
bool edit;

Data_controller data;
List <int> ui;


New_Quote(this.quotation, this.update,this.data,this.ui,{this.edit=false});

  @override
  State<New_Quote> createState() => _New_QuoteState(quotation,update,data,ui,edit);
}

class _New_QuoteState extends State<New_Quote> {
  bool edit;
  List <int> ui;
  TextEditingController dec=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController e_mail=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController discount=TextEditingController();
  List <TextEditingController> item=[];
  List <TextEditingController> quantity=[];
  List <TextEditingController> price=[];
  var client ;
  var account_manger ;
  DateTime selectedDate=DateTime.now();
  final supabase=Supabase.instance.client;

  Quotation_Model quotation;
  Data_controller data;
  bool update;
  double total=0.0;
  _New_QuoteState(this.quotation, this.update,this.data,this.ui,this.edit);
bool have_account_manager=false;
  @override
  void initState() {
    // TODO: implement initState
    if(update || edit){
      edit_quote();
    }else{
      new_quote();
    }


  }
  new_quote(){
    item=List.generate(1, (index) => TextEditingController());
    quantity=List.generate(1, (index) => TextEditingController());
    price=List.generate(1, (index) => TextEditingController());
    if(data.current_user.Department=="account manger"){

account_manger=data.Account_manger[data.Account_manger.indexWhere((element) => element.e_mail==data.current_user.email)];
have_account_manager=true;
    }
  }
  edit_quote(){

discount.text=quotation.discount.toString();
    item=List.generate(quotation.items.length, (index) => TextEditingController());
    quantity=List.generate(item.length, (index) => TextEditingController());
    price=List.generate(item.length, (index) => TextEditingController());
    data.get_total_quote(quotation.items.map((e) => e.price).toList(), quotation.items.map((e) => e.quantity).toList(),false);
    for (int i=0; i< quotation.items.length;i++){
      setState(() {
        item[i].text=quotation.items[i].item;
        quantity[i].text=quotation.items[i].quantity.toString();
        price[i].text=quotation.items[i].price.toString();
        // total[i]=(quotation.items[i].quantity*quotation.items[i].price);

      });
    }
    setState(() {
       client=data.Clints[data.Clints.indexWhere((element) => element.name==quotation.client_model.name)];
       account_manger=data.Account_manger[data.Account_manger.indexWhere((element) => element.name==quotation.account_manger_model.name)];
       have_account_manager=true;
      selectedDate=quotation.time;
      dec.text=quotation.dec;

    });
  }

  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return GetBuilder<Data_controller>(

      builder:(controller)=> Scaffold(
        floatingActionButton:  controller.Table_Items.length==0?SizedBox(): InkWell(
          onTap: (){
                if(!dec.text.isEmpty||!client.isBlank||!account_manger.isBlank){
                    Quotation_Model quotaion_model = Quotation_Model(
                      discount: discount.text.isEmpty?0:double.parse(discount.text),
                        ui: ui,
                        is_original: update?false:edit?quotation.is_original:true,
                        original_id: update ? quotation.is_original ? quotation.id : quotation.original_id : '',
                        id: quotation.id,
                        dec: dec.text,
                        client_model: client,
                        time: selectedDate,
                        account_manger_model: account_manger,
                        total: controller.subtotal_quote_in_reivew,
                        items: controller.Table_Items);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => QuotePdf(
                              false,
                              [
                                New_Quotation_Model(
                                    quotation: quotaion_model,
                                    ui: controller.UI)
                              ],
                              edit: edit,
                            )));
                    print(edit);
                  }
                },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50)
            ),
            height: 50,
            width: 100,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Next',style: TextStyle(color: Colors.white),),
                Icon(Icons.arrow_forward,color: Colors.white,)

              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("New Quotation"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            Hero(
              tag: 'logo',
                child: Image(image: AssetImage('images/logo.png')))
          ],
        ),
        body: ListView(
          children: <Widget>[
            IntrinsicHeight(
              child: Container(
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.black87,
                              child: Text("Info" ,style: TextStyle(
                                color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                    IntrinsicHeight(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child:w>700? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Row(
                                        children: [
                                          Text('Client :',style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(width: 20,),
                                            DropdownButton<Client_Model>(

                                            focusColor: Colors.transparent,
                                              hint: Text('Choose'),
                                              underline: Divider(thickness: 0,),
                                              items:controller.Clints.map((Client_Model e) => DropdownMenuItem<Client_Model>(
                                                child: Text(e.name.toString(),style: TextStyle(color: Colors.black)),value: e,)).toList(),
                                              onChanged: ( val){
                                                setState(() {
                                                  client=val!;
                                               });
                                              },
                                              value:client ,),
                                        ],
                                      ),
                                        ElevatedButton(onPressed: (){
                                          pop_up_dialog_info(controller);
                                        }, child: Text("Add New Client"))



                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      children: [
                                      Text('Contact :',style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Text(client==null?'choose client':client.contact),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                      Text('E-mail :',style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Text(client==null?'choose client':client.e_mail),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                      Text('Phone :',style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Text(client==null?'choose client':client.phone),

                                      ],
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            VerticalDivider(color: Colors.grey.shade500,),
                            Expanded(
                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          selectedDate == null
                                              ? 'Select a date : '
                                              : 'Selected Date :  ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                          style: TextStyle(fontWeight: FontWeight.bold),

                                        ),
                                        SizedBox(height: 20.0),
                                        IconButton(onPressed: ()=>_selectDate(context), icon: Icon(Icons.date_range)),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(

                                      children: [
                                        Text('Account manger : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 10,),
                                       have_account_manager?Text(account_manger.name): DropdownButton<Account_manger_Model>(

                                          focusColor: Colors.transparent,
                                          hint: Text('Choose'),
                                          underline: Divider(thickness: 0,),

                                          items:controller.Account_manger.map((e) => DropdownMenuItem(child: Text(e.name.toString(),style: TextStyle(color: Colors.black)),value: e,)).toList(),
                                          onChanged: (val){
                                            setState(() {
                                              account_manger=val!;
                                            });
                                          },
                                          value:account_manger ,),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('Description : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: SizedBox(
                                            height: 45,

                                              child: TextFormField(
                                                onChanged: (i){
                                                  quotation.dec=dec.text;
                                                },
                                                textAlign: TextAlign.center,
                                                controller: dec,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5)
                                                  )
                                                ),
                                              )),
                                        ),

                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ):Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Client :',style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(width: 20,),
                                            DropdownButton<Client_Model>(

                                              focusColor: Colors.transparent,
                                              hint: Text('Choose'),
                                              underline: Divider(thickness: 0,),
                                              items:controller.Clints.map((Client_Model e) => DropdownMenuItem<Client_Model>(
                                                child: Text(e.name.toString(),style: TextStyle(color: Colors.black)),value: e,)).toList(),
                                              onChanged: ( val){
                                                setState(() {
                                                  client=val!;
                                                });
                                              },
                                              value:client ,),
                                          ],
                                        ),
                                        ElevatedButton(onPressed: (){
                                          pop_up_dialog_info(controller);
                                        }, child: Text("Add New Client"))



                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      children: [
                                        Text('Contact :',style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Text(client==null?'choose client':client.contact),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('E-mail :',style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Text(client==null?'choose client':client.e_mail),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('Phone :',style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Text(client==null?'choose client':client.phone),

                                      ],
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            Divider(color: Colors.grey.shade500,),
                            Expanded(
                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          selectedDate == null
                                              ? 'Select a date : '
                                              : 'Selected Date :  ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                          style: TextStyle(fontWeight: FontWeight.bold),

                                        ),
                                        SizedBox(height: 20.0),
                                        IconButton(onPressed: ()=>_selectDate(context), icon: Icon(Icons.date_range)),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(

                                      children: [
                                        Text('Account manager : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 10,),
                                       have_account_manager? Text(account_manger.name):DropdownButton<Account_manger_Model>(

                                          focusColor: Colors.transparent,
                                          hint: Text('Choose'),
                                          underline: Divider(thickness: 0,),

                                          items:controller.Account_manger.map((e) => DropdownMenuItem(child: Text(e.name.toString(),style: TextStyle(color: Colors.black)),value: e,)).toList(),
                                          onChanged: (val){
                                            setState(() {
                                              account_manger=val!;

                                            });
                                          },
                                          value:account_manger ,),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('Description : ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: SizedBox(
                                             height: 45,

                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: dec,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(5)
                                                    )
                                                ),
                                              )),
                                        ),

                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.black87,
                          child: Text("Items", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: w,
                        height: h/2,
                        child: My_Table(quotation,controller,h,quotation.items,edit: true,)),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: h/18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Discount :',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                            SizedBox(width: 20,),
                            SizedBox(width: w/3,child: TextFormField(
                              onChanged: (i){
                                controller.discount=discount.text.isEmpty?0:double.parse(i.toString());
                                controller.update_table_items(quotation.items);
                                controller.update_table_ui(quotation.ui);
                                controller.get_total_quote(controller.Table_Items.map((e) => e.price).toList(), controller.Table_Items.map((e) => e.quantity).toList(), true);


                              },

                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                DecimalInputFormatter(), // Allow numbers with a decimal point
                              ],


                              cursorColor: Colors.white,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.percent,color: Colors.white,),
                                hintText: 'Enter discount percentage',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  )

                              ),
                              controller: discount,
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(width: w/10,),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Total :',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                            SizedBox(width: 40,),
                            Text(((controller.total_quote_in_reivew)-(controller.total_quote_in_reivew*(quotation.discount/100))).toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: h/10,)
              ],
            ),




          ],
        ),
      ),
    );
  }

  pop_up_dialog_info(Data_controller controller){
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          elevation: 0,

          content: IntrinsicHeight(
                  child: Container(


                    width: w>h?h-50:w-100,

                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text('Name :'),

                              Expanded(child: TextFormField(
                                controller: name,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text('Contact :'),

                              Expanded(child: TextFormField(
                                controller: contact,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text('E_mail :'),

                              Expanded(child: TextFormField(
                                controller: e_mail,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text('Phone :'),

                              Expanded(child: TextFormField(
                                controller: phone,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(onPressed: ()async{
                        try{
                          await supabase.from('Client').insert(Client_Model(id: 'id', name: name.text, phone: phone.text, e_mail: e_mail.text,contact: contact.text).tojson()).select().then((value) async{
                            await controller.get_clints();
                            controller.update();

                          });

                          Navigator.pop(context);

                        }catch(e){
                          print(e);
                        }
                        }, child: Text('ADD'))


                      ],
                    ),
                  ),

               ),
        ));
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}



