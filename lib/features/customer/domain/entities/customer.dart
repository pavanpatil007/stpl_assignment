import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int customerId;
  final String fName;
  final String mName;
  final String lName;
  final String mobileNo;
  final int isCow;
  final int isBuffalo;

  const Customer({
    required this.customerId,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.mobileNo,
    required this.isCow,
    required this.isBuffalo,
  });

  String get fullName => "$fName $mName $lName";
  String get phoneNumber => mobileNo;

  @override
  List<Object?> get props => [customerId];
}