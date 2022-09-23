import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ListItemCart extends StatelessWidget {
  const ListItemCart({
    Key? key,
    required this.image,
    this.title = '',
    this.descriptions = '',
    this.source = '-',
    this.type = '-',
    this.appType = '-',
    this.price = '0',
    this.onDelete,
  }) : super(key: key);

  final String image;
  final String title;
  final String descriptions;
  final String source;
  final String type;
  final String price;
  final String appType;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(8),
      // margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26, blurRadius: 2.0, offset: Offset(0.0, 0.75))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.width * 0.22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: Image.network(
                //     "https://i.ytimg.com/vi/f_SKYBeoYjs/maxresdefault.jpg"),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                      maxFontSize: 14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(
                      descriptions,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                      maxFontSize: 12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    AutoSizeText(
                      price,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.teal,
                      ),
                      maxFontSize: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 18),
            child: GestureDetector(
              onTap: () => {onDelete!()},
              child: const Icon(
                Icons.delete,
                size: 24,
                color: Colors.grey,
              ),
            ),
          ),
          // GestureDetector(
          //   // onTap: () => {print("dskjdksl"), onDelete},

          // )
        ],
      ),
    );
  }
}
