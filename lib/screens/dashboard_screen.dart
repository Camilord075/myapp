import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                  'Francisco Pepe',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              context.go('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            _buildDashboardCard(
              context,
              title: 'Zonas de cultivo',
              description:
                  'Visualiza y explora las distintas parcelas del huerto, con información sobre los cultivos actuales, responsables y estado actual.',
              imageAsset: 'assets/images/placeholder.png', // Placeholder image
              onTap: () {
                context.go('/cultivation-zones');
              },
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'Mi Participación',
              description:
                  'Consulta tu historial de actividades en el huerto, el tiempo dedicado y tareas realizadas.',
              imageAsset: 'assets/images/placeholder.png', // Placeholder image
              onTap: () {
                context.go('/participation-registration'); // Navigate to ParticipationRegistrationScreen
              },
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'Educación',
              description:
                  'Sección educativa para promover prácticas sostenibles y conocimientos básicos sobre agricultura urbana.',
              imageAsset: 'assets/images/placeholder.png', // Placeholder image
              onTap: () {
                // TODO: Implement navigation to Education screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, {
    required String title,
    required String description,
    required String imageAsset,
    required VoidCallback onTap,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Placeholder for image
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('Imagen')), // Placeholder text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
