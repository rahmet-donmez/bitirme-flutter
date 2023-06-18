import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikinci_el_arac_mobil/rahmetdonmez.service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rahmetdonmez.model/category.dart';
import '../rahmetdonmez.partial/drawer.dart';

class ProductAddViewPage extends StatefulWidget {
  const ProductAddViewPage({super.key});

  @override
  State<ProductAddViewPage> createState() => ProductAddPage();
}

class ProductAddPage extends State<ProductAddViewPage> {
  ApiService api = ApiService();
  TextEditingController ad_controller = TextEditingController();
  TextEditingController aciklama_controller = TextEditingController();
  TextEditingController renk_controller = TextEditingController();
  TextEditingController marka_controller = TextEditingController();
  TextEditingController model_controller = TextEditingController();
  TextEditingController _controller = TextEditingController();
  TextEditingController yil_controller = TextEditingController();
  TextEditingController motor_gucu_controller = TextEditingController();
  TextEditingController km_controller = TextEditingController();
  TextEditingController sehir_controller = TextEditingController();
  TextEditingController semt_controller = TextEditingController();
  TextEditingController durum_controller = TextEditingController();
  TextEditingController fiyat_controller = TextEditingController();

int category_selected_id=0;

List<Category> categories=[];


  @override
  void initState() {

getcategories();

    super.initState();
  }

getcategories()async {
  //var values=await api.categories();
  //categories=values["categories"];
  categories=await api.category();
  Future.delayed(Duration(seconds: 3));
 /* for(int i=0;i<values['categories'].length;i++){
    categories.add(values['categories'][i]['categoryName']);
  }*/



}
  

 Widget dropdown(){
 String selectedvalue="otomobil";


  return DropdownButtonFormField(
    
    items:categories.map<DropdownMenuItem<String>>
  (
    (e){
       return DropdownMenuItem<String>(
          value: e.name,
          child: Text(e.name),
        );
    }
  ).toList(), onSaved: (String? value) { 
      //selectedvalue=value!;
//category_selected_id=categories.indexOf(value); 

  // print(category_selected_id);
   },
   value: selectedvalue, onChanged: (String? value) {
   
      
    
      },
  );

    
 
 }
 String button_text="Kategori Seç";
Widget category_select(){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor:Color.fromARGB(255, 197, 195, 195)),
    
    onPressed: () {
    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        
                        
                        child:
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                            
                            return ListTile(
                        
                              title: Text(categories[index].name),
                              onTap: () {
                                setState(() {
                                                                  button_text=categories[index].name;

                                });
                                category_selected_id=categories[index].id;
                                Navigator.pop(context);
                                

                                
                              },

                            );
                            
                          },
                           itemCount: categories.length)
                          
                       
                      ),
                    );
    
  }, child: Text(button_text,style: TextStyle(color:Colors.black),));
}



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor:  Color.fromARGB(255, 219, 215, 215),
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
     Container(
       padding: EdgeInsets.all(10),
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
                //child:dropdown()
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
                    controller: fiyat_controller,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                      labelText: "Fiyat",
                      hintText: 'Fiyat',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),SizedBox(
                height: 12,
              ),
              category_select(),SizedBox(
                height: 12,
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
                      fiyat_controller.text,
category_selected_id,
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
