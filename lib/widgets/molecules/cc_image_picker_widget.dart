import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';

class CcImagePickerWidget extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final Function(bool) onImagesChanged;
  final List<String> base64Images;
  final Function(List<String>) onImagesUpdated;

  const CcImagePickerWidget({
    required this.label,
    required this.hint,
    required this.icon,
    required this.onImagesChanged,
    required this.base64Images,
    required this.onImagesUpdated,
    super.key,
  });

  @override
  State<CcImagePickerWidget> createState() => _CcImagePickerWidgetState();
}

class _CcImagePickerWidgetState extends State<CcImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      final base64String = base64Encode(bytes);

      final base64WithHeader = 'data:image/jpeg;base64,$base64String';

      setState(() => widget.base64Images.add(base64WithHeader));

      widget.onImagesUpdated(widget.base64Images);
      widget.onImagesChanged(widget.base64Images.isNotEmpty);
    }
  }

  void _showImageDialog(String base64Image) {
    final bytes = base64Decode(base64Image);
    final image = Image.memory(bytes);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: image,
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
        Text(widget.label),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: ColorSchemes.secondary),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: ColorSchemes.secondary),
                const SizedBox(width: 8.0),
                Text(
                  widget.hint,
                  style: const TextStyle(color: ColorSchemes.secondary),
                ),
              ],
            ),
          ),
        ),
        if (widget.base64Images.isNotEmpty) ...[
          const SizedBox(height: 32.0),
          SizedBox(
            height: 130.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.base64Images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            _showImageDialog(widget.base64Images[index]),
                        child: Image.memory(
                          base64Decode(widget.base64Images[index]
                              .replaceFirst('data:image/jpeg;base64,', '')),
                          fit: BoxFit.cover,
                          width: 120.0,
                          height: 120.0,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.base64Images.removeAt(index);
                              widget.onImagesUpdated(widget.base64Images);
                              widget.onImagesChanged(
                                  widget.base64Images.isNotEmpty);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
