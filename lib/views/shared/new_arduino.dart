import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewArduino extends StatelessWidget {
  const NewArduino({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.8,
                offset: Offset(0, 1))
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.28,
        child: CachedNetworkImage(imageUrl: imageUrl));
  }
}
