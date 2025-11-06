import 'package:e_commerce_app/pages/checkout.dart';
import 'package:e_commerce_app/shared/colors.dart';
import 'package:e_commerce_app/model/item.dart';
import 'package:e_commerce_app/pages/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/provider/cart.dart';
import 'package:e_commerce_app/shared/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/data/products_database.dart';
import 'dart:developer'; //for log()
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final bool? rememberMe;

  const Home({super.key, this.rememberMe});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> products = [];
  bool isLoading = true;
  String? username;
  String? email;
  bool? rememberMe;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    fetchData();
  }

  loadSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      email = prefs.getString('email');
      rememberMe = prefs.getBool('remember_me') ?? widget.rememberMe;
    });

    print("🌟 SharedPreferences Data:");
    print("username: $username");
    print("email: $email");
    print("remember_me: $rememberMe");
  }

  loadProductsFromDB() async {
    final data = await ProductsDatabase.instance.getAllProducts();
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  fetchData() async {
    var response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    if (response.statusCode == 200) {
      var fetchedProducts = jsonDecode(response.body);
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });

      for (var product in fetchedProducts) {
        await ProductsDatabase.instance.insertProduct(product);
      }

      log("✅ Products fetched and saved successfully!");
      //   log(response.body);

      final allProducts = await ProductsDatabase.instance.getAllProducts();
      log("🗂 Current Products in Database:");
      for (var p in allProducts) {
        log(p.toString());
      }
    } else {
      log("failed to load products");
    }
  }

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    final userrr = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [ProductsAndPrice()],
        backgroundColor: appbarGreen,
        title: const Text("Home"),
      ),

      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/cover.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),

                  currentAccountPicture:
                      userrr != null && userrr.photoURL != null
                      ? CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(userrr.photoURL!),
                        )
                      : CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage("assets/img/avatar.jpg"),
                        ),

                  accountEmail: Text(
                    userrr?.email ?? "No email",
                    style: const TextStyle(color: Colors.white),
                  ),

                  accountName: Text(
                    username ?? "Guest User",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
                ListTile(
                  title: Text("My products"),
                  leading: Icon(Icons.add_shopping_cart),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOut()),
                    );
                  },
                ),
                ListTile(
                  title: Text("About"),
                  leading: Icon(Icons.help_center),
                  onTap: () {},
                ),

                ListTile(
                  title: Text("Profile Page"),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),

                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text(
                "Developed by Marah Saadeh © 2025",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(product: product),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                product['image'],
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              product['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Text(
                            "\$${product['price']}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            color: const Color.fromARGB(255, 62, 94, 70),
                            onPressed: () {
                              carttt.add(
                                Item(
                                  name: product['title'],
                                  price: (product['price'] as num).toDouble(),
                                  imgPath: product['image'],
                                ),
                              );
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
