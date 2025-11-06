import 'package:e_commerce_app/shared/colors.dart';
import 'package:e_commerce_app/shared/appbar.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Map<String, dynamic> product;
  const Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ProductsAndPrice()],
        backgroundColor: appbarGreen,
        title: Text("Details screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.product['image']),
            SizedBox(height: 11),
            Text(
              widget.product['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            Text(
              "₪ ${widget.product['price']}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 4),
                Text("${widget.product['rating']['rate']}"),
                SizedBox(width: 8),
                Text("(${widget.product['rating']['count']} reviews)"),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Details : ",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.product['description'],
              style: TextStyle(fontSize: 18),
              maxLines: isShowMore ? 1 : null,
              overflow: TextOverflow.fade,
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  isShowMore = !isShowMore;
                });
              },
              child: Text(
                isShowMore ? "Show more" : "Show less",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
