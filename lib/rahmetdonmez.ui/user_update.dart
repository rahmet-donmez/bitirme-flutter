import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.service/api_service.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/home.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rahmetdonmez.model/category.dart';
import '../rahmetdonmez.partial/drawer.dart';


class UserUpdateViewPage extends StatefulWidget {
  const UserUpdateViewPage({super.key});

  @override
  State<UserUpdateViewPage> createState() => UserUpdatePage();
}

class UserUpdatePage extends State<UserUpdateViewPage> {
  ApiService api = ApiService();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController first_name_controller = TextEditingController();
  TextEditingController last_name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
   bool sifreGorunurluk=true;

sifreGoster(){
  setState(() {
    sifreGorunurluk=!sifreGorunurluk;
  });
}

  @override
  void initState() {
    session_deger_atama();
    super.initState();
  }

  Future<void> session_deger_atama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      first_name_controller.text = prefs.get("isim").toString();
      last_name_controller.text = prefs.get("soyisim").toString();
      phone_controller.text = prefs.get("telefon").toString();
      password_controller.text = prefs.get("password").toString();
      email_controller.text = prefs.get("email").toString();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 215, 215),
      drawer: DrawerViewPage(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hesap Güncelle'),
      ),
      body:
      SingleChildScrollView(
        child:Center(
          child:  Column(children: <Widget>[
        SizedBox(
          height: 12,
        ),
        Container(
          padding: EdgeInsets.all(10),
          //height: MediaQuery.of(context).size.height*0.9,
           width: MediaQuery.of(context).size.width*0.9,
            alignment: Alignment.center,
           decoration: BoxDecoration(
border: Border.all(color:Colors.deepPurple),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            
           //gölgelendirme yapar

          ),
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                    width: 400,
                    child: TextField(
                        controller: first_name_controller,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.user),
                          iconColor: Colors.deepPurple,
                          labelText: "Ad",
                          hintText: 'Ad',
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 400,
                    child: TextField(
                        controller: last_name_controller,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.user),
                          iconColor: Colors.deepPurple,
                          labelText: "Soyad",
                          hintText: 'Soyad',
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 400,
                    child: TextField(
                        controller: phone_controller,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.phone),
                          iconColor: Colors.deepPurple,
                          labelText: "Telefon",
                          hintText: 'Telefon',
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 400,
                    child: TextField(
                        controller: email_controller,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.envelope),
                          iconColor: Colors.deepPurple,
                          labelText: "Email",
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.deepPurple),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 400,
                    child: TextField(
                       obscureText: sifreGorunurluk,
                        controller: password_controller,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: InputDecoration(
                          icon: const Icon(FontAwesomeIcons.lock),
                          iconColor: Colors.deepPurple,
                          labelText: "Şifre",

                          hintText: 'Şifre',
                          hintStyle: const TextStyle(
                              color: Colors.deepPurple), //placeholder style
                          // fillColor: Colors.grey,//textfieldın arka paln rengini ayarlar
                          suffixIcon: GestureDetector(
                             onTap: ()=> sifreGoster(),
                            child: const Icon(
                              FontAwesomeIcons.eye,
                              size: 15.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black)), //kenar dekorasyonu
                          //filled:true//fillcolor niteliğinin geçerli olmasını belirtir. yazılmaz ise fillcolor uygulanmaz
                        ))),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  child: const Text('Güncelle'),
                  onPressed: () {
                    api.user_update(
                        first_name_controller.text,
                        last_name_controller.text,
                        phone_controller.text,
                        email_controller.text,
                        password_controller.text,
                        context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
       SizedBox(
                  height: 12,
                ),
      
      ]),
    
        )
       
      )
      
    );
  }
}
