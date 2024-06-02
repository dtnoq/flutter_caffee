// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:coffeui/util/coffee_tile.dart';
import 'package:coffeui/util/coffee_types.dart';
import 'package:flutter/material.dart';
import 'package:coffeui/models/models.dart';
import 'package:coffeui/pages/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List latte = [
    // [ coffeImagePath, coffeName, coffeDescription, coffePrice ]
    [
      'lib/images/latte.jpeg',
      'Latte',
      'Default',
      '50000 VND'
    ],
    [
      'lib/images/latte-with-coffee-beans-table.jpg',
      'Latte Beans',
      'With Coffee Beans',
      '55000 VND'
    ],
    [
      'lib/images/latte-coffee-beans-side-view.jpg',
      'Latte Almond',
      'With Almond Milk',
      '55000 VND'
    ],
    [
      'lib/images/coffee-milk-latte-with-strawberry-slices.jpg',
      'Latte Strawberry',
      'With strawberry slices',
      '60000 VND'
    ],
  ];

  final List espresso = [
    [
      'lib/images/person-serving-cup-coffee-with-metal-jug.jpg',
      'Espresso',
      'Espresso coffee',
      '55000 VND'
    ],
  ];

  final List cappucino = [
    [
      'lib/images/photo-1572442388796-11668a67e53d.jpg',
      'Cappucino',
      'Cappucino coffee',
      '55000 VND',
    ],
  ];

  final List black = [
    [
      'lib/images/morning-with-turkish-coffee-brewing.jpg',
      'Turkish',
      'Turkish Coffee',
      '60000 VND'
    ],
  ];

  // overall coffe summary
  late List coffeeTileList = latte;
  // list of coffe types
  final List coffeeType = [
    // [coffee type, isSelected]
    [
      'Latte',
      true,
    ],
    [
      'Espresso',
      false,
    ],
    [
      'Cappucino',
      false,
    ],
    [
      'Black',
      false,
    ],
  ];

  // user tapped on coffe types
  void coffeeTypesSelected(int index) {
    setState(() {
      //this for loop makes every selection false
      for (int i = 0; i < coffeeType.length; i++) {
        coffeeType[i][1] = false;
      }
      coffeeType[index][1] = true;
    });
  }

  final Cart _cart = Cart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(cart: _cart)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(cart: _cart)),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
        ],
      ),
      body: Column(
        children: [
          //Find the best coffe for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Find the best coffee for you",
              style: TextStyle(fontSize: 27),
            ),
          ),

          SizedBox(
            height: 25,
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Find your coffee...",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 25,
          ),

          // Horizantal listview of coffee
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coffeeType.length,
              itemBuilder: ((context, index) {
                return CoffeeType(
                  coffeeType: coffeeType[index][0],
                  isSelected: coffeeType[index][1],
                  onTap: () {
                    coffeeTypesSelected(index);
                    if (coffeeType[index][1] &&
                        coffeeType[index][0] == "Latte") {
                      coffeeTileList = latte;
                    } else if (coffeeType[index][1] &&
                        coffeeType[index][0] == "Espresso") {
                      coffeeTileList = espresso;
                    } else if (coffeeType[index][1] &&
                        coffeeType[index][0] == "Cappucino") {
                      coffeeTileList = cappucino;
                    } else if (coffeeType[index][1] &&
                        coffeeType[index][0] == "Black") {
                      coffeeTileList = black;
                    }
                  },
                );
              }),
            ),
          ),

          // Horizantal listview of coffee tiles
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coffeeTileList.length,
              itemBuilder: ((context, index) {
                return CoffeeTile(
                  coffeImagePath: coffeeTileList[index][0],
                  coffeName: coffeeTileList[index][1],
                  coffeDescription: coffeeTileList[index][2],
                  coffePrice: coffeeTileList[index][3],
                  onAdd: () {
                    setState(() {
                      _cart.addProduct(Product(
                        id: coffeeTileList[index][1], // Assuming name is unique ID
                        name: coffeeTileList[index][1],
                        price: double.parse(coffeeTileList[index][3].replaceAll(' VND', '').replaceAll('.', '')),
                      ));
                    });
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
