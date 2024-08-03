class Client_Model{
  String id;
  String name;
  String phone;
  String e_mail;



  Client_Model(
      {required this.id,required this.name,required this.phone,required this.e_mail});
  Client_Model.fromJson(Map<String, dynamic> map):this(
      id: map['client_id'] .toString() ,
      name: map['name'] .toString(),
      phone: map['phone'] .toString(),
      e_mail: map['email'] .toString(),
  );
  tojson() => {

    'name':name,
    'phone':phone,
    'email':e_mail,

  };

}
class User_Model{
  String id;
  String name;
  bool admin;
  String e_mail;



  User_Model(
      {required this.id,required this.name,required this.admin,required this.e_mail});
  User_Model.fromJson(Map<String, dynamic> map):this(
    id: map['id'] .toString() ,
    name: map['name'] .toString(),
    admin: map['admin'] ,
    e_mail: map['email'] .toString(),
  );
  tojson() => {


    'name':name,
    'email':e_mail,

  };

}