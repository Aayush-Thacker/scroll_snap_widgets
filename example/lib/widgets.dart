import 'package:example/data.dart';
import 'package:flutter/material.dart';

//a simple widget to display an item
class SimpleItemCard extends StatelessWidget {
  final double? height;
  final double? widgth;
  final ItemDataModel item;
  const SimpleItemCard(
      {super.key, this.height, this.widgth, required this.item});

  @override
  Widget build(BuildContext context) {
    //variable size card
    return SizedBox(
      width: widgth,
      height: height,
      child: Card(
        color: Colors.redAccent,
        //image can not go out of the card (for rounded corner image)
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //image takes and fill the remaining space
            Expanded(
              child: Image.asset(
                item.image,
                fit: BoxFit.fill,
              ),
            ),
            //text with small padding
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
