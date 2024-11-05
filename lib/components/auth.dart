// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:otop_front/pages/desktop_admin_dashboard.dart'; // Import your admin dashboard
import 'package:otop_front/pages/desktop_cashier_dashboard.dart';
import 'package:otop_front/pages/desktop_supplier_dashboard.dart';
import 'package:otop_front/pages/mobile_admin_dashboard.dart'; // Import your mobile admin dashboard
import 'package:otop_front/pages/mobile_cashier_dashboard.dart';
import 'package:otop_front/pages/mobile_supplier_dashboard.dart';
import 'package:otop_front/pages/responsive_dashboard_layout.dart'; // Import your responsive admin dashboard
import 'package:otop_front/pages/responsive_dashboard_cashier.dart';
import 'package:otop_front/pages/responsive_dashboard_supplier.dart';
import 'package:otop_front/pages/tablet_admin_dashboard.dart'; // Import your tablet admin dashboard
import 'package:otop_front/pages/tablet_cashier_dashboard.dart';
import 'package:otop_front/pages/tablet_supplier_dashboard.dart';
import 'package:otop_front/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Instance of AuthService

  void _redirectUser(String role) {
    String routeName;
    switch (role) {
      case 'admin':
        routeName = '/admin';
        break;
      case 'cashier':
        routeName = '/cashier';
        break;
      case 'supplier':
      default:
        routeName = '/supplier';
        break;
    }
    Navigator.pushReplacementNamed(context, routeName);
  }

  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      String role = await _authService.login(context, email, password);
      if (!mounted) return;
      _redirectUser(role); // Redirect based on the user role
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      // You can handle the token if needed
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('DOLORES OTOP.PH')),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(194, 255, 255, 255),
            border: Border.all(color: Colors.indigo),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "images/otopph.png",
                    height: 100,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Login',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                _buildTextField(_emailController, 'Email'),
                const SizedBox(height: 10),
                _buildTextField(_passwordController, 'Password',
                    obscureText: true),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscureText,
    );
  }
}

class AuthService {
  final Logger _logger = Logger();
  final String _baseApiUrl = 'http://127.0.0.1:8096'; 

  Future<String> login(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseApiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await _saveToken(data['token']);
        return data['role']; 
      } else {
        final errorMessage = json.decode(response.body)['error'] ?? 'Login failed';
        throw Exception(errorMessage);
      }
    } catch (e) {
      _logger.e("Login error: $e");
      throw Exception("An error occurred during login");
    }
  }

  Future<void> logout(BuildContext context, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseApiUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        final errorMessage = json.decode(response.body)['error'] ?? 'Logout failed';
        throw Exception(errorMessage);
      }
    } catch (e) {
      _logger.e("Logout error: $e");
      throw Exception("An error occurred during logout");
    }
  }


  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthForm(),
        routes: {
          '/login': (context) => const AuthForm(),
          '/admin': (context) => const ResponsiveDashboardLayout(
                mobileAdminDashboard: MobileAdminDashboard(),
                tabletAdminDashboard: TabletAdminDashboard(),
                desktopAdminDashboard: DesktopAdminDashboard(),
              ),
          '/cashier': (context) => const ResponsiveDashboardCashier(
                mobileCashierDashboard: MobileCashierDashboard(),
                tabletCashierDashboard: TabletCashierDashboard(),
                desktopCashierDashboard: DesktopCashierDashboard(),
              ),
          '/supplier': (context) => const ResponsiveDashboardSupplier(
                mobileSupplierDashboard: MobileSupplierDashboard(),
                tabletSupplierDashboard: TabletSupplierDashboard(),
                desktopSupplierDashboard: DesktopSupplierDashboard(),
              ),
        },
      ),
    );
  }
}
