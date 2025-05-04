class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;
  CategoriesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{
  int? currentPage;
  List<DataModelOfCategories> data = [];

 CategoriesDataModel.fromJson(Map<String,dynamic>json){
  currentPage = json['current_page'];
  json['data'].forEach((element){
    data.add(DataModelOfCategories.fromJson(element));
  });


 }
}
class DataModelOfCategories{
  late int id ;
  late String name;
  late String image;
  DataModelOfCategories.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];

  }
}