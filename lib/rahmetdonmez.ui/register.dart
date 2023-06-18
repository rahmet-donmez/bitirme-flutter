import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.service/api_service.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/home.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/login.dart';

class RegisterViewPage extends StatefulWidget {
  @override
  State<RegisterViewPage> createState() => RegisterPage();
}

class RegisterPage extends State<RegisterViewPage> {
   ApiService api=ApiService();
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
            child: Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.width * 0.1,
                        ),
                        Stack(
                          children: [
                            Center(
                              child: ClipOval(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: CircleAvatar(
                                    radius: size.width * 0.14,
                                    backgroundColor:
                                        Colors.grey[400]!.withOpacity(
                                      0.4,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.white,
                                      size: size.width * 0.1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text("Kullanıcı Kaydı",style: TextStyle(fontSize: 42,color:Colors.white),),
                       SizedBox(
                          height: size.width * 0.1,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                width: 400,
                                child: TextField(
                                    controller: first_name_controller,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      icon: Icon(FontAwesomeIcons.user),
                                      iconColor: Colors.deepPurple,
                                      hintText: 'Ad',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 400,
                                child: TextField(
                                    controller: last_name_controller,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      icon: Icon(FontAwesomeIcons.user),
                                      iconColor: Colors.deepPurple,
                                      hintText: 'Soyad',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 400,
                                child: TextField(
                                    controller: phone_controller,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      icon: Icon(FontAwesomeIcons.phone),
                                      iconColor: Colors.deepPurple,
                                      hintText: 'Telefon',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 400,
                                child: TextField(
                                    controller: email_controller,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      icon: Icon(FontAwesomeIcons.envelope),
                                      iconColor: Colors.deepPurple,
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 400,
                                child: TextField(
                                  obscureText: sifreGorunurluk,
                                    controller: password_controller,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      icon: const Icon(FontAwesomeIcons.lock),
                                      iconColor: Colors.deepPurple,
                                      hintText: 'Şifre',
                                      hintStyle: const TextStyle(
                                          color:
                                              Colors.white), //placeholder style
                                      // fillColor: Colors.grey,//textfieldın arka paln rengini ayarlar
                                      suffixIcon: GestureDetector(
                                        onTap: ()=> sifreGoster(),
                                        child: const Icon(
                                          FontAwesomeIcons.eye,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .white)), //kenar dekorasyonu
                                      //filled:true//fillcolor niteliğinin geçerli olmasını belirtir. yazılmaz ise fillcolor uygulanmaz
                                    ))),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              child: const Text('Kayıt Ol'),
                              onPressed: () {
                               api.register(first_name_controller.text, last_name_controller.text, phone_controller.text, email_controller.text, password_controller.text, context);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  style: TextStyle(color: Colors.white),
                                  'Zaten üye misin? ',
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginViewPage()));
                                  },
                                  child: const Text(
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 121, 103, 103)),
                                    'Giriş Yap',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
