import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.partial/drawer.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/product_details.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/product_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rahmetdonmez.service/api_service.dart';

class HomePage extends StatelessWidget {
  ApiService api = ApiService();

  Widget kategoriler() {
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
            return Container(
                child: ListView.builder(
                    shrinkWrap:
                        true, //listview bulunduğu alanı doldurmaya çalışır. renderbox hatası
                    itemCount: snapshot.data!['categories'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(

                          /*  decoration: BoxDecoration(
                                  
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment
                                          .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                      colors: [
                                        Color.fromARGB(255, 209, 199, 226),
                                        Color.fromARGB(255, 148, 129, 180)
                                      ]),
                                  // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                  color: Colors.white),*/
                          child: Column(
                        children: [
                          ListTile(
                            tileColor: Color.fromARGB(255, 186, 166, 221),
                            title: Text(snapshot.data!['categories'][index]['categoryName']),
                            leading: Icon(Icons.category),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsViewPage(
                                        title: snapshot.data!['categories'][index]
                                            ['categoryName'],
                                        category: snapshot.data!['categories'][index]
                                            ['categoryId'],
                                        type: "filter_products", siralama_turu: 0, search_key: '', price_max: '0', price_min: '0',),
                                  ));
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ));
                    }));
          }
        },
        future: api.categories());
  }

  Widget son_ilanlar() {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Column(


children: <Widget>[
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
          
            return Center(
                child: ListView.builder(
                    shrinkWrap:
                        true, //listview bulunduğu alanı doldurmaya çalışır. renderbox hatası
                    itemCount: snapshot.data!['products'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(

children: <Widget>[
                           GestureDetector(
                            //containerın tıklanabilir olmasını sağlar
                             onTap: () async {
                              bool yetki = false;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              String user_id = prefs.get("userId").toString();
                              String product_userid = await api.product_userid(
                                  snapshot.data!['products'][index][
                                              'productId'].toString());
                             
                              if (user_id == product_userid) {
                                
                                  yetki = true;
                               
                              }
                              

                             /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsViewPage(
                                            id:snapshot.data!['products'][index][
                                              'productId'],
                                            yetki: yetki,
                                          ))); 
                                          */
                                          
                                          
                                          //id:ilan_liste[index]['productId']
                            },
                            
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width*0.9,

                               // width: 300,
                               // height: 350,
                                alignment: Alignment.center,
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
                                child: Column(children: <Widget>[
                                  Text(snapshot.data!['products'][index]['date']),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //Text(ilan_liste[index]['productImg']),
                                  Image.asset(
                                    'assets/products/' +
                                        snapshot.data!['products'][index]['productImg'],
                                    height:  MediaQuery.of(context).size.height*0.5,
                                    width: MediaQuery.of(context).size.width*0.9,
                                  ),
                                  
                                Text(snapshot.data!['products'][index]['productDistrict']+"-"+snapshot.data!['products'][index]['productCity']),
                                 SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 200,
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
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment
                                                  .centerRight, //soldan sağa belirtilen rrenkler arası geçişle renklendirir
                                              colors: [
                                                Color.fromARGB(
                                                    255, 191, 158, 248),
                                                Color.fromARGB(255, 94, 56, 161)
                                              ]),
                                          // border: Border.all(color: Colors.deepPurple,style:BorderStyle.solid,width: 3),//kenar kalınlığı ve çizgi rengini belirler
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Text(
                                              snapshot.data!['products'][index]['productPrice']
                                                      .toString() +
                                                  " TL",
                                              style: TextStyle(
                                               // backgroundColor: Colors.green,
                                                  fontSize: 20,
                                                  color: Color.fromARGB(255, 8, 77, 14),
                                                  fontWeight: FontWeight.w500)),
                                          Text(
                                              snapshot.data!['products'][index]['productName']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white))
                                        ],
                                      ))
                                ])))
                      

                      ]);
                    }));
          }
        },
        future: api.son_products());
  }



  Widget son_ilanlar2() {
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
          
            return Center(
                child: ListView.builder(
                    shrinkWrap:
                        true, //listview bulunduğu alanı doldurmaya çalışır. renderbox hatası
                    itemCount: snapshot.data!['products'].length,
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
                                  snapshot.data!['products'][index][
                                              'productId'].toString());
                             
                              if (user_id == product_userid) {
                                
                                  yetki = true;
                               
                              }
                              

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsViewPage(
                                            id:snapshot.data!['products'][index][
                                              'productId'],
                                            yetki: yetki,
                                          ))); 
                                          
                                          
                                          
                                          //id:ilan_liste[index]['productId']
                            },
                            
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width*0.9,

                               // width: 300,
                                height: 150,
                                alignment: Alignment.center,
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
                                        snapshot.data!['products'][index]['productImg'],
                                    height:  MediaQuery.of(context).size.height*0.5,
                                    width: MediaQuery.of(context).size.width*0.5,
                                  ),SizedBox(
                                    width:MediaQuery.of(context).size.width*0.02,
                                  ),
                                  Column(children: [
 SizedBox(
                                    height: 8,
                                  ),
                                 
                                Text(snapshot.data!['products'][index]['productDistrict']+"-"+snapshot.data!['products'][index]['productCity']),
                                 SizedBox(
                                    height:10,
                                  ),
                                   Text(
                                              snapshot.data!['products'][index]['productPrice']
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
                                              snapshot.data!['products'][index]['productName']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.deepPurple))
                                  
                               ],)
                               
                                ])))
                      

                      ]);
                    }));
          }
        },
        future: api.son_products());
  }


  Widget ilanlar() {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                    color: Colors.amber,
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.all(10));
              },
              shrinkWrap:
                  true, //listview bulunduğu alanı doldurmaya çalışır. renderbox hatası
              itemCount: 5,
            );
          }
        },
        future: api.son_products());
  }


