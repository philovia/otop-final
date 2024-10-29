import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:logging/logging.dart';
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
// import 'package:otop_front/responsive/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLogin = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final String apiUrl = 'http://127.0.0.1:8083/api';

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
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

  Future<void> _handleRegister() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String phone = _phoneController.text.trim();

    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    var response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
        'role': _determineRole(username),
      }),
    );

    if (response.statusCode == 201) {
      _showMessage('Registration successful');
      _toggleForm();
    } else {
      _showError('Registration failed: ${jsonDecode(response.body)['error']}');
    }
  }

  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    var response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      await _saveToken(data['token']);
      if (!mounted) return; // Ensure context is still mounted
      _redirectUser(data['role']); // Call the new redirect method
    } else {
      _showError('Login failed: ${jsonDecode(response.body)['error']}');
    }
  }

  String _determineRole(String username) {
    if (username.endsWith('_admin')) return 'admin';
    if (username.endsWith('_cashier')) return 'cashier';
    return 'supplier';
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      // If there's a token, redirect the user based on their role
      // Implement your logic to fetch role from backend or decode token if it includes role info
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showMessage(String message) {
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
                    _isLogin ? 'Login' : 'Register',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                if (!_isLogin) ...[
                  _buildTextField(_usernameController, 'Username'),
                  const SizedBox(height: 10),
                  _buildTextField(_phoneController, 'Phone Number'),
                  const SizedBox(height: 10),
                ],
                _buildTextField(_emailController, 'Email'),
                const SizedBox(height: 10),
                _buildTextField(_passwordController, 'Password',
                    obscureText: true),
                if (!_isLogin) ...[
                  const SizedBox(height: 10),
                  _buildTextField(
                      _confirmPasswordController, 'Confirm Password',
                      obscureText: true),
                ],
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isLogin) {
                        _handleLogin();
                      } else {
                        _handleRegister();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(_isLogin ? 'Login' : 'Register'),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: _toggleForm,
                    child: Text(
                      _isLogin
                          ? "Don't have an account? Sign Up"
                          : 'Already have an account? Login',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthService {
  final Logger _logger = Logger();
  Future<void> logout(BuildContext context, String token) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8083/api/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Attempt to parse the error as JSON, if possible
        try {
          final errorMessage =
              json.decode(response.body)['error'] ?? 'Logout failed';
          throw Exception(errorMessage);
        } catch (e) {
          // Handle cases where response is not JSON
          throw Exception("Unexpected response format: ${response.body}");
        }
      }
    } catch (e) {
      // Handle any unexpected errors here (e.g., network issues)
      _logger.e("Logout error: $e");
      throw Exception("An error occurred during logout");
    }
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
