import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.partial/drawer.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.service/api_service.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/product_update.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ethernet_check.dart';

class ProductDetailsViewPage extends StatefulWidget {
  int id;
  bool yetki;
  ProductDetailsViewPage({required this.id,required this.yetki});

  @override
  State<ProductDetailsViewPage> createState() => ProductDetailsPage();
}

class ProductDetailsPage extends State<ProductDetailsViewPage> {
  ApiService api = ApiService();
  Internet internet=Internet();
  Uri launchUri = Uri();
  String phone = "";
  String id = "";
  user_id() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.get("userId").toString();
    });
  }

  @override
  void initState() {
    user_id();
    internet.internet_kontrol(context);
    //  get_image();
    super.initState();
  }

  Widget ara_mesaj() {
    return Row(
      children: [
        SizedBox(
           width:MediaQuery.of(context).size.width*0.48,
            child: ElevatedButton.icon(
                onPressed: () async {
                  launchUri = Uri(scheme: 'tel', path: phone);
                  await launchUrl(launchUri);
                },
                icon: Icon(Icons.call),
                label: Text("Ara"))),
        SizedBox(
         width:MediaQuery.of(context).size.width*0.04
        ),
        SizedBox(
           width:MediaQuery.of(context).size.width*0.48,
            child: ElevatedButton.icon(
                onPressed: () async {
                  launchUri = Uri(scheme: 'sms', path: phone);
                  await launchUrl(launchUri);
                },
                icon: Icon(Icons.message),
                label: Text("Mesaj Gönder")))
      ],
    );
  }

  Widget images_list() {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Text("fotoğreflar yükleniyor");
          } else {
            if (snapshot.data!['status'] == false) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                    )),
                //ClipRRect for image border radius
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/products/defaultProduct.png',
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              return Container(
                  margin: EdgeInsets.all(15),
                  child: CarouselSlider.builder(
                      itemCount: snapshot.data!['images'].length,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 300,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        reverse: false,
                        aspectRatio: 5.0,
                      ),
                      itemBuilder: (context, i, id) {
                        //for onTap to redirect to another screen
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                              )),
                          //ClipRRect for image border radius
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/products/' +
                                  snapshot.data!['images'][i]['imagePath'],
                              width: 500,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }));
            }
          }
        },
        future: api.images(widget.id));
  }




  Widget ilan_sahibi() {
    
    
    return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.data == null) {
            return Column(children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CircularProgressIndicator(),
              )
            ]);
          }
          else{
            return Column(
      children: [
        
        SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  10), //kenarların şeklini belirler. burada oval yapıldı
              boxShadow: [
                BoxShadow(
                    color: Colors.deepPurple,
                    blurRadius: 5,
                    spreadRadius: 0.5,
                    offset: Offset(5, 5))
              ], //gölgelendirme yapar

              border: Border.all(
                  color: Colors.deepPurple,
                  style: BorderStyle.solid,
                  width: 3), //kenar kalınlığı ve çizgi rengini belirler
              color: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),Text("İlan Sahibi",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Text(snapshot.data!['user']['userFirstName'].toString() +
                  " " +
                 snapshot.data!['user']['userLastName'].toString()),
              SizedBox(
                height: 12,
              ),
              Text(snapshot.data!['user']['userEmail'].toString()),
              SizedBox(
                height: 12,
              ),
              Text(snapshot.data!['user']['userPhone'].toString()),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        )
      ],
    );
          }
    },
    future: api.product_details(widget.id.toString()),);
  
  }

  Widget ilan_islemleri() {

return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.data == null) {
            return Column(children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CircularProgressIndicator(),
              )
            ]);
          }
          else{
    return Row(
      children: [
        SizedBox(
          width:MediaQuery.of(context).size.width*0.48,
            child: ElevatedButton.icon(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      icon: Icon(FontAwesomeIcons.exclamationCircle),
                      title: Text('Uyarı'),
                      content: Text('İlanı silmek istediğinize emin misiniz?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            //Navigator.pop(context);
                            api.product_delete(
                                snapshot.data!['product']['productId'].toString(),
                                context);
                          },
                          child: Text('Evet'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Hayır'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete),
                label: Text("Sil"))),
                SizedBox(
         width:MediaQuery.of(context).size.width*0.04
        ),
      
        SizedBox(
                    width:MediaQuery.of(context).size.width*0.48,

            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductUpdateViewPage(
id: snapshot.data!['product']['categoryId'],
                          aciklama_controller:
                              snapshot.data!['product']['productExplanation'].toString(),
                          semt_controller:
                              snapshot.data!['product']['productDistrict'].toString(),
                          yil_controller:
                              snapshot.data!['product']['productYear'].toString(),
                          renk_controller:
                              snapshot.data!['product']['productColor'].toString(),
                          ad_controller:
                              snapshot.data!['product']['productName'].toString(),
                          durum_controller:
                              snapshot.data!['product']['productStatus'].toString(),
                          fiyat_controller:
                              snapshot.data!['product']['productPrice'].toString(),
                          km_controller:
                              snapshot.data!['product']['productKm'].toString(),
                          marka_controller:
                              snapshot.data!['product']['productBrand'].toString(),
                          model_controller:
                              snapshot.data!['product']['productModel'].toString(),
                          motor_gucu_controller:
                              snapshot.data!['product']['productMotorPower'].toString(),
                          sehir_controller:
                              snapshot.data!['product']['productCity'].toString(),
                          product_id: snapshot.data!['product']['productId'].toString(),
                        ),
                      ));
                },
                icon: Icon(Icons.message),
                label: Text("Düzenle")))
      ],
    );
 
          }

},
future: api.product_details(widget.id.toString())
);
  }


  Widget battom_buttons() {
    if (widget.yetki==true) {
      return ilan_islemleri();
    } else {
      return ara_mesaj();
    }
  }








  Widget ilan_detay(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Column(children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: const CircularProgressIndicator(),
              )
            ]);
          } else {
            if (snapshot.data!['status'] == false) {
              return Column(children: <Widget>[
                const SizedBox(
                  height: 150,
                ),
                Container(
                    height: 40,
                    width: 200,
                    margin: const EdgeInsets.all(10), //elemanlar arası boşluk
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text("İlan bulunamadı.",
                            style: TextStyle(color: Colors.white))))
              ]);
            } else {
              phone = snapshot.data!['user']['userPhone'].toString();

              return Column(
                children: [
                  Text(
                    snapshot.data!['product']['productName'].toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  /* Center(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), //kenarların şeklini belirler. burada oval yapıldı
                        boxShadow: [
                          BoxShadow(
                              color: Colors.deepPurple,
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              offset: Offset(5, 5))
                        ], //gölgelendirme yapar

                        border: Border.all(
                            color: Colors.deepPurple,
                            style: BorderStyle.solid,
                            width:
                                3), //kenar kalınlığı ve çizgi rengini belirler
                        color: Colors.white),
                    child: Image.asset(
                      'assets/images/light-2.png',
                      height: 90,
                      width: 90,
                    ),
                  )),
                 
                 */
                  images_list(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      snapshot.data!['product']['productPrice'].toString() +
                          " TL",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.green)),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), //kenarların şeklini belirler. burada oval yapıldı
                        boxShadow: [
                          BoxShadow(
                              color: Colors.deepPurple,
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              offset: Offset(5, 5))
                        ], //gölgelendirme yapar

                        border: Border.all(
                            color: Colors.deepPurple,
                            style: BorderStyle.solid,
                            width:
                                3), //kenar kalınlığı ve çizgi rengini belirler
                        color: Colors.white),
                    child: Column(children: [
                      Text("İlan Bilgileri",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple,
                                        blurRadius: 5,
                                        spreadRadius: 0.5,
                                        offset: Offset(5, 5))
                                  ], //gölgelendirme yapar
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment
                                          .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                      colors: [
                                        Color.fromARGB(255, 209, 199, 226),
                                        Color.fromARGB(255, 148, 129, 180)
                                      ]),
                                  // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                  color: Colors.white),
                              child: Text("Tarih")),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['date'].toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.deepPurple,
                                      blurRadius: 5,
                                      spreadRadius: 0.5,
                                      offset: Offset(5, 5))
                                ], //gölgelendirme yapar
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment
                                        .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                    colors: [
                                      Color.fromARGB(255, 209, 199, 226),
                                      Color.fromARGB(255, 148, 129, 180)
                                    ]),
                                // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                color: Colors.white),
                            child: Text("Şehir"),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productCity']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.deepPurple,
                                      blurRadius: 5,
                                      spreadRadius: 0.5,
                                      offset: Offset(5, 5))
                                ], //gölgelendirme yapar
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment
                                        .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                    colors: [
                                      Color.fromARGB(255, 209, 199, 226),
                                      Color.fromARGB(255, 148, 129, 180)
                                    ]),
                                // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                color: Colors.white),
                            child: Text("Semt"),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productDistrict']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.deepPurple,
                                      blurRadius: 5,
                                      spreadRadius: 0.5,
                                      offset: Offset(5, 5))
                                ], //gölgelendirme yapar
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment
                                        .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                    colors: [
                                      Color.fromARGB(255, 209, 199, 226),
                                      Color.fromARGB(255, 148, 129, 180)
                                    ]),
                                // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                color: Colors.white),
                            child: Text("Marka"),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productBrand']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.deepPurple,
                                      blurRadius: 5,
                                      spreadRadius: 0.5,
                                      offset: Offset(5, 5))
                                ], //gölgelendirme yapar
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment
                                        .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                    colors: [
                                      Color.fromARGB(255, 209, 199, 226),
                                      Color.fromARGB(255, 148, 129, 180)
                                    ]),
                                // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                color: Colors.white),
                            child: Text("Model"),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productModel']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple,
                                        blurRadius: 5,
                                        spreadRadius: 0.5,
                                        offset: Offset(5, 5))
                                  ], //gölgelendirme yapar
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment
                                          .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                      colors: [
                                        Color.fromARGB(255, 209, 199, 226),
                                        Color.fromARGB(255, 148, 129, 180)
                                      ]),
                                  // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                  color: Colors.white),
                              child: Text("Yıl")),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productYear']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple,
                                        blurRadius: 5,
                                        spreadRadius: 0.5,
                                        offset: Offset(5, 5))
                                  ], //gölgelendirme yapar
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment
                                          .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                      colors: [
                                        Color.fromARGB(255, 209, 199, 226),
                                        Color.fromARGB(255, 148, 129, 180)
                                      ]),
                                  // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                  color: Colors.white),
                              child: Text("Motor Gücü")),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productMotorPower']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.deepPurple,
                                      blurRadius: 5,
                                      spreadRadius: 0.5,
                                      offset: Offset(5, 5))
                                ], //gölgelendirme yapar
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment
                                        .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                    colors: [
                                      Color.fromARGB(255, 209, 199, 226),
                                      Color.fromARGB(255, 148, 129, 180)
                                    ]),
                                // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                color: Colors.white),
                            child: Text("Km"),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productKm']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple,
                                        blurRadius: 5,
                                        spreadRadius: 0.5,
                                        offset: Offset(5, 5))
                                  ], //gölgelendirme yapar
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment
                                          .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                      colors: [
                                        Color.fromARGB(255, 209, 199, 226),
                                        Color.fromARGB(255, 148, 129, 180)
                                      ]),
                                  // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                  color: Colors.white),
                              child: Text("Durum")),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productStatus']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),//kenarların şeklini belirler. burada oval yapıldı
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple,
                                        blurRadius: 5,
                                        spreadRadius: 0.5,
                                        offset: Offset(5, 5))
                                  ], //gölgelendirme yapar
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment
                                          .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                      colors: [
                                        Color.fromARGB(255, 209, 199, 226),
                                        Color.fromARGB(255, 148, 129, 180)
                                      ]),
                                  // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                  color: Colors.white),
                              child: Text("Renk")),
                          SizedBox(
                            width: 12,
                          ),
                          Text(snapshot.data!['product']['productColor']
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), //kenarların şeklini belirler. burada oval yapıldı
                          boxShadow: [
                            BoxShadow(
                                color: Colors.deepPurple,
                                blurRadius: 5,
                                spreadRadius: 0.5,
                                offset: Offset(5, 5))
                          ], //gölgelendirme yapar

                          border: Border.all(
                              color: Colors.deepPurple,
                              style: BorderStyle.solid,
                              width:
                                  3), //kenar kalınlığı ve çizgi rengini belirler
                          color: Colors.white),
                      child: Column(
                        children: [
                          Text("Açıklama",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 12,
                          ),
                          Text(snapshot.data!['product']['productExplanation']
                              .toString()),
                        ],
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  ilan_sahibi()
                  
                ],
              );
            }
          }
        },
        future: api.product_details(widget.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
        },
        items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.red,
            icon: Icon(Icons.home), label: AutofillHints.birthday),
        const BottomNavigationBarItem(backgroundColor: Colors.red,
            icon: Icon(Icons.home), label: AutofillHints.birthday),
      ]),*/
      bottomNavigationBar: battom_buttons(),
      backgroundColor: Color.fromARGB(255, 219, 215, 215),
      drawer: DrawerViewPage(),
      appBar: AppBar(
        /*actions: [
IconButton(onPressed: (){
  Share.share("PAYLAŞILACAK METİN");
}, icon: Icon(Icons.share))        ],*/
        centerTitle: true,
        title: Text('İlan Detayı'),
      ),
      body: SingleChildScrollView(
          child: Center(child:
          Column(
        children: <Widget>[
          ilan_detay(context),
        ],
      ))),
    );
  }
}
