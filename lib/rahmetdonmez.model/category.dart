class Category{
   String name="";
   int id=0;
Category(String name,String id);
Category.fromJson(Map json):name=json['categoryName'],id=json['categoryId'];

}