import 'package:banana/models/account%20manger%20model.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:banana/models/item%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:banana/models/resqust_model.dart';
import 'package:banana/models/user_model.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Data_controller extends GetxController{
  List <Quotation_Model> get quotations_main=> Quotations_main;
  List height=[];
  double total_quote_in_reivew=0.0;
  double subtotal_quote_in_reivew=0.0;
  double discount=0.0;
  List <int> UI=[];
  List <Item_Model> Table_Items=[];
  final supabase=Supabase.instance.client;
  List <Client_Model> Clints=[];
  List <Client_Model2> Clints2=[];
  List <Account_manger_Model> Account_manger=[];
  List <Quotation_Model> Quotations_main=[];
  List <User_model> Users=[];
  List <quotation_Request_Model> quote_Request=[];
  User_model current_user=User_model(id: 'id', name: 'name', admin: false, email: 'e_mail',Department: 'd',pass: 'pass');

  Data_controller(){
get_clints();
get_clints_related();
get_account_mangers();
get_quotes();
get_users();
update();
  }
  get_clints()async{
    Clints=[];
   try {
      final response = await supabase.from('Client').select(
          'client_id,name,email,phone,Contact');
      final List<dynamic> data = response as List<dynamic>;

      for (int i = 0; i < data.length; i++) {
        Clints.add(Client_Model.fromJson(data[i]));
        update();
      }

      print("Clients => " + Clints.length.toString());
    }catch(e){
     print(e);
   }
  }
  get_clints_related()async{
    print('pass1');
    Clints2=[];
    print('pass2');
   try {
      final response = await supabase.from('Client').select(
          'client_id,name,email,phone,Contact,quote(id,ui,des,date,total,status,is_original,original_id,discount,Client(client_id,name,email,phone,Contact),account_manger(manger_id,name,email,phone),items(id,item,price,quantity),quote_requ(approval))');
      final List<dynamic> data = response as List<dynamic>;
      print('pass3');
      for (int i = 0; i < data.length; i++) {
        Clints2.add(Client_Model2.fromJson(data[i]));
        update();
      }

      print("Clients2 => " + Clints2.length.toString());
    }catch(e){
     print("error====> ${e}");
   }
  }
  get_account_mangers()async{
    Account_manger=[];
    final response=await supabase.from('account_manger').select('manger_id,name,email,phone');
    final List<dynamic> data = response as List<dynamic>;
   for(int i =0;i<data.length;i++){
     Account_manger.add(Account_manger_Model.fromjson(data[i]));
     update();
   }
    update();
   print("Account_manger => "+Account_manger.length.toString());

  }

  get_quotes()async{
    Quotations_main=[];
  try  {
      final response =
      await supabase.from('quote').select('id,ui,des,date,total,status,is_original,original_id,discount,Client(client_id,name,email,phone,Contact),account_manger(manger_id,name,email,phone),items(id,item,price,quantity),quote_requ(approval)');

      final List<dynamic> data = response as List<dynamic>;

      for (int i = 0; i < data.length; i++) {
        Quotations_main.add(Quotation_Model.fromjson(data[i]));

        update();
      }
      update();
      print("Quotations => " + Quotations_main.length.toString());
    }catch(e){
    print(e);
  }
  }
  get_users()async{

    Users=[];
    final response=await supabase.from('users').select('email,name,admin,id,Department,pass');
    final List<dynamic> data = response as List<dynamic>;
    for(int i =0;i<data.length;i++){
      Users.add(User_model.fromjson(data[i]));

      update();
    }
    update();
    print("Users => "+Users.length.toString());
    await get_current();

  }
  get_current()async{
    try{
      var supa = await supabase.auth.currentSession;
      print('pass 1');
      print(supa!.user.email);
      print('pass 1');
      if (supa.user.email!.isNotEmpty) {
        current_user = Users[
            Users.indexWhere((element) => element.email == supa.user.email)];
        print('pass 1');
        print(current_user.tojson());
      } else {
        print('object');
      }
    }catch(e){
      print(e);
    }
    quote_requ();
  }
  quote_requ()async{
    quote_Request=[];
    try{
      final response = await supabase.from('quote_requ').select('id,comment,approval,users(id,name,email,admin,Department,pass),quote(id,ui,des,date,total,discount,status,is_original,original_id,Client(client_id,name,email,phone,Contact),account_manger(manger_id,name,email,phone),items(id,item,price,quantity),quote_requ(approval))').eq('approval', false);
      final List<dynamic> data = response as List<dynamic>;
      for(int i =0;i<data.length;i++){
        quote_Request.add(quotation_Request_Model.fromjson(data[i]));
        update();
      }

    }catch(e){
      print(e);
    }




    update();
    print("quote Requests => "+quote_Request.length.toString());

  }
  get_total_quote(List price,List quantity,bool Update){

    total_quote_in_reivew=0.0;
    subtotal_quote_in_reivew=0.0;
    subtotal_quote_in_reivew=IterableZip([price, quantity])
        .map((list) => list[0] * list[1])
        .reduce((a, b) => a + b);
    total_quote_in_reivew=IterableZip([price, quantity])
        .map((list) => list[0] * list[1])
        .reduce((a, b) => a + b)-((IterableZip([price, quantity])
        .map((list) => list[0] * list[1])
        .reduce((a, b) => a + b))*(discount/100));
   Update? update():(){};
  }
  update_table_ui(List <int> ui,{bool Update=false}){
    UI=ui;
   Update? update():(){};
    print(UI);
  }
  update_table_items(List <Item_Model> items){
    Table_Items=items;
    update();
    print(Table_Items.map((e) => Item_Model(item: e.item, quantity: e.quantity, price: e.price, id: e.id).tojson('id')));
  }
}
