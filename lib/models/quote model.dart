import 'package:banana/models/account%20manger%20model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cinet model.dart';
import 'item model.dart';

class Quotation_Model{
  String id;
  String dec;
  String status;
  Client_Model client_model;
  DateTime time;
  Account_manger_Model account_manger_model;
  double total;
  List <Item_Model> items=[];
  bool is_original;
  String original_id;


  Quotation_Model(
      {
        required this.id,
        required this.dec,
        required this.client_model,
        required this.time,
        required this.account_manger_model,
        required this.total,
        required this.items,
        this.status='Pending',
        required this.is_original,
        required this.original_id
      });

  Quotation_Model.fromjson(map):this(
      id: map['id'].toString(),
      dec: map['des'],
    status: map['status'].toString(),
      time: DateTime.parse(map['date']),
      total: double.parse(map['total'].toString()),
    client_model: Client_Model.fromJson(map['Client']),
    account_manger_model: Account_manger_Model.fromjson(map['account_manger']),
    items: List<Item_Model>.from(map['items'].map((item) => Item_Model.fromjson(item))),
    is_original: map['is_original'],
    original_id: map['original_id'].toString(),
  );
   tojson(){
     return {

       'des':dec,
       'status':status,
       'client_id':double.parse(client_model.id).toInt(),
       'date':DateTime(time.year,time.month,time.day).toString(),
       'account_manager_id':double.parse(account_manger_model.id).toInt(),
       'total':total,
       'is_original':is_original,

     };
  }

}
class New_Quotation_Model{
  Quotation_Model quotation;
  List<int> ui;


  New_Quotation_Model(
      {
        required this.quotation,
        required this.ui,

      });


}

