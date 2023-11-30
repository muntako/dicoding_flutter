import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pahlawan_indonesia/components/loading_widget.dart';
import 'package:pahlawan_indonesia/models/pahlawan.dart';

class Detail extends StatelessWidget {
  final Pahlawan item;
  const Detail({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(item.nama!)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              CachedNetworkImage(
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
                height: size.height * .3,
                // width: 70.0,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 10),
              Text(
                item.kategori!,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
              const SizedBox(height: 10),
              Text(
                item.nama2!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
              const SizedBox(height: 10),
              Text(
                "Lahir pada ${item.lahir!}",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                item.history!,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "Wafat pada ${item.gugur!}",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              Text(
                "Dimakamkan di ${item.lokasimakam!}",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.left,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
