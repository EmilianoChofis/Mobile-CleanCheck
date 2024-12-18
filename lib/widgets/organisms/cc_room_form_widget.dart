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
  final TextEditingController? buildingsController;
  final TextEditingController floorsController;
  final TextEditingController roomsController;

  const CcRoomFormWidget({
    this.room,
    this.quickAccess = false,
    required this.formKey,
    required this.buildingsController,
    required this.floorsController,
    required this.roomsController,
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
    widget.roomsController.addListener(_updateSliderFromTextField);
  }

  @override
  void dispose() {
    super.dispose();
    widget.roomsController.removeListener(_updateSliderFromTextField);
  }

  void _updateSliderFromTextField() {
    final textValue = widget.roomsController.text;
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
      widget.roomsController.text = value.toInt().toString();
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
              _buildBuildingsDropDown(),
              const SizedBox(height: 32.0),
            ],
            _buildFloorsDropDown(),
            const SizedBox(height: 32.0),
            Text(
              'Número de habitaciones nuevas',
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
              controller: widget.roomsController,
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

  Widget _buildBuildingsDropDown() {
    return BlocBuilder<BuildingCubit, BuildingState>(
      builder: (context, state) {
        if (state is BuildingLoaded) {
          return CcDropDownWidget(
            label: 'Edificio',
            hint: 'Selecciona un edificio',
            icon: const Icon(Icons.apartment),
            controller: widget.buildingsController!,
            items: state.buildings.map((building) {
              return DropdownMenuItem<String>(
                value: building.id,
                child: Text(building.name),
              );
            }).toList(),
            onChanged: (selectedBuildingId) {
              if (selectedBuildingId != null) {
                context
                    .read<FloorCubit>()
                    .getFloorsByBuildingId(selectedBuildingId);
              }
              widget.buildingsController!.text = selectedBuildingId ?? '';
            },
            validator: (value) {
              if (value == null) {
                return 'Selecciona un edificio.';
              }
              return null;
            },
          );
        } else {
          return const Text('Error al cargar los edificios.');
        }
      },
    );
  }

  Widget _buildFloorsDropDown() {
    return BlocBuilder<FloorCubit, FloorState>(
      builder: (context, state) {
        if (state is FloorLoading) {
          return const CircularProgressIndicator();
        }
        if (state is FloorLoaded) {
          return CcDropDownWidget(
            label: 'Piso',
            hint: 'Selecciona un piso',
            icon: const Icon(Icons.apartment),
            controller: widget.floorsController,
            items: state.floors.map((floor) {
              return DropdownMenuItem<String>(
                value: floor.id,
                child: Text(floor.name),
              );
            }).toList(),
            onChanged: (selectedFloorId) {
              if (selectedFloorId != null) {
                setState(() => widget.floorsController.text = selectedFloorId);
              }
            },

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Selecciona un piso.';
              }
              return null;
            },
          );
        } else {
          return _buildFinalDropDown([]);
        }
      },
    );
  }

  Widget _buildFinalDropDown(List<DropdownMenuItem<String>> items) {
    return CcDropDownWidget(
      label: 'Piso',
      hint: 'Selecciona un piso',
      icon: const Icon(Icons.apartment),
      controller: widget.floorsController,
      items: items,
      validator: (value) {
        if (value == null) {
          return 'Selecciona un piso.';
        }
        return null;
      },
    );
  }
}
