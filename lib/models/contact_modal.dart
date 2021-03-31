import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
part 'contact_modal.g.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone_no;

  @HiveField(2)
  String email;

  Contact({
    @required this.name,
    @required this.phone_no,
    this.email,
  });
}
