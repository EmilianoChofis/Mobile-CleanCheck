import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcAuthTemplate extends StatefulWidget {
  final Widget contentForm;

  const CcAuthTemplate({required this.contentForm, super.key});

  @override
  State<CcAuthTemplate> createState() => _CcAuthTemplateState();
}

class _CcAuthTemplateState extends State<CcAuthTemplate> {
  final primaryColor = ColorSchemes.primary;
  final surfaceColor = ColorSchemes.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            const CcLogoWidget(),
            const SizedBox(height: 32.0),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: widget.contentForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
