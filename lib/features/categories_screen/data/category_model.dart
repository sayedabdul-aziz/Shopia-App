class CategoryModel {
//     "status": true,
//     "message": null,
//     "data": {
//         "current_page": 1,
//         "data": [
//             {
//                 "id": 44,
//                 "name": "اجهزه الكترونيه",
//                 "image": "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"
//             },
//
//         ],
//         "first_page_url": "https://student.valuxapps.com/api/categories?page=1",
//         "from": 1,
//         "last_page": 1,
//         "last_page_url": "https://student.valuxapps.com/api/categories?page=1",
//         "next_page_url": null,
//         "path": "https://student.valuxapps.com/api/categories",
//         "per_page": 35,
//         "prev_page_url": null,
//         "to": 5,
//         "total": 5
//     }

  late bool status;
  late CategoryDataModel data;

  CategoryModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJSON(json['data']);
  }
}

class CategoryDataModel {
  late int currentPage;
  late List<DataModel> data = [];

  CategoryDataModel.fromJSON(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJSON(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
