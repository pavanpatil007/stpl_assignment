
import '../../domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.customerId,
    required super.fName,
    required super.mName,
    required super.lName,
    required String? mobileNo,
    required super.isCow,
    required super.isBuffalo,
  }) : super(
    mobileNo: mobileNo ?? "",
  );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json['customerId'] ?? 0,
      fName: json['fName'] ?? "",
      mName: json['mName'] ?? "",
      lName: json['lName'] ?? "",
      mobileNo: json['mobileNo'],
      isCow: json['isCow'] ?? 0,
      isBuffalo: json['isBuffalo'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'fName': fName,
      'mName': mName,
      'lName': lName,
      'mobileNo': mobileNo,
      'isCow': isCow,
      'isBuffalo': isBuffalo,
    };
  }
}