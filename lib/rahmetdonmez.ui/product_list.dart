import 'package:flutter/material.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.partial/drawer.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.service/api_service.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/product_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ethernet_check.dart';

class ProductsViewPage extends StatefulWidget {
  final String type;
  final String title;
  final String price_min;
  final String price_max;
    final String search_key;
  final int category;
  final int siralama_turu;

  const ProductsViewPage(
      {super.key,
      required this.type,
      required this.title,
      required this.category, required this.siralama_turu, required this.search_key, required this.price_min, required this.price_max});

  @override
  State<ProductsViewPage> createState() => ProductsPage();
}

class ProductsPage extends State<ProductsViewPage> {
  ApiService api = new ApiService();
Internet internet=Internet();
  List ilan_liste = [];
  TextEditingController altFiyat=TextEditingController();
TextEditingController ustFiyat=TextEditingController();

@override
  void initState() {
    internet.main();
    //internet.deneme();
    //internet.internet_kontrol(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      ilan_listesi(context);
    });
  }

  Widget ilan_listesi(BuildContext context) {
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
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text("İlan bulunamadı.",
                            style: TextStyle(color: Colors.white))))
              ]);
            } else {
              
              
              ilan_liste = snapshot.data!['products'];
              return ilan_listele(context);
            }
          }
        },
        future: api.product(widget.type, widget.category,widget.siralama_turu,widget.search_key,widget.price_min,widget.price_max));
  }

  Widget ilan_listele(
    BuildContext context,
  ) {
    return Expanded(
      child: SizedBox(
          height: 200.0,
          child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                  itemCount: ilan_liste.length,
                  itemBuilder: (BuildContext context, int index) {
                 
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           GestureDetector(
                            //containerın tıklanabilir olmasını sağlar
                             onTap: () async {
                              bool yetki = false;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              String user_id = prefs.get("userId").toString();
                              String product_userid = await api.product_userid(
                                  ilan_liste[index][
                                              'productId'].toString());
                             
                              if (user_id == product_userid) {
                                
                                  yetki = true;
                               
                              }
                              

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsViewPage(
                                            id:ilan_liste[index][
                                              'productId'],
                                            yetki: yetki,
                                          ))); 
                                          
                                          
                                          
                                          //id:ilan_liste[index]['productId']
                            },
                            
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width*0.9,

                               // width: 300,
                                height: 150,
                                //alignment: Alignment.center,
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
                                    /* gradient: LinearGradient(begin:Alignment.centerLeft,end: Alignment.centerRight,//soldan sağa belirtilen rrenkler arası geçişle renklendirir
                    colors: [Color.fromARGB(255, 191, 158, 248), Color.fromARGB(255, 94, 56, 161)]),*/
                                    // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                    color: Colors.white),
                                child: Row(children: <Widget>[
                                  /*Text(snapshot.data!['products'][index]['date']),
                                  SizedBox(
                                    height: 5,
                                  ),*/
                                  Image.asset(
                                    'assets/products/' +
                                        ilan_liste[index]['productImg'],
                                    height:  MediaQuery.of(context).size.height*0.5,
                                    width: MediaQuery.of(context).size.width*0.5,
                                  ),SizedBox(
                                    width:MediaQuery.of(context).size.width*0.02,
                                  ),
                                  Column(children: [
 SizedBox(
                                    height: 8,
                                  ),
                                 
                                Text(ilan_liste[index]['productDistrict']+"-"+ilan_liste[index]['productCity']),
                                 SizedBox(
                                    height:10,
                                  ),
                                   Text(
                                              ilan_liste[index]['productPrice']
                                                      .toString() +
                                                  " TL",
                                              style: TextStyle(
                                               // backgroundColor: Colors.green,
                                                  fontSize: 20,
                                                  color: Color.fromARGB(255, 8, 77, 14),
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                    height:10,
                                  ), Text(
                                              ilan_liste[index]['productName']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.deepPurple))
                                  
                               ],)
                               
                                ])))
                      

                      ]);
                   
        
        
                 
                 
                  }))),
    );
  }
  List<String> siralama=["Eskiden Yeniye","Yeniden Eskiye","Fiyat Artan","Fiyat Azalan"];
