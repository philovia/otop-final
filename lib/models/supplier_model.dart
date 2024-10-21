// supplier_model.dart

class Supplier {
  final String username;
  final String storeName;
  final String email;
  final String contact;
  final String address;

  Supplier({
    required this.username,
    required this.storeName,
    required this.email,
    required this.contact,
    required this.address,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      username: json['username'],
      storeName: json['store_name'],
      email: json['email'],
      contact: json['contact'],
      address: json['address'],
    );
  }
}
