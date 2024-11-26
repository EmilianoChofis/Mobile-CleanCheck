import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/theme/themes.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcRoomFormWidget extends StatefulWidget {
  final RoomModel? room;
  final bool? quickAccess;
  final GlobalKey<FormState> formKey;
  final TextEditingController? buildingController;
  final TextEditingController floorController;
  final TextEditingController numberRoomsController;

  const CcRoomFormWidget({
    this.room,
    this.quickAccess = false,
    required this.formKey,
    required this.buildingController,
    required this.floorController,
    required this.numberRoomsController,
    super.key,
  });

  @override
  State<CcRoomFormWidget> createState() => _CcRoomFormWidgetState();
}

class _CcRoomFormWidgetState extends State<CcRoomFormWidget> {
  double _sliderValue = 1.0;

  @override
  void initState() {
    super.initState();
    widget.numberRoomsController.addListener(_updateSliderFromTextField);
  }

  @override
  void dispose() {
    super.dispose();
    widget.numberRoomsController.removeListener(_updateSliderFromTextField);
  }

  void _updateSliderFromTextField() {
    final textValue = widget.numberRoomsController.text;
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
      widget.numberRoomsController.text = value.toInt().toString();
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
            if (widget.quickAccess!) ...[
              CcDropDownWidget(
                label: 'Edificio',
                hint: 'Selecciona un edificio',
                icon: const Icon(Icons.apartment),
                controller: widget.buildingController!,
                items: const [],
              ),
              const SizedBox(height: 32.0),
            ],
            _buildFloorDropDown(),
            const SizedBox(height: 32.0),
            Text(
              'Número de habitaciones',
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
              hint: 'Número de habitaciones',
              keyboardType: TextInputType.number,
              icon: const Icon(Icons.bed_outlined),
              controller: widget.numberRoomsController,
              validator: (value) {
                final parsedValue = int.tryParse(value!);
                if (value.isEmpty || parsedValue! < 1) {
                  return 'Ingresa el número de habitaciones.';
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

  Widget _buildFloorDropDown() {
    return BlocBuilder<FloorCubit, FloorState>(
      builder: (context, state) {
        if (state is FloorInitial) {
          return const CircularProgressIndicator();
        }
        if (state is FloorLoaded) {
          return CcDropDownWidget(
            label: 'Piso',
            hint: 'Selecciona un piso',
            icon: const Icon(Icons.apartment),
            controller: widget.floorController,
            items: state.floors.map((floor) {
              return DropdownMenuItem<String>(
                value: floor.id,
                child: Text(floor.name),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return 'Selecciona un piso.';
              }
              return null;
            },
          );
        } else {
          return const Text('Error al cargar los pisos.');
        }
      },
    );
  }
}
