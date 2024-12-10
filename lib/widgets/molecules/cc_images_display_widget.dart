import 'package:flutter/material.dart';

class CcImagesDisplayWidget extends StatefulWidget {
  final String title;
  final List<String> images;

  const CcImagesDisplayWidget({
    required this.title,
    required this.images,
    super.key,
  });

  @override
  State<CcImagesDisplayWidget> createState() => _CcImagesDisplayWidgetState();
}

class _CcImagesDisplayWidgetState extends State<CcImagesDisplayWidget> {
  void _showImageDialog(String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 130.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => _showImageDialog(widget.images[index]),
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 130.0,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Container(
                          width: 100.0,
                          height: 130.0,
                          color: Colors.grey,
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
