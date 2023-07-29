import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';

class PickedNetworkImagesWidget extends StatelessWidget {
  final String url;
  final Function() onTap;

  const PickedNetworkImagesWidget({Key? key, required this.url, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          // color: primaryColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: 5,
            right: 2,
            child: InkWell(
              onTap: onTap,
              child: const CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 12,
                child: Icon(
                  Icons.close,
                  color: white,
                  size: 20,
                ),
              ),
            ))
      ],
    );
  }
}
