import 'package:banana/models/quote%20model.dart';
import 'package:banana/models/user_model.dart';

import 'cinet model.dart';

class Request_model{

  String id;
  String comment;
  bool approval;
  Client_Model? client;
   User_model? user;
  Quotation_Model? quotation;



  Request_model(
      {
        required this.id,
        required this.comment,
        required this.approval,
        required this.client,
        required this.user,
        required this.quotation,


      });

  Request_model.fromjson(map):this(
    id: map['id'].toString(),
    comment: map['comment'],
    approval: map['Approval'],
    client:Client_Model.fromJson(map['Client']),
    user: User_model.fromjson(map['users']),
    quotation: Quotation_Model.fromjson(map['quote']),

  );


  tojson_quote(){
    return {

      'comment':comment,
      'Approval':approval,

      'quote':quotation!.id,



    };
  }
  tojson_client(){
    return {

      'comment':comment,
      'Approval':approval,

      'client':client!.id,



    };
  }


}