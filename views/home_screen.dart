import 'package:app_project_test/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:app_project_test/models/product_mode.dart';
import '../components/product_card.dart';
import 'product_detail_screen.dart';
import 'package:app_project_test/views/card_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final ApiService apiService = ApiService();

  bool isloading = false;
  String error = "";
  List<Product> products = [];
  Set<String> cart = {};

  Future<void> fetchProducts() async {
    try {
      setState(() {
        isloading = true;
        error = "";
      });
      var fetchedProducts = await apiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      setState(() {
        error = "Failed to load products";
      });
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CardScreen(
                          cartItems: products,
                        ),
                      ));
                    },
                    iconSize: 30,
                    icon: const Icon(Icons.shopping_bag_rounded),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Find your favorite products",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search for products",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage("https://wantapi.com/assets/banner.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: isloading
                    ? const Center(child: CircularProgressIndicator())
                    : error.isNotEmpty
                        ? Center(child: Text(error, style: const TextStyle(color: Colors.red)))
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: 
                                      (context) => ProductDetailScreen(product: product, cart: cart),
                                  ));
                                },
                                child: ProductCard(
                                  title: product.title,
                                  price: product.price.toString(),
                                  image: product.image,
                                ),
                              );
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}