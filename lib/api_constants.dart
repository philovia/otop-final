class ApiConstants {
  // Base URLs
  static const String publicBaseUrl = 'http://127.0.0.1:8083/api';
  static const String adminBaseUrl = 'http://127.0.0.1:8083/admin';
  static const String supplierBaseUrl = 'http://127.0.0.1:8083/supplier';
  static const String cashierBaseUrl = 'http://127.0.0.1:8083/cashier';

  // Public Routes
  static const String register = '$publicBaseUrl/register';
  static const String login = '$publicBaseUrl/login';
  static const String logout = '$publicBaseUrl/logout';

  // Admin Routes
  static const String createSupplier = '$adminBaseUrl/supplier';
  static const String getAllSuppliers = '$adminBaseUrl/suppliers';
  static const String getSupplierByEmail = '$adminBaseUrl/suppliers/email';
  static const String getSupplierByStoreName = '$adminBaseUrl/suppliers/store';
  static const String updateSupplier = '$adminBaseUrl/suppliers/';
  static const String deleteSupplier = '$adminBaseUrl/supplier/';

  // supplier Routes
  static const String addProduct = '$supplierBaseUrl/supplier';
  static const String updateProduct = '$supplierBaseUrl/update/product';
  static const String deleteProduct = '$supplierBaseUrl/delete/product';
  static const String getProductByName = '$supplierBaseUrl/products/name';

  // Cashier Routes
  static const String getProductName = '$supplierBaseUrl/cashier/name';
}
