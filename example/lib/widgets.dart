import 'package:example/data.dart';
import 'package:flutter/material.dart';

class SimpleItemCard extends StatelessWidget {
  final double? height;
  final double? widgth;
  final ItemDataModel item;
  const SimpleItemCard(
      {super.key, this.height, this.widgth, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widgth,
      height: height,
      child: Card(
        color: Colors.redAccent,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                item.image,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
