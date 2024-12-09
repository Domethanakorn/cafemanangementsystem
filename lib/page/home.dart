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
          Text("Hello Wannasa", style: AppWidget.boldTextFildStyle()),
          SizedBox(height: 18.0),
          Text("Cafe Management System", style: AppWidget.HeadlineTextFildStyle()),
          Text("Discover and Get Great Coffee", style: AppWidget.LightTextFildStyle()),
          SizedBox(height: 15.0),
          ShowItem(),
          SizedBox(height: 20.0),
          // Wrap Test_Pokemon in Expanded to prevent layout overflow
          Expanded(

            child: Test_Pokemon(),
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

class Test_Pokemon extends StatefulWidget {
  @override
  State<Test_Pokemon> createState() => _TestPokemonState();
}

class _TestPokemonState extends State<Test_Pokemon> {
  late Future<List<dynamic>> futurePhotos;

  var listPhotos = [];
  var _apiCalling = true;
  @override
  void initState() {
    super.initState();
    futurePhotos = apiGetPhotos();

    futurePhotos.then((value) {
      for (var p in value) {
        listPhotos.add(p);
      }
      setState(() => _apiCalling = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _apiCalling
          ? Center(child: CircularProgressIndicator()) // แสดง Loading
          : listPhotos.isEmpty
          ? Center(child: Text('No Data Available')) // กรณีไม่มีข้อมูล
          : buildListView(), // แสดง ListView เมื่อข้อมูลพร้อม
    );
  }

  Widget buildListView() => ListView.separated(
    itemBuilder: (ctx, index) => buildListTile(index),
    separatorBuilder: (ctx, index) =>
    const Divider(thickness: 1, color: Colors.indigo),
    itemCount: listPhotos.length,
  );

  Widget buildListTile(int index) => ListTile(
    contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(listPhotos[index]['image_url'] ?? ''),
    ),
    title: Text(listPhotos[index]['pokemon'] ?? 'Unknown'),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(photoId: listPhotos[index]['id']),
        ),
      );
    },
  );
}
