class LoginModel {
//     "status": true,
//     "message": "تم تسجيل الدخول بنجاح",
//     "data": {
//         "id": 6743,
//         "name": "sayedhassan",
//         "email": "sayed@gmail.com",
//         "phone": "010029279",
//         "image": "https://student.valuxapps.com/storage/uploads/users/ilKsVauDC2_1639221095.jpeg",
//         "points": 0,
//         "credit": 0,
//         "token": "1R8uc1X81dqzXMwaJuUR7xdqwrfyHqhCrDySfRixRRNF5DebGYnIDYc8wLGEhlU2afR7Ii"
//     }
// }

  late bool? status;
  late String? message;
  late UserData? data;

  LoginModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJSON(json['data']) : null);
  }
}

class UserData {
  late int? id;
  late String? name;
  late String? email;
  late String? phone;
  late String? image;
  late int? points;
  late int? credit;
  late String? token;

  //named constructor
  UserData.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = 'https://avatars.githubusercontent.com/u/71665268?v=4';
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
