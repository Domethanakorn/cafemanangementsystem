import 'package:cafa_management/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'api.dart';
import 'detail.dart';
import 'add_member.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool coffee = false, tea = false, milk = false, dessert = false;
  int _currentIndex = 0;

  // BottomNavigationBar
  final List<Widget> _pages = [
    HomePageContent(),
    Center(child: Text("Orders Page")),
    Center(child: Text("Member Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // แสดงเนื้อหาตาม Tab ปัจจุบัน
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // ตำแหน่ง Tab ปัจจุบัน
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Member",
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white, // สีพื้นหลังของ BottomNavigationBar
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Cafe Management System", style: AppWidget.HeadlineTextFildStyle()),
          Text("Discover and Get Great Coffee", style: AppWidget.LightTextFildStyle()),
          SizedBox(height: 15.0),
          ShowItem(),
          SizedBox(height: 20.0),
          // Wrap Test_Pokemon in Expanded to prevent layout overflow
          Expanded(

            child: Test_BeveragesAndDesserts(),
          ),
        ],
      ),
    );
  }
}

class ShowItem extends StatefulWidget {
  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends State<ShowItem> {
  bool coffee = false, tea = false, milk = false, dessert = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              coffee = true;
              tea = false;
              milk = false;
              dessert = false;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/coffee.jpg",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              coffee = false;
              tea = true;
              milk = false;
              dessert = false;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/tea.jpg",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              coffee = false;
              tea = false;
              milk = true;
              dessert = false;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/milk.jpg",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              coffee = false;
              tea = false;
              milk = false;
              dessert = true;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/dessert.jpg",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Test_BeveragesAndDesserts extends StatefulWidget {
  @override
  State<Test_BeveragesAndDesserts> createState() => _TestBeveragesAndDessertsState();
}

class _TestBeveragesAndDessertsState extends State<Test_BeveragesAndDesserts> {
  late Future<List<dynamic>> futureBeverages;
  late Future<List<dynamic>> futureDesserts;

  var listBeverages = [];
  var listDesserts = [];
  var _apiCalling = true;

  @override
  void initState() {
    super.initState();

    // เรียก API พร้อมกันสำหรับ Beverages และ Desserts
    futureBeverages = apiGetBeverages();
    futureDesserts = apiGetDesserts();

    Future.wait([futureBeverages, futureDesserts]).then((results) {
      listBeverages = results[0];
      listDesserts = results[1];
      setState(() => _apiCalling = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beverages & Desserts')),
      body: _apiCalling
          ? Center(child: CircularProgressIndicator()) // แสดง Loading
          : listBeverages.isEmpty && listDesserts.isEmpty
          ? Center(child: Text('No Data Available')) // ไม่มีข้อมูล
          : buildTabs(), // แสดงข้อมูลในรูปแบบ Tab
    );
  }

  Widget buildTabs() => DefaultTabController(
    length: 2,
    child: Column(
      children: [
        TabBar(
          tabs: const [
            Tab(text: 'Beverages'),
            Tab(text: 'Desserts'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              buildListView(listBeverages, 'Beverage'),
              buildListView(listDesserts, 'Dessert'),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildListView(List<dynamic> list, String category) => ListView.separated(
    itemBuilder: (ctx, index) => buildListTile(list, index, category),
    separatorBuilder: (ctx, index) =>
    const Divider(thickness: 1, color: Colors.indigo),
    itemCount: list.length,
  );

  Widget buildListTile(List<dynamic> list, int index, String category) => ListTile(
    contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        category == 'Beverage'
            ? list[index]['beveragePicture'] ?? '' // สำหรับเครื่องดื่ม
            : list[index]['dessertPicture'] ?? '', // สำหรับขนมหวาน
        fit: BoxFit.cover,
      ),
    ),
    title: Text(list[index]['name'] ?? 'Unknown'),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category: $category'),
        Text('Price: \$${list[index]['price'] ?? 0}'),
      ],
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      // ส่งข้อมูลทั้งหมดไปยังหน้า DetailPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            name: list[index]['name'],
            price: list[index]['price'],
            description: list[index]['description'] ?? 'No description available',
            imageUrl: list[index]['beveragePicture'] ?? list[index]['dessertPicture'] ?? 'https://via.placeholder.com/150',
            category: list[index]['category'],
          ),
        ),
      );
    },
  );

}