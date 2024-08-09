class User_model{

  String id;
  String name;
  String email;
  bool admin;



  User_model(
      {
        required this.id,
        required this.name,
        required this.email,
        required this.admin,


      });

  User_model.fromjson(map):this(
    id: map['id'].toString(),
    name: map['name'],
    email: map['email'].toString(),
    admin: map['admin'],

  );
  tojson(){
    return {

      'name':name,
      'email':email,
      'admin':admin,



    };
  }

}
