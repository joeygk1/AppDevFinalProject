import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/sneaker.dart';
import 'sneaker_details_page.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  List<Sneaker> sneakers = [];
  bool isLoading = true;
  String error = '';
  final String apiKey = 'sd_skslOnbvjwevRzBfcJSxYCUNBNaAZYQz';
  final TextEditingController _searchController = TextEditingController();
  String brand = 'Nike';
  final List<String> availableBrands = ['Nike', 'Adidas', 'Jordan', 'New Balance', 'Puma'];

  @override
  void initState() {
    super.initState();
    fetchSneakers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchSneakers() async {
    try {
      String queryParams = '';
      if (brand.isNotEmpty) {
        queryParams = '?brand=$brand';
      }
      if (_searchController.text.isNotEmpty) {
        queryParams += queryParams.isEmpty ? '?' : '&';
        queryParams += 'query=${Uri.encodeComponent(_searchController.text)}';
      }

      final response = await http.get(
        Uri.parse('https://api.kicks.dev/v3/stockx/products$queryParams'),
        headers: {
          'Authorization': apiKey,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          final List<dynamic> products = data['data'] ?? [];
          setState(() {
            sneakers = products.map((json) => Sneaker.fromJson(json)).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            error = 'API returned unsuccessful status';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          error = 'Failed to load sneakers: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  void _handleSearch(String query) {
    setState(() {
      isLoading = true;
    });
    fetchSneakers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Sneaker Marketplace',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                isLoading = true;
                error = '';
                brand = '';
                _searchController.clear();
              });
              fetchSneakers();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search sneakers...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    _handleSearch(query);
                  }
                },
              ),
            ),
            // Brand Filter Chips
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableBrands.length,
                itemBuilder: (context, index) {
                  final currentBrand = availableBrands[index];
                  final isSelected = brand == currentBrand;
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        currentBrand,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          brand = selected ? currentBrand : '';
                          isLoading = true;
                        });
                        fetchSneakers();
                      },
                      backgroundColor: Colors.grey[900],
                      selectedColor: Colors.yellow,
                      checkmarkColor: Colors.black,
                    ),
                  );
                },
              ),
            ),
            // Sneaker Grid
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.yellow,
        ),
      );
    }

    if (error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  error = '';
                });
                fetchSneakers();
              },
              child: Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    if (sneakers.isEmpty) {
      return Center(
        child: Text(
          brand.isNotEmpty 
              ? 'No sneakers found for $brand'
              : 'No sneakers found',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: sneakers.length,
      itemBuilder: (context, index) {
        final sneaker = sneakers[index];
        return _buildSneakerCard(sneaker);
      },
    );
  }

  Widget _buildSneakerCard(Sneaker sneaker) {
    return Card(
      color: Colors.grey[900],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SneakerDetailsPage(sneaker: sneaker),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sneaker Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                ),
                child: sneaker.image.isNotEmpty
                    ? Image.network(
                        sneaker.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image_not_supported, color: Colors.white);
                        },
                      )
                    : Icon(Icons.image_not_supported, color: Colors.white),
              ),
            ),
            // Sneaker Info
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sneaker.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    sneaker.brand,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${sneaker.avgPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
