import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({Key key, this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.network(
        image ?? '',
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            Icons.broken_image,
          ),
        ),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
    );
  }
}
