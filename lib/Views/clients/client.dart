import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Controllers/widgets.dart';
import 'package:banana/Views/Home.dart';
import 'package:banana/Views/View%20quots.dart';
import 'package:banana/Views/history.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Client extends StatefulWidget {
Client_Model2 client;


Client(this.client);

@override
  State<Client> createState() => _ClientState(client);
}

class _ClientState extends State<Client> {

  Client_Model2 client;

  _ClientState(this.client);
  final supabase=Supabase.instance.client;
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController contact=TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text=client.name;
    phone.text=client.phone;
    email.text=client.e_mail;
    contact.text=client.contact;


  }
//FloatingActionButton(
//           backgroundColor: Colors.black87,
//           child: Text('Update',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//           onPressed: ()async{
//             if(controller.current_user.admin){
//               try{
//                 await supabase.from('Client').update(Client_Model(id: client.id, name: name.text, phone: phone.text, e_mail: email.text).tojson()).eq('id', client.id).select();
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
//                 pop_up_dialog("Client updated", 'Done', context, false);
//
//               }catch(e){
//                 print(e);
//               }
//             }else{
//               pop_up_dialog("You don't have permission", 'Field', context, false);
//             }
//           },
//         )
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Data_controller>(
      builder:(controller)=> Scaffold(
        floatingActionButton: InkWell(
          onTap: ()async{
            if(true){
              try{

                await supabase.from('Client').update(Client_Model(id: client.id, name: name.text, phone: phone.text, e_mail: email.text,contact: contact.text).tojson()).eq('client_id', client.id).select();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
                pop_up_dialog("Client updated", 'Done', context, false);

              }catch(e){
                print(e);
              }
            }else{
              pop_up_dialog("You don't have permission", 'Field', context, false);
            }
          },
          child: SizedBox(
            height: 70,
            width: 100,
            child: Container(
              alignment: Alignment.center,
             decoration: BoxDecoration(
               color: Colors.black87,
               borderRadius: BorderRadius.circular(100)
             ),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),



              child: Text('Update',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            ),
          ),
        ),
        appBar: AppBar(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Client data'),
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
              IntrinsicHeight(
                child: Column(children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Name',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),

                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(controller: name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Contact',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),

                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(controller: contact,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('E_mail',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),

                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(controller: email,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Phone',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),

                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(controller: phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            )
                          ),
                        ))
                      ],
                    ),
                  ),

                ] ,),
              ),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 5,),
            controller.current_user.admin?  Card(

                child: ListTile(

                  title: Text("${client.name}'s Quotations"),trailing: CircleAvatar(child: Text(client.quotation.length.toString()),),onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (c)=>History(client.quotation)));
                },),
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
