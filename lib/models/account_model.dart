import 'package:hive/hive.dart';
part 'account_model.g.dart'; // File generated code Hive

@HiveType(typeId: 0)
class AccountModel extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String hashedPassword;

  AccountModel({
    required this.username,
    required this.hashedPassword,
  });
}
