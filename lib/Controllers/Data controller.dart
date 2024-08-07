import 'package:banana/models/account%20manger%20model.dart';
import 'package:banana/models/cinet%20model.dart';
import 'package:banana/models/quote%20model.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Data_controller extends GetxController{
  double total_quote_in_reivew=0.0;
  final supabase=Supabase.instance.client;
  List <Client_Model> Clints=[];
  List <Account_manger_Model> Account_manger=[];
  List <Quotation_Model> Quotations=[];
  List <User_Model> Users=[];
  User_Model current_user=User_Model(id: 'id', name: 'name', admin: false, e_mail: 'e_mail');

  Data_controller(){
get_clints();
get_account_mangers();
get_quotes();
get_users();
update();
  }
  get_clints()async{
    Clints=[];
    final response=await supabase.from('Client').select('client_id,name,email,phone');
    final List<dynamic> data = response as List<dynamic>;
   for(int i =0;i<data.length;i++){
     Clints.add(Client_Model.fromJson(data[i]));
     update();
   }

    print("Clients => "+Clints.length.toString());

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
    Quotations=[];
    final response=await supabase.from('quote').select('id,des,date,total,status,is_original,original_id,Client(client_id,name,email,phone),account_manger(manger_id,name,email,phone),items(item,price,quantity)');

    final List<dynamic> data = response as List<dynamic>;


    for(int i =0;i<data.length;i++){
      Quotations.add(Quotation_Model.fromjson(data[i]));
      update();
    }
    update();
    print("Quotations => "+Quotations.length.toString());

  }
  get_users()async{

    Users=[];
    final response=await supabase.from('users').select('email,name,admin,id');
    final List<dynamic> data = response as List<dynamic>;
    for(int i =0;i<data.length;i++){
      Users.add(User_Model.fromJson(data[i]));

      update();
    }
    update();
    print("admins => "+Users.length.toString());
    await get_current();

  }
  get_current()async{
    var supa= await supabase.auth.currentSession;
    print(supa!.user.email);
    if(supa.user.email!.isNotEmpty){
      current_user=Users[Users.indexWhere((element) => element.e_mail==supa.user.email)];
      print(current_user.tojson());
    }else{
      print('object');
    }
  }
  get_requ()async{
    var supa= await supabase.auth.currentSession;
    print(supa!.user.email);
    if(supa.user.email!.isNotEmpty){
      current_user=Users[Users.indexWhere((element) => element.e_mail==supa.user.email)];
      print(current_user.tojson());
    }else{
      print('object');
    }
  }
  get_total_quote(List price,List quantity,bool Update){
    total_quote_in_reivew=0.0;
    total_quote_in_reivew=IterableZip([price, quantity])
        .map((list) => list[0] * list[1])
        .reduce((a, b) => a + b);
   Update? update():(){};
  }
}
