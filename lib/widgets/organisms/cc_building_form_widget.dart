import 'package:flutter/material.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcBuildingFormWidget extends StatefulWidget {
  final BuildingModel? building;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameBuildingController;
  final TextEditingController numberFloorsController;

  const CcBuildingFormWidget({
    this.building,
    required this.formKey,
    required this.nameBuildingController,
    required this.numberFloorsController,
    super.key,
  });

  @override
  State<CcBuildingFormWidget> createState() => _CcBuildingFormWidgetState();
}

class _CcBuildingFormWidgetState extends State<CcBuildingFormWidget> {
  double _sliderValue = 1.0;

  @override
  void initState() {
    super.initState();
    widget.numberFloorsController.addListener(_updateSliderFromTextField);

    if (widget.building != null) {
      widget.nameBuildingController.text = widget.building!.name;
    }
  }

  @override
  void dispose() {
    widget.numberFloorsController.removeListener(_updateSliderFromTextField);
    super.dispose();
  }

  void _updateSliderFromTextField() {
    final textValue = widget.numberFloorsController.text;
    final parsedValue = int.tryParse(textValue);

    if (parsedValue != null && parsedValue > 10) {
      setState(() => _sliderValue = 10.0);
    }

    if (parsedValue != null && parsedValue >= 1 && parsedValue <= 10) {
      setState(() {
        _sliderValue = parsedValue.toDouble();
      });
    }
  }

  void _updateTextFieldFromSlider(double value) {
    setState(() {
      _sliderValue = value;
      widget.numberFloorsController.text = value.toInt().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CcTextFormFieldWidget(
              label: 'Nombre del edificio',
              hint: 'Nombre del edificio',
              keyboardType: TextInputType.text,
              icon: const Icon(Icons.apartment_outlined),
              controller: widget.nameBuildingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingresa el nombre del edificio.';
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            Text(
              'Número de pisos nuevos',
              style: TextThemes.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider.adaptive(
              value: _sliderValue,
              min: 1,
              max: 10,
              divisions: 9,
              inactiveColor: ColorSchemes.disabled,
              label: _sliderValue.toInt().toString(),
              onChanged: _updateTextFieldFromSlider,
            ),
            CcTextFormFieldWidget(
              hint: 'Número de pisos',
              icon: const Icon(Icons.apartment_outlined),
              keyboardType: TextInputType.number,
              controller: widget.numberFloorsController,
              validator: (value) {
                final parsedValue = int.tryParse(value!);
                if (value.isEmpty || parsedValue! < 1) {
                  return 'Ingresa el número de pisos.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
