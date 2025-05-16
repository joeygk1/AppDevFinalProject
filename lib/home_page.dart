import 'package:flutter/material.dart';
import 'login_page.dart';
import 'services_page.dart';
import 'profile_page.dart';
import 'marketplace_page.dart';
import 'orders_page.dart';
import 'videos_page.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  
  const HomePage({
    Key? key, 
    required this.userName,
    required this.userEmail,
  }) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Navigate based on index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServicesPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideosPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MarketplacePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrdersPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(
            userName: widget.userName,
            userEmail: widget.userEmail,
          )),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Home', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'Magic Sole',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome, ${widget.userName}',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMenuButton('Services', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ServicesPage()),
                      );
                    }),
                    SizedBox(height: 20),
                    _buildMenuButton('Videos', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideosPage()),
                      );
                    }),
                    SizedBox(height: 20),
                    _buildMenuButton('Marketplace', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MarketplacePage()),
                      );
                    }),
                    SizedBox(height: 20),
                    _buildMenuButton('Orders', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersPage()),
                      );
                    }),
                    SizedBox(height: 20),
                    _buildMenuButton('Profile', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage(
                          userName: widget.userName,
                          userEmail: widget.userEmail,
                        )),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.cleaning_services, 'Services'),
              _buildNavItem(1, Icons.play_circle_outline, 'Videos'),
              _buildNavItem(2, Icons.shopping_bag_outlined, 'Marketplace'),
              _buildNavItem(3, Icons.receipt_long, 'Orders'),
              _buildNavItem(4, Icons.person_outline, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellow,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : Colors.grey[600],
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
