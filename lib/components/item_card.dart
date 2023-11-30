import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pahlawan_indonesia/components/loading_widget.dart';
import 'package:pahlawan_indonesia/models/pahlawan.dart';
import 'package:pahlawan_indonesia/screens/detail.dart';

class ItemCard extends StatelessWidget {
  // final AtomItem item;
  final Pahlawan item;
  final Size size;
  const ItemCard({
    Key? key,
    required this.item,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Detail(
                  item: item,
                );
              },
            ),
          );
        },
        child: Container(
          margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 5),
          width: size.width,
          height: size.height,
          padding:
              const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 2)
            ],
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double innerHeight = constraints.maxHeight;
              double innerWidth = constraints.maxWidth;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: innerHeight * .60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: item.img!,
                      placeholder: (context, url) => SizedBox(
                        height: size.height,
                        child: const LoadingWidget(
                          isImage: true,
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.network(
                        'https://via.placeholder.com/100x180?text=Photo',
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                      height: innerWidth * .60,
                      // width: 70.0,
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(height: innerHeight * .02),
                  Text(
                    item.nama!,
                    style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(height: innerHeight * .02),
                  Text(
                    "Lahir pada ${item.lahir!}",
                    style: const TextStyle(fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: innerHeight * .02),
                  Text(
                    item.kategori!,
                    style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
