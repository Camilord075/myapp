import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ParticipationRegistrationScreen extends StatefulWidget {
  const ParticipationRegistrationScreen({super.key});

  @override
  State<ParticipationRegistrationScreen> createState() => _ParticipationRegistrationScreenState();
}

class _ParticipationRegistrationScreenState extends State<ParticipationRegistrationScreen> {
  String? _selectedTask;

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
                  'Registro de participación',
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
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'La Esperanza',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tamaño: 1 ha (1000 m²)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Hortalizas y vegetales: Tomate',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Disponible',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Participantes inscritos',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Juan Perez - Limpieza',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Ricardo Ortiz - Riego',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Tareas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Siembra'),
                  value: 'Siembra',
                  groupValue: _selectedTask,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTask = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Riego'),
                  value: 'Riego',
                  groupValue: _selectedTask,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTask = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Poda'),
                  value: 'Poda',
                  groupValue: _selectedTask,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTask = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Limpieza'),
                  value: 'Limpieza',
                  groupValue: _selectedTask,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTask = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement participation registration logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Participación registrada exitosamente!')),
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
