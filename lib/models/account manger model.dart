class Account_manger_Model{
  String id;
  String name;
  String phone;
  String e_mail;



  Account_manger_Model(
      {required this.id,required this.name,required this.phone,required this.e_mail});
  Account_manger_Model.fromjson(map):this(
      id: map['manger_id'].toString(),
      name: map['name'].toString(),
      phone: map['phone'].toString(),
      e_mail: map['email'].toString(),
  );
  tojson() => {

    'manger_id':id,
    'name':name,
    'phone':phone,
    'e_mail':e_mail,

  };

}