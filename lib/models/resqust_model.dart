import 'package:banana/models/quote%20model.dart';
import 'package:banana/models/user_model.dart';

import 'cinet model.dart';

class quotation_Request_Model{

  String id;
  String comment;
  bool approval;
   User_model user;
  Quotation_Model quotation;



  quotation_Request_Model(
      {
        required this.id,
        required this.comment,
        required this.approval,
        required this.user,
        required this.quotation,


      });

  quotation_Request_Model.fromjson(map):this(
    id: map['id'].toString(),
    comment: map['comment'],
    approval: map['approval'],
    user: User_model.fromjson(map['users']),
    quotation: Quotation_Model.fromjson(map['quote']),

  );


  tojson_quote(){
    return {

      'comment':comment,
      'approval':approval,
      'user':user.id,

      'quote':quotation.id,



    };
  }



}
class Clint_Request_Model{

  String id;
  String comment;
  bool approval;
  Client_Model client;
   User_model user;




  Clint_Request_Model(
      {
        required this.id,
        required this.comment,
        required this.approval,
        required this.client,
        required this.user,



      });

  Clint_Request_Model.fromjson(map):this(
    id: map['id'].toString(),
    comment: map['comment'],
    approval: map['approval'],
    client:Client_Model.fromJson(map['Client']),
    user: User_model.fromjson(map['users']),


  );


  tojson_quote(){
    return {

      'comment':comment,
      'approval':approval,
      'user':user.id,

      'client':client.id,



    };
  }


}
class Status_Request_model{

  String id;
  String comment;
  String status;
  bool approval;
  User_model user;
  Quotation_Model quotation;



  Status_Request_model(
      {
        required this.id,
        required this.comment,
        required this.status,
        required this.approval,
        required this.user,
        required this.quotation,


      });

  Status_Request_model.fromjson(map):this(
    id: map['id'].toString(),
    comment: map['comment'],
    status: map['status'],
    approval: map['approval'],
    user: User_model.fromjson(map['users']),
    quotation: Quotation_Model.fromjson(map['quote']),

  );


  tojson_quote(){
    return {

      'comment':comment,
      'status':status,
      'approval':approval,
      'user':user.id,
      'quote':quotation.id,



    };
  }



}