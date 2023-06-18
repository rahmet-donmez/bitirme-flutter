import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.ui/product_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../rahmetdonmez.model/category.dart';
import '../rahmetdonmez.ui/home.dart';
import '../rahmetdonmez.ui/product_list.dart';

class ApiService {
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  final encoding = Encoding.getByName('utf-8');

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  session_atama(Map data)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = data['user']['userId'].toString();
      String email = data['user']['userEmail'];String first_name = data['user']['userFirstName'];
      String last_name = data['user']['userLastName'];
      String phone = data['user']['userPhone'].toString();
      String password = data['user']['userPassword'];
            String image = data['user']['userImg'];


      

      prefs.setBool("isLogin", true);
      prefs.setString("userId", id);
            prefs.setString("image", image);

      prefs.setString("isim", first_name);
      prefs.setString("soyisim", last_name);
      prefs.setString("telefon", phone);
      prefs.setString("password", password);
      prefs.setString("email", email);

  }

  Future<void> login(
      String eMail, String password, BuildContext context) async {
    final uri = Uri.parse(
        'http://localhost:5229/api/User/login?email=$eMail&password=$password');
    // await SqlConn.connect(ip: "192.168.2.107", port: "1423", databaseName: "E-Commerce", username: "user", password: "user");
    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());

    if (data['status'] == true) {
     session_atama(data);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          icon: Icon(FontAwesomeIcons.exclamationCircle),
          title: Text('Hatalı Giriş'),
          content: Text('Lütfen giriş bilgilerinizi kontrol ediniz.'),
        ),
      );
    }
  }

  Future<void> register(String first_name, String last_name, String phone,
      String eMail, String password, BuildContext context) async {
    final uri = Uri.parse(
        'http://localhost:5229/api/User/register?first_name=$first_name&last_name=$last_name&phone=$phone&email=$eMail&password=$password');
    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());
    if (data['status'] == true) {
     session_atama(data);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(FontAwesomeIcons.exclamationCircle),
          title: Text('Kayıt Başarısız'),
          content: Text(data['message']),
        ),
      );
    }
  }

  Future<void> user_update(String first_name, String last_name, String phone,
      String eMail, String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.get("userId").toString();
    final uri = Uri.parse(
        'http://localhost:5229/api/User/update?id=$id&first_name=$first_name&last_name=$last_name&phone=$phone&email=$eMail&password=$password');
    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());
    if (data['status'] == true) {
    session_atama(data);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(FontAwesomeIcons.exclamationCircle),
          title: Text('Kayıt Başarısız'),
          content: Text(data['message']),
        ),
      );
    }
  }

  Future<void> user_delete(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.get("userId").toString();

    final uri = Uri.parse('http://localhost:5229/api/User/delete?id=$id');
    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());
    if (data['status']== true) {
      logout(context);
    
    }
  }

  Future<Map> get_user(String id) async {
    final uri = Uri.parse('http://localhost:5229/api/User/user?id=$id');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data['user'];
  }

  Future<Map> product(String type, int id,int siralama,String search,String alt,String ust) async {
  if(alt==""){
      alt="0";
    }
    
    switch (type) {
      case "products":
        return products(siralama,alt,ust);
case "search":
        return searchProduct(search,siralama,alt,ust);

      case "my_products":
     
        return my_products(siralama,alt,ust);
      case "filter_products":
        return filter_products(id,siralama,alt,ust);

      default:
    }
    return products(siralama,alt,ust);
  }

  Future<Map> products(int siralama,String alt,String ust) async {
  
    final uri = Uri.parse('http://localhost:5229/api/Product/products?siralama=$siralama&alt=$alt&ust=$ust');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data;
  }Future<Map> searchProduct(String search,int siralama,String alt,String ust) async {
    final uri = Uri.parse('http://localhost:5229/api/Product/searchProducts?siralama=$siralama&search=$search&alt=$alt&ust=$ust');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data;
  }
  Future<Map> son_products() async {
    final uri = Uri.parse('http://localhost:5229/api/Product/sonProducts');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data;
  }

  Future<Map> filter_products(int id,int siralama,String alt,String ust) async {
    final uri = Uri.parse(
        'http://localhost:5229/api/Product/filterProducts?category_id=$id&siralama=$siralama&alt=$alt&ust=$ust');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data;
  }

  Future<Map> my_products(int siralama,String alt,String ust) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.get("userId").toString();
    final uri =
        Uri.parse('http://localhost:5229/api/Product/myProducts?user_id=$id&siralama=$siralama&alt=$alt&ust=$ust');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data;
  }

  Future<Map> product_details(String id) async {
    final uri = Uri.parse('http://localhost:5229/api/Product/product?id=$id');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data;
  }
  Future<String> product_userid(String id) async {
    final uri = Uri.parse('http://localhost:5229/api/Product/product?id=$id');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
    return data['product']['userId'].toString();
  }

  Future<void> product_delete(String id, BuildContext context) async {
    final uri = Uri.parse('http://localhost:5229/api/Product/delete?id=$id');

    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsViewPage(
                  title: "İlanlarım",
                  category: 0,
                  type: "my_products", siralama_turu: 0, search_key: '', price_max: '0', price_min: '0',
                )));
  }

  Future<void> product_add(
      String ad,
      String aciklama,
      String renk,
      String marka,
      String model,
      String yil,
      String motor_gucu,
      String km,
      String sehir,
      String semt,
      String durum,
      String fiyat,
int kategori,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.get("userId").toString();
    final uri = Uri.parse(
        'http://localhost:5229/api/Product/add?user_id=$user_id&ad=$ad&aciklama=$aciklama&renk=$renk&marka=$marka&model=$model&yil=$yil&motor_gucu=$motor_gucu&km=$km&sehir=$sehir&semt=$semt&durum=$durum&fiyat=$fiyat&kategori=$kategori');

    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());
    if (data['status'] == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsViewPage(id: data['product']['productId'], yetki: true,)));
    } else {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: const Icon(FontAwesomeIcons.exclamationCircle),
          title: Text('İşlem Başarısız'),
          content: Text(data['message']),
        ),
      );
    }
  }

  Future<void> product_update(
      String product_id,
      String ad,
      String aciklama,
      String renk,
      String marka,
      String model,
      String yil,
      String motor_gucu,
      String km,
      String sehir,
      String semt,
      String durum,
      String fiyat,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.get("userId").toString();
    final uri = Uri.parse(
        'http://localhost:5229/api/Product/update?user_id=$user_id&product_id=$product_id&ad=$ad&aciklama=$aciklama&renk=$renk&marka=$marka&model=$model&yil=$yil&motor_gucu=$motor_gucu&km=$km&sehir=$sehir&semt=$semt&durum=$durum&fiyat=$fiyat');

    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());
    if (data['status'] == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsViewPage(id: data['product']['productId'], yetki: true,)));
    } else {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: const Icon(FontAwesomeIcons.exclamationCircle),
          title: Text('İşlem Başarısız'),
          content: Text(data['message']),
        ),
      );
    }
  }

  Future<Map> categories() async {
    final uri = Uri.parse('http://localhost:5229/api/Category/categories');

    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());

    return data;
  }
   Future<List<Category>> category() async {
    final uri = Uri.parse('http://localhost:5229/api/Category/categories');

    Response response = await post(uri);
    var data = jsonDecode(response.body.toString());
    var veri=data['categories'];
    List<Category> categories=[];
    for(int i=0;i<veri.length;i++){
      
      categories.add(Category.fromJson(veri[i]));

    }
   // categories=veri.map((e) => Category.fromJson(e)).toList();

    return categories;
  }

 Future<Map> images(int product_id) async {
    final uri = Uri.parse('http://localhost:5229/api/Image/images?product_id=$product_id');

    Response response = await get(uri);
    var data = jsonDecode(response.body.toString());
   
    return data;
  }

}
