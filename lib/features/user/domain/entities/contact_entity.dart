
import 'dart:typed_data';

class ContactEntity {

  final String? phoneNumber;
  final String? label;
  final String? uid;
  final String? status;
  final Uint8List? userProfile;

  ContactEntity({this.phoneNumber, this.label, this.uid, this.status, this.userProfile});

}