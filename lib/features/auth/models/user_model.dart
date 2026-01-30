//we make this class to store data on hive
import 'package:hive_flutter/hive_flutter.dart';
// .g (to generate/create) the file
part 'user_model.g.dart';
//@HiveType => this is the adapter that we use it to store data in DB

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String image;

  UserModel({required this.image, required this.name});
}
