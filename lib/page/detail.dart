import 'package:flutter/material.dart';
import 'api.dart';

class DetailPage extends StatefulWidget {
  final int photoId;

  DetailPage({required this.photoId});

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  late Future<Map<String, dynamic>> photo;
  var _url = '';
  var _title = '';
  var _hitpoints = '';
  var _location = '';
  List _ability = [];
  List _evolution = [];
  var _apiCalling = true;
  int _quantity = 1; // จำนวนสินค้าเริ่มต้น

  @override
  void initState() {
    super.initState();
    photo = apiGetphoto(widget.photoId);
    photo.then((value) {
      setState(() {
        _url = value['image_url'];
        _title = value['pokemon'];
        _hitpoints = value['hitpoints'].toString();
        _location = value['location'];
        _ability = value['abilities'];
        _evolution = value['evolutions'];
        _apiCalling = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text('Pokemon Details'),
      backgroundColor: Colors.amber,
    ),
    body: _apiCalling
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display image
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                _url,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Content section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetailItem("Name", _title),
                buildDivider(),
                buildDetailItem("Hitpoints", _hitpoints),
                buildDivider(),
                buildDetailItem("Location", _location),
                buildDivider(),
                buildDetailItem("Abilities", _ability.join(", ")),
                buildDivider(),
                buildDetailItem("Evolutions", _evolution.join(", ")),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Quantity Selector
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 1) _quantity--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.amber),
                    ),
                    Text(
                      '$_quantity',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      icon: Icon(Icons.add, color: Colors.amber),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Add to Cart Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle Add to Cart logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Added $_quantity ${_title}s to cart!"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                "Add to Cart",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: Colors.amber,
      thickness: 1,
      height: 20,
    );
  }
}
