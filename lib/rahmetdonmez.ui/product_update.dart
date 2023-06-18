import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.service/api_service.dart';

import '../rahmetdonmez.partial/drawer.dart';

class ProductUpdateViewPage extends StatefulWidget {
  final String product_id;
  final String ad_controller;
  final String aciklama_controller;
  final String renk_controller;
  final String marka_controller;
  final String model_controller;
  final String yil_controller;
  final String motor_gucu_controller;
  final String km_controller;
  final String sehir_controller;
  final String semt_controller;
  final String durum_controller;
  final String fiyat_controller;
  final int id;
  const ProductUpdateViewPage(
      {super.key,
required this.id,
      required this.ad_controller,
      required this.aciklama_controller,
      required this.renk_controller,
      required this.marka_controller,
      required this.model_controller,
      required this.yil_controller,
      required this.motor_gucu_controller,
      required this.km_controller,
      required this.sehir_controller,
      required this.semt_controller,
      required this.durum_controller,
      required this.fiyat_controller,
      required this.product_id});

  @override
  State<ProductUpdateViewPage> createState() => ProductUpdatePage();
}

class ProductUpdatePage extends State<ProductUpdateViewPage> {
  ApiService api = ApiService();
  TextEditingController ad_controller = TextEditingController();
  TextEditingController aciklama_controller = TextEditingController();
  TextEditingController renk_controller = TextEditingController();
  TextEditingController marka_controller = TextEditingController();
  TextEditingController model_controller = TextEditingController();
  TextEditingController yil_controller = TextEditingController();
  TextEditingController motor_gucu_controller = TextEditingController();
  TextEditingController km_controller = TextEditingController();
  TextEditingController sehir_controller = TextEditingController();
  TextEditingController semt_controller = TextEditingController();
  TextEditingController durum_controller = TextEditingController();
  TextEditingController fiyat_controller = TextEditingController();

  @override
  void initState() {
    ad_controller.text = widget.ad_controller;
    aciklama_controller.text = widget.aciklama_controller;
    renk_controller.text = widget.renk_controller;
    marka_controller.text = widget.marka_controller;
    model_controller.text = widget.model_controller;
    yil_controller.text = widget.yil_controller;
    motor_gucu_controller.text = widget.motor_gucu_controller;
    km_controller.text = widget.km_controller;
    sehir_controller.text = widget.sehir_controller;
    semt_controller.text = widget.semt_controller;
    durum_controller.text = widget.durum_controller;
    fiyat_controller.text = widget.fiyat_controller;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 215, 215),
        drawer: DrawerViewPage(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('İlan Ekle'),
        ),
        body: SingleChildScrollView(
            child: Center(

              child:Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
     Container( padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 500,
          decoration: BoxDecoration(
border: Border.all(color:Colors.deepPurple),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            
           //gölgelendirme yapar

          ),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: ad_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Ad",
                      hintText: 'Ad',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: aciklama_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Açıklama",
                      hintText: 'Açıklama',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: renk_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Renk",
                      hintText: 'Renk',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: marka_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Marka",
                      hintText: 'Marka',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: model_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Model",
                      hintText: 'Model',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: yil_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Yıl",
                      hintText: 'Yıl',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: motor_gucu_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Motor Gücü",
                      hintText: 'Motor Gücü',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: km_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Km",
                      hintText: 'Km',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: sehir_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Şehir",
                      hintText: 'Şehir',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: semt_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Semt",
                      hintText: 'Semt',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                    controller: durum_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Durum",
                      hintText: 'Durum',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                   keyboardType: TextInputType.number,
                    controller: fiyat_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Fiyat",
                      hintText: 'Fiyat',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
              FloatingActionButton(
                onPressed: () {
                  api.product_add(
                      ad_controller.text,
                      aciklama_controller.text,
                      renk_controller.text,
                      marka_controller.text,
                      model_controller.text,
                      yil_controller.text,
                      motor_gucu_controller.text,
                      km_controller.text,
                      sehir_controller.text,
                      semt_controller.text,
                      durum_controller.text,
                      fiyat_controller.text,1,
                      context);
                },
                child: Icon(
                  Icons.check,
                ),
              )
            ],
          ),
        ),
        
                  SizedBox(
                    height: 12,
                  ),

                ],
              )
          
        
        )));
  
  
  }
}
