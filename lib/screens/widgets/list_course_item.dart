import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lentera_ilmu/services/utils.dart';

class ListCourseItem extends StatelessWidget {
  const ListCourseItem({
    Key? key,
    required this.image,
    this.title = '',
    this.descriptions = '',
    this.mentor = '-',
    this.price = '0',
    this.showPrice = true,
  }) : super(key: key);

  final String image;
  final String title;
  final String descriptions;
  final String mentor;
  final String price;
  final bool showPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(4),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width * 0.58,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          mentor,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Colors.purple,
                          ),
                          minFontSize: 11,
                          maxFontSize: 12,
                        ),
                        AutoSizeText(
                          title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxFontSize: 15,
                          minFontSize: 13,
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
                          minFontSize: 11,
                          maxFontSize: 13,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        showPrice == true
                            ? Column(
                                children: [
                                  const Padding(padding: EdgeInsets.all(2)),
                                  AutoSizeText(
                                    double.parse(price) == 0
                                        ? "GRATIS"
                                        : formatCurrency.format(
                                            double.parse(price),
                                          ),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.teal,
                                    ),
                                    maxFontSize: 13,
                                    minFontSize: 11,
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.play_arrow,
            size: 38,
            color: Colors.teal,
          )
        ],
      ),
    );
  }
}
