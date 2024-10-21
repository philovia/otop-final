// service_form_widget.dart

// ignore_for_file: use_super_parameters, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:logging/logging.dart' as logging;
import 'package:otop_front/services/add_supplier_service.dart';

// Initialize logger
final log = logging.Logger('ServiceFormWidget');

class SupplierForm extends StatefulWidget {
  const SupplierForm({Key? key}) : super(key: key);

  @override
  _SupplierFormState createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final AddSupplierService _userService =
      AddSupplierService(); // Instantiate the UserService

  // Function to handle form submission
  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Collect form data
      Map<String, String> userData = {
        'username': _usernameController.text,
        'store_name': _storeNameController.text,
        'email': _emailController.text,
        'contact': _contactController.text,
        'address': _addressController.text,
      };

      // Call the user service to register the user
      final success = await _userService.registerUser(userData);

      if (success) {
        log.info('User registered successfully');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User registered successfully!')));
      } else {
        log.warning('Registration failed');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration failed.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(135, 233, 227, 227),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _storeNameController,
                  decoration: InputDecoration(labelText: 'Store Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the store name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a contact number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: handleSubmit,
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
