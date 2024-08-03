import 'package:banana/Controllers/Data%20controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Home.dart';
import 'package:banana/main.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final supabase=Supabase.instance.client;
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  bool see_pass=true;
  String error='';
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width:w<700? w/6:w/7,
                    child: Hero(
                        tag: 'logo',
                        child: Image.asset('images/logo.png')),
                  ),
                ),
                Container(
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,


                    children: [

                     Text(' Top Management Access Only ',style: TextStyle(
                       fontSize: w/35,
                       fontWeight: FontWeight.bold
                     ),),
                      SizedBox(height: h/20,),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 0.1,
                            blurRadius: 20
                          )]
                        ),
                        width:w<700? w/1.2:w/1.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15
                                ),
                                hintText: 'Enter Your Official E_mail',
                                label: Text("User"),
                                labelStyle: TextStyle(color: Colors.grey.shade700),

                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(10))
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: pass,
                              obscureText: see_pass,
                              style: TextStyle(),
                              decoration: InputDecoration(

                                suffixIcon: IconButton(

                                  onPressed: (){
                                    setState(() {
                                      see_pass=!see_pass;
                                    });
                                  },icon: Icon(Icons.remove_red_eye),
                                  splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  color: see_pass?Colors.grey:Colors.black87,
                                ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15
                                  ),
                                hintText: 'Enter Your Password',
                                label: Text("Password"),
                                  labelStyle: TextStyle(color: Colors.grey.shade700),

                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black87),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                              ),
                            ),
                            SizedBox(height: 15,),
                            GetBuilder<Data_controller>(
                              builder:(controller)=> InkWell(
                                onTap: ()async{
                                 try{
                                   await supabase.auth.signInWithPassword(
                                       email: email.text,
                                       password: pass.text);
                                    controller.get_users();
                                   Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Home()));

                                 }catch(e){
                                   setState(() {
                                     error=e.toString();
                                   });
                                 }

                                },
                                child: Container(
                                  child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),

                          ],
                        ),
                      ),

                      SizedBox(height: 20,),
                     error==''?SizedBox(): Text('Access denied',style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
