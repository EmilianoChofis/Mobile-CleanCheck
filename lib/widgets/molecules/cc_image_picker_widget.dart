import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_clean_check/core/theme/color_schemes.dart';
import 'package:mobile_clean_check/core/theme/text_themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcImagePickerWidget extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final Function(bool) onImagesChanged;

  const CcImagePickerWidget({
    required this.label,
    required this.hint,
    required this.icon,
    required this.onImagesChanged,
    super.key,
  });

  @override
  State<CcImagePickerWidget> createState() => _CcImagePickerWidgetState();
}

class _CcImagePickerWidgetState extends State<CcImagePickerWidget> {
  final secondaryColor = ColorSchemes.secondary;
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];

  Future<void> _pickImage() async {
    if (_images.length < 5) {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        setState(() {
          _images.add(pickedImage);
        });
        widget.onImagesChanged(_images.isNotEmpty);
      }
    } else {
      CcSnackBarWidget.show(
        context,
        message: 'Solo puedes adjuntar 5 imágenes',
        snackBarType: SnackBarType.error,
      );
    }
  }

  void _showImageDialog(XFile image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.file(
              File(image.path),
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
          widget.label,
          style: TextThemes.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: secondaryColor),
                const SizedBox(width: 8.0),
                Text(widget.hint, style: TextStyle(color: secondaryColor)),
              ],
            ),
          ),
        ),
        if (_images.isNotEmpty) ...[
          const SizedBox(height: 32.0),
          SizedBox(
            height: 130.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _showImageDialog(_images[index]),
                        child: Image.file(
                          File(_images[index].path),
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 130.0,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () {
                            setState(() => _images.removeAt(index));
                            widget.onImagesChanged(_images.isNotEmpty);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
        const SizedBox(height: 16.0),
      ],
    );
  }
}
