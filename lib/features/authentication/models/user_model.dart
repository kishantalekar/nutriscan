// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nutriscan/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String username;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final List<String> scannedHistory;
  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.scannedHistory = const [],
  });

  String get fullname => '$firstname $lastname';

  String get formattedNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullname) => fullname.split(" ");

  static String generateUsername(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCase = "$firstName$lastName";
    String userNameWithPrefix = "cwt_$camelCase";
    return userNameWithPrefix;
  }

  static UserModel empty() => UserModel(
        id: '',
        firstname: '',
        lastname: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        scannedHistory: [],
      );

  UserModel copyWith(
      {String? id,
      String? firstname,
      String? lastname,
      String? username,
      String? email,
      String? phoneNumber,
      String? profilePicture,
      List<String>? scannedHistory}) {
    return UserModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      scannedHistory: scannedHistory ?? this.scannedHistory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'scannedHistory': scannedHistory
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as String,
        firstname: map['firstname'] as String,
        lastname: map['lastname'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
        phoneNumber: map['phoneNumber'] as String,
        profilePicture: map['profilePicture'] as String,
        scannedHistory: List<String>.from(map['scannedHistory'] ?? []));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, firstname: $firstname, lastname: $lastname, username: $username, email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture) scaneedhitory $scannedHistory';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.username == username &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profilePicture.hashCode;
  }
}
