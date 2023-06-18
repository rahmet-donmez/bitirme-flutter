import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/home.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/login.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

//flutter run -v --no-sound-null-safety
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '2. El Araç Al',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home:( MyHomePage()));
  }
}

class MyHomePage extends StatefulWidget {
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  session_mng() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("isLogin")==true){
Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));    }
    
  }

@override
  void initState(){
    session_mng();
    Future.delayed(Duration(seconds: 5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 575.0
                ? MediaQuery.of(context).size.height
                : 575.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover //TÜM GÖRÜNTÜNÜN EKRANA DOLMASINI SAĞLAR
                  ),
            ),
            child: Stack(children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      
                      child: Icon(FontAwesomeIcons.car, color: Colors.white,weight: 155,),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "HOŞGELDİNİZ",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    SizedBox(
                      height: size.width * 0.2,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 55,
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {
                                 
                                  Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>LoginViewPage()));
                                },
                                child: Text("Giriş Yap",
                                    style: TextStyle(fontSize: 25))),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 55,
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterViewPage()));
                                },
                                child: Text("Kayıt Ol",
                                    style: TextStyle(fontSize: 25))),
                          )
                        ],
                      ),
                    )
                  ],
                )),
              )
            ])));
  }
}
