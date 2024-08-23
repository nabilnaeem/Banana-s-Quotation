import 'package:banana/models/quote%20model.dart';

class Client_Model{
  String id;
  String name;
  String contact;
  String phone;
  String e_mail;




  Client_Model(
      {required this.id,
        required this.name,
        required this.contact,
        required this.phone,
        required this.e_mail});
  Client_Model.fromJson(Map<String, dynamic> map):this(
      id: map['client_id'] .toString() ,
      name: map['name'] .toString(),
      contact: map['Contact'] .toString(),
      phone: map['phone'] .toString(),
      e_mail: map['email'] .toString(),

  );
  tojson() => {

    'name':name,
    'Contact':contact,
    'phone':phone,
    'email':e_mail,

  };

}
class Client_Model2{
  String id;
  String name;
  String phone;
  String contact;
  String e_mail;
 List <Quotation_Model> quotation;




  Client_Model2(
      {required this.id,required this.name,required this.phone,required this.e_mail,required this.quotation,required this.contact});
  Client_Model2.fromJson(Map<String, dynamic> map):this(
      id: map['client_id'] .toString() ,
      name: map['name'] .toString(),
      contact: map['Contact'] .toString(),
      phone: map['phone'] .toString(),
      e_mail: map['email'] .toString(),
    quotation:List<Quotation_Model>.from(map['quote'].map((item) => Quotation_Model.fromjson(item))) ,

  );


}