Widget ozellikler(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      //shape: BoxShape.circle,//containerın şeklini belirler. daire, dikdortgen vb
      borderRadius: BorderRadius.circular(10),
      color:Colors.white,
    ),
    
    width: MediaQuery.of(context).size.width,
        
        child:Column(
    children: [ SizedBox(height: 4,),
      Text("Güvenli Ticaret",style: TextStyle(color: Colors.deepPurple),),
      SizedBox(height: 4,),
      Text("24/7 Hizmet",style: TextStyle(color: Colors.deepPurple)),
      SizedBox(height: 4,),
      Text("Ücretsiz İlan Verme",style: TextStyle(color: Colors.deepPurple)),
      SizedBox(height: 4,),
      Text("Ücretsiz Alışveriş",style: TextStyle(color: Colors.deepPurple)),
      SizedBox(height: 4,),

    ],
  ) 

  );
  
  
}
final List<String> sliderList=["assets/images/slider1.jpg","assets/images/slider2.jpg"]; 

Widget slider(){
  return Container(
  margin: EdgeInsets.all(15),
  child: CarouselSlider.builder(
    itemCount: sliderList.length,
    options: CarouselOptions(
      enlargeCenterPage: true,
      height: 300,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      reverse: false,
      aspectRatio: 5.0,
    ),
    itemBuilder: (context, i, id){
      //for onTap to redirect to another screen
      return  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white,)
        ),
          //ClipRRect for image border radius
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              sliderList[i],
            width: 500,
            fit: BoxFit.cover,
            ),
          ),
       
       
      );
    },
  ),
);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 219, 215, 215),
        drawer: DrawerViewPage(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ana Sayfa'),
        ),
        body: SingleChildScrollView(

            child: Column(
          children: <Widget>[
           slider(),
               SizedBox(
              height: 12,
            ),
            Text("Kategoriler",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 12,
            ),
            kategoriler(),
            SizedBox(
              height: 12,
            ),
            Text("Son Eklenen İlanlar",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
            son_ilanlar2(),
           
 SizedBox(
              height: 12,
            ),
            ozellikler(context),
          ],
        )
        ));
  }
}
