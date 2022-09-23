import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:lentera_ilmu/services/utils.dart';

class ListItemLibrary extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnail;
  final String type;
  // ignore: non_constant_identifier_names
  final String? valid_until;
  const ListItemLibrary({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
    required this.thumbnail,
    // ignore: non_constant_identifier_names
    this.valid_until,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      // margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(4),
            // margin: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2.0,
                    offset: Offset(0.0, 0.75))
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                          image: NetworkImage(thumbnail),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: Image.network(
                      //     "https://i.ytimg.com/vi/f_SKYBeoYjs/maxresdefault.jpg"),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                      width: MediaQuery.of(context).size.width * 0.58,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            maxFontSize: 14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Padding(padding: EdgeInsets.all(1)),
                          AutoSizeText(
                            description,
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
                          const Padding(padding: EdgeInsets.all(2)),
                          if (type == "subscription")
                            AutoSizeText(
                              "Hingga $valid_until",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.teal,
                              ),
                              maxFontSize: 12,
                            ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.play_arrow,
                      size: 38,
                      color: Colors.teal,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
