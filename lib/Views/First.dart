import 'package:banana/Controllers/Data%20controller.dart';
import 'package:banana/Views/Home.dart';
import 'package:banana/Views/Login.dart';
import 'package:banana/Views/preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Controllers/binding.dart';
import '../firebase_options.dart';
import '../main.dart';
import '../models/account manger model.dart';
import '../models/cinet model.dart';
import '../models/item model.dart';
import '../models/quote model.dart';

class First extends StatefulWidget {


  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {


  @override
  void initState() {
   futur();


  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: h/3,
                child: Hero(
                  tag: 'logo',
                    child: Image(image: AssetImage('images/logo.png')))),
            Text("Welcome",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            CircularProgressIndicator(color: Colors.black87,),
          ],
        ),
      ),
    );
  }
  futur()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(url: url, anonKey: anonKey);
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    Bindingg().dependencies();
    Navigat();
  }
  Navigat(){
    if(Supabase.instance.client.auth.currentSession==null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Login()));
    }else{

      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=> QuotePdf(false,[New_Quotation_Model(quotation: quotation_model, ui: [1])])));
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
    }
  }
}
