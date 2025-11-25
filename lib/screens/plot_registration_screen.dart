import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PlotRegistrationScreen extends StatefulWidget {
  const PlotRegistrationScreen({super.key});

  @override
  State<PlotRegistrationScreen> createState() => _PlotRegistrationScreenState();
}

class _PlotRegistrationScreenState extends State<PlotRegistrationScreen> {
  String? _selectedCategory;
  String? _selectedCropType;
  String? _selectedStatus;

  final List<String> _categories = [
    'Hortalizas y vegetales',
    'Cereales',
    'Frutales',
    'Leguminosas',
  ];

  final List<String> _cropTypes = [
    'Tomate',
    'Lechuga',
    'Maíz',
    'Trigo',
    'Manzana',
    'Frijol',
  ];

  final List<String> _statuses = [
    'Activo',
    'Inactivo',
    'En preparación',
    'Cosechado',
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'Logo',
                  style: GoogleFonts.oswald(
                    color: colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Huertix',
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Registro de parcela',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nombre de la parcela',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tamaño en hectáreas',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ej. 1.5',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Categoría',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Seleccione una categoría',
              ),
              value: _selectedCategory,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Tipo de cultivo',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Seleccione un tipo de cultivo',
              ),
              value: _selectedCropType,
              items: _cropTypes.map((String cropType) {
                return DropdownMenuItem<String>(
                  value: cropType,
                  child: Text(cropType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCropType = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Estado actual',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Seleccione un estado',
              ),
              value: _selectedStatus,
              items: _statuses.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement plot registration logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Parcela registrada exitosamente!')),
                  );
                  context.pop(); // Go back to previous screen
                },
                child: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
