import 'package:banana/Controllers/Data%20controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Home.dart';
import 'package:banana/main.dart';
class Login extends StatefulWidget {


 @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  FocusNode _focusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // Request focus when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {

      _focusNode.requestFocus();
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {

      if (event.logicalKey == LogicalKeyboardKey.enter) {

      }
    }
  }



  void _runFunction(Data_controller controller) {
    // Your function logic here
    print("Enter key pressed!");
   login(controller);
  }

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
      body: GetBuilder<Data_controller>(
          builder:(controller)=> RawKeyboardListener(
          focusNode: _focusNode,
          onKey: _handleKeyPress,
          child: Row(
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

                         Text( "Banana's System" ,style: TextStyle(
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
                                 autofocus: true,
                                  focusNode: _emailFocusNode,


                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
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
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) => _runFunction(controller),
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
        ),
      ),
    );
  }
  login(Data_controller controller)async{


    try{
      print('pass1');
      await supabase.auth.signInWithPassword(
          email: email.text,
          password: pass.text);
      print('pass2');
      controller.get_users();

      Navigator.of(context).push(MaterialPageRoute(builder: (c)=>Home()));
      print('pass4');

    }catch(e){
      setState(() {
        error=e.toString();
      });
    }

  }


}