Widget siralamaWidget(){
  return Container(
                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), //kenarların şeklini belirler. burada oval yapıldı
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.deepPurple,
                                          blurRadius: 5,
                                          spreadRadius: 0.5,
                                          offset: Offset(5, 5))],color: Colors.white),
                child:DropdownButton(
                
                value: siralama[widget.siralama_turu],
                
                items: siralama.map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem(child:Text(value),value: value);
              }).toList(), onChanged: (value) {
                int secim=0;
                switch (value) {
                  case "Eskiden Yeniye":
                    secim=0;
                    break;
                  case "Yeniden Eskiye":
                    secim=1;
                    break;
                  case "Fiyat Artan":
                  secim=2;
                    
                    break;
                  case "Fiyat Azalan":
                    secim=3;
                    break;
                  default:
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsViewPage(siralama_turu:secim ,
                          title: widget.title, category: widget.category, type: widget.type, search_key: widget.search_key, price_min: widget.price_min, price_max: widget.price_max,),
                    ));

                },),
            );

}

fiyatFiltrele(){
  return showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        icon: const Icon(Icons.price_check),
                       
                        content: const Text(
                            'Fiyat aralığını giriniz'),
                        actions: <Widget>[
                          TextField( controller: altFiyat,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      hintText: 'En az',
                      hintStyle: TextStyle(color: Colors.deepPurple),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
                    SizedBox(height: 4,),
                    TextField( controller: ustFiyat,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      hintText: 'En çok',
                      hintStyle: TextStyle(color: Colors.deepPurple),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
                    Column(children: [
                      TextButton(
                            onPressed: () {
if(altFiyat.text!=""){

                               Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsViewPage(siralama_turu:widget.siralama_turu ,
                          title: widget.title, category: widget.category, type: widget.type, search_key: widget.search_key, price_min: altFiyat.text, price_max:ustFiyat.text,),
                    ));

}
else{
ustFiyat.clear();
                              altFiyat.clear();
                              Navigator.pop(context);
}
                              
                            },
                            child: const Text('Uygula'),
                          ),
                          TextButton(
                            onPressed: () {
                              ustFiyat.clear();
                              altFiyat.clear();
                              Navigator.pop(context);
                            },
                            child:const Text('İptal'),
                          ),
                    ],)
                          
                        ],
                      ),
                    );
                  
}


Widget filterWidget(){
  return GestureDetector(
                 
                  onTap: () {
fiyatFiltrele();
               /*   showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                       
                        content: const Text(
                            'Filtreleme işlemini seçiniz'),
                        actions: <Widget>[
                          
                          GestureDetector(child: Row(
                            children: [
                             Icon(Icons.price_check),
                              SizedBox(width:5),
                              Text("Fiyat",style:TextStyle(fontSize: 18,color:Color.fromARGB(255, 173, 132, 243)))
                            ],
                          ),onTap: () { fiyatFiltrele();
                           },),

                   
                          TextButton(
                            onPressed: () {
                               Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsViewPage(siralama_turu:widget.siralama_turu ,
                          title: widget.title, category: widget.category, type: widget.type, search_key: widget.search_key, price_min: altFiyat.text, price_max:ustFiyat.text,),
                    ));
                              
                              
                            },
                            child: const Text('Uygula'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child:const Text('İptal'),
                          ),
                        ],
                      ),
                    );*/
                   
                }, child: Container(
                  alignment: Alignment.center,
                  height:50,
                  width: 100,
                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), //kenarların şeklini belirler. burada oval yapıldı
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.deepPurple,
                                          blurRadius: 5,
                                          spreadRadius: 0.5,
                                          offset: Offset(5, 5))],color: Colors.white),
                child:Text(" Fiyat Filtrele"))
);
            

}

late TextEditingController search= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 215, 215),
        drawer: const DrawerViewPage(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Container(
            child: Column(children: <Widget>[
              SizedBox(height:12),  
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  siralamaWidget(),
SizedBox(width:6),  
                  
       filterWidget()
                ],
              ),
              
                        /*Row(
                children: [TextField(controller: search,),
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsViewPage(siralama_turu:widget.siralama_turu ,
                          title: widget.title, category: widget.category, type: widget.type, search_key: widget.search_key,),
                    ));
                  
                }, icon: Icon(Icons.search))                   
                ],
              ),*/
             
              
              ilan_listesi(context)])));
  }
}
