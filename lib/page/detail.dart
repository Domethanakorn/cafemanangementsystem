import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class DetailPage extends StatelessWidget {
  final String name;
  final int price;
  final String description;
  final String imageUrl;
  final String category;

  // รับข้อมูลที่ส่งมาจากหน้า Home
  const DetailPage({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            Text(
              "Name: $name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Price: \$${price.toString()}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              "Category: $category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              "Description: $description",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
             // แสดงภาพจากข้อมูลที่ส่งมา
          ],
        ),
      ),
    );
  }
}


