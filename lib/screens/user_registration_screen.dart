import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({super.key});

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
                  'Registro usuario',
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
              'Nombres y apellidos',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nombre completo',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Correo electrónico',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'correo@ejemplo.com',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Teléfono',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Ej. 1234-5678',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Zona de residencia o cercanía',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Ej. San Salvador',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Contraseña',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '********',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Confirmación contraseña',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '********',
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement user registration logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuario registrado exitosamente!')),
                  );
                  context.pop(); // Go back to previous screen or navigate to login
                },
                child: const Text('Registrarse'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
