import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String userEmail;

  const EditProfilePage({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.userEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check if email is already taken by another user
      if (widget.userEmail != _emailController.text.trim()) {
        final emailQuery = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: _emailController.text.trim())
            .get();

        if (emailQuery.docs.isNotEmpty) {
          setState(() {
            _errorMessage = 'Email already exists';
          });
          return;
        }
      }

      // Update user in Firestore
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        await userQuery.docs.first.reference.update({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
        });

        // Show success message and pop back to profile page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context, {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                buildTextFormField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                buildTextFormField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _updateProfile,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellow,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.black)
                        : Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 