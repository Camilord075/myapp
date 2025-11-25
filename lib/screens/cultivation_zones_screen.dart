import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CultivationZonesScreen extends StatelessWidget {
  const CultivationZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Dummy data for cultivation zones
    final List<Map<String, String>> zones = [
      {
        'name': 'La Esperanza',
        'size': '1 ha (1000 m²)',
        'crops': 'Hortalizas y vegetales',
        'details': 'Tomate',
        'status': 'Disponible',
      },
      {
        'name': 'El Trigal',
        'size': '5 ha (5000 m²)',
        'crops': 'Cereales',
        'details': 'Trigo',
        'status': 'Disponible',
      },
      {
        'name': 'El Maizal',
        'size': '2 ha (2000 m²)',
        'crops': 'Granos básicos',
        'details': 'Maíz, Frijol',
        'status': 'Ocupado',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Explicit back button
          onPressed: () {
            context.go('/dashboard'); // Navigate back to dashboard
          },
        ),
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Zonas de cultivo',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: zones.length,
              itemBuilder: (context, index) {
                final zone = zones[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          zone['name']!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tamaño: ${zone['size']}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Hortalizas y vegetales: ${zone['crops']}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          zone['details']!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            zone['status']!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: zone['status'] == 'Disponible' ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/plot-registration');
        },
        backgroundColor: colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
