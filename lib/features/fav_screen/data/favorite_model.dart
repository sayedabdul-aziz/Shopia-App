class InFavModel {
//    "status": true,
//     "message": "تمت الإضافة بنجاح",
//     "data": {
//         "id": 52051,
//         "product": {
//             "id": 53,
//             "price": 5599,
//             "old_price": 10230,
//             "discount": 45,
//             "image": "https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg"
//         }
//     }
// }

  late bool status;
  late String message;

  InFavModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
