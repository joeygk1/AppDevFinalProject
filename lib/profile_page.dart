import 'package:flutter/material.dart';
import 'widgets.dart';
import 'login_page.dart';
import 'edit_profile_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final Function(String, String) onProfileUpdate;

  const ProfilePage({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.onProfileUpdate,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _currentName;
  late String _currentEmail;

  @override
  void initState() {
    super.initState();
    _currentName = widget.userName;
    _currentEmail = widget.userEmail;
  }

  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          userName: _currentName,
          userEmail: _currentEmail,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _currentName = result['name'];
        _currentEmail = result['email'];
      });
      // Notify home page of the update
      widget.onProfileUpdate(_currentName, _currentEmail);
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
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          buildLogoutButton(context),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/magic_sole_icon.png'),
              ),
              SizedBox(height: 20),
              Text(
                _currentName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                _currentEmail,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _navigateToEditProfile,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
