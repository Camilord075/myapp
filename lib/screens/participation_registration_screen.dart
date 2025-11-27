import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParticipationRegistrationScreen extends StatefulWidget {
  const ParticipationRegistrationScreen({super.key});

  @override
  State<ParticipationRegistrationScreen> createState() => _ParticipationRegistrationScreenState();
}

class _ParticipationRegistrationScreenState extends State<ParticipationRegistrationScreen> {
  String _userName = 'Cargando...';
  String? _selectedParcelId;
  String? _selectedParcelName;
  Map<String, dynamic>? _selectedParcelDetails;
  String? _selectedTask;
  final _activityDescriptionController = TextEditingController();
  bool _isLoading = false;

  final List<String> _tasks = [
    'Siembra',
    'Riego',
    'Poda',
    'Limpieza',
    'Cosecha',
    'Fertilización',
    'Control de plagas',
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  @override
  void dispose() {
    _activityDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.displayName != null && user.displayName!.isNotEmpty) {
        setState(() {
          _userName = user.displayName!;
        });
      } else {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _userName = userDoc.get('fullName') ?? 'Usuario';
          });
        } else {
          setState(() {
            _userName = 'Usuario';
          });
        }
      }
    }
  }

  Future<void> _showParcelSelectionSheet() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Debes iniciar sesión para seleccionar una parcela.')),
        );
      }
      return;
    }

    final selectedId = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('parcels')
              .where('userId', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No hay parcelas registradas.'));
            }

            final parcels = snapshot.data!.docs;

            return ListView.builder(
              itemCount: parcels.length,
              itemBuilder: (context, index) {
                final parcel = parcels[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(parcel['name']),
                  subtitle: Text('Tamaño: ${parcel['size']} - Cultivos: ${parcel['crops']}'),
                  onTap: () {
                    Navigator.pop(context, parcels[index].id);
                  },
                );
              },
            );
          },
        );
      },
    );

    if (selectedId != null) {
      final selectedDoc = await FirebaseFirestore.instance.collection('parcels').doc(selectedId).get();
      setState(() {
        _selectedParcelId = selectedId;
        _selectedParcelName = selectedDoc['name'];
        _selectedParcelDetails = selectedDoc.data();
      });
    }
  }

  Future<void> _registerParticipation() async {
    if (_selectedParcelId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona una parcela.')),
      );
      return;
    }
    if (_selectedTask == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona una tarea.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Debes iniciar sesión para registrar participación.')),
        );
        context.go('/');
      }
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('participations').add({
        'userId': user.uid,
        'userName': _userName,
        'parcelId': _selectedParcelId,
        'parcelName': _selectedParcelName,
        'task': _selectedTask,
        'description': _activityDescriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Participación registrada exitosamente!')),
        );
        // Clear form fields, but keep selected parcel
        setState(() {
          _selectedTask = null;
          _activityDescriptionController.clear();
        });
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar participación: ${e.message}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ocurrió un error inesperado: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Usuario no autenticado.'));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/dashboard');
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
                image: DecorationImage(
                    image: AssetImage('lib/assets/logo_asset.png'),
                    fit: BoxFit.cover
                )
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
                  _userName,
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
            GestureDetector(
              onTap: _showParcelSelectionSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(
                    Theme.of(context).inputDecorationTheme.border?.borderRadius is BorderRadius
                        ? (Theme.of(context).inputDecorationTheme.border as OutlineInputBorder).borderRadius.resolve(TextDirection.ltr).topRight.y
                        : 8.0,
                  ),
                  border: Border.all(
                    color: Theme.of(context).inputDecorationTheme.border?.borderSide.color ?? Colors.grey,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedParcelName ?? 'Selecciona una parcela',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_selectedParcelDetails != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedParcelDetails!['name'] ?? 'N/A',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tamaño: ${_selectedParcelDetails!['size'] ?? 'N/A'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Cultivos: ${_selectedParcelDetails!['crops'] ?? 'N/A'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _selectedParcelDetails!['status'] ?? 'N/A',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: _selectedParcelDetails!['status'] == 'Disponible' ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            if (_selectedParcelId != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Participantes inscritos',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('participations')
                        .where('parcelId', isEqualTo: _selectedParcelId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No hay participantes inscritos en esta parcela.');
                      }

                      final participants = snapshot.data!.docs;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: participants.map((doc) {
                          final participation = doc.data() as Map<String, dynamic>;
                          return Text(
                            '${participation['userName']} - ${participation['task']}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            Text(
              'Tareas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: _tasks.map((task) {
                return RadioListTile<String>(
                  title: Text(task),
                  value: task,
                  groupValue: _selectedTask,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTask = value;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Descripción (opcional)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _activityDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Detalles de la actividad...',
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _registerParticipation,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Registrar Participación'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on InputBorder? {
  get borderRadius => null;
}
