import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_tourist/model/client.dart';
import 'package:mini_tourist/model/create_member.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';

class RegisterMemberPage extends StatefulWidget {
  const RegisterMemberPage({super.key});

  @override
  State<RegisterMemberPage> createState() => _RegisterMemberPageState();
}

class _RegisterMemberPageState extends State<RegisterMemberPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _latController = TextEditingController();
  final _longController = TextEditingController();

  String? _selectedCity;
  String? _selectedCategory;
  String _membershipType = 'no';
  String? _isBeach;
  String? _belongsToBeach; // "Yes" o "No"
  ClientModel? _selectedBeach;  // valor de la playa seleccionada

  File? _frontImage;
  File? _backImage;

  bool _isLoading = false;

  final picker = ImagePicker();

  final _cities = [
    {'label': 'Zihuatanejo', 'value': 'Zihuatanejo'},
    {'label': 'Acapulco', 'value': 'Acapulco'},
    {'label': 'Morelia', 'value': 'Morelia'}
  ];

  final _categories = [
    {'label': 'Parques y atracciones', 'value': 'parks'},
    {'label': 'Gastronomía', 'value': 'restaurants'},
    {'label': 'Lugares y eventos', 'value': 'places_events'},
    {'label': 'Tiendas', 'value': 'stores'},
    {'label': 'Servicios', 'value': 'services'},
  ];

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      });
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _frontImage = null;
      _backImage = null;
      _selectedCity = null;
      _selectedCategory = null;
      _membershipType = 'no';
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_frontImage == null || _backImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor selecciona ambas imágenes')),
        );
        return;
      }

      final newMember = CreateMember(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        cardName: _nameController.text.trim(),
        city: _selectedCity!,
        place: _isBeach!,
        belongsToBeach: _belongsToBeach,
        beachCardName: _selectedBeach?.cardName,
        category: _selectedCategory!,
        isPremium: _membershipType == 'yes' ? 'Yes' : 'No',
        image: _frontImage,
        backImage: _backImage,
        lat: _latController.text.trim(),
        long: _longController.text.trim()
      );

      print(newMember);

      try {
        setState(() => _isLoading = true); // ✅ Comienza la carga

        final clientViewModel =
            Provider.of<ClientViewModel>(context, listen: false);
        await clientViewModel.registerNewMember(newMember);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Miembro registrado con éxito')),
        );

        _resetForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar: $e')),
        );
      } finally {
        setState(() => _isLoading = false); // ✅ Finaliza la carga
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardViewModel = Provider.of<CardViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniTourist'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person_add, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        'Registrar socio',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                      'Email', _emailController, TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  _buildInputField('Contraseña', _passwordController,
                      TextInputType.visiblePassword,
                      obscure: true),
                  const SizedBox(height: 16),
                  _buildInputField(
                      'Nombre completo', _nameController, TextInputType.name),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: 'Ciudad',
                    value: _selectedCity,
                    items: _cities,
                    onChanged: (val) => setState(() => _selectedCity = val),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _isBeach,
                    items: const [
                      DropdownMenuItem(value: 'Yes', child: Text('Sí')),
                      DropdownMenuItem(value: 'No', child: Text('No')),
                    ],
                    onChanged: (val) async {
                      setState(() {
                        _isBeach = val;
                        //print('Is beach: ' + _isBeach.toString());
                      });
                    },
                    decoration: InputDecoration(
                      labelText: '¿Es una playa?',
                      prefixIcon: const Icon(Icons.beach_access),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (val) => val == null ? 'Seleccione una opción' : null,
                  ),
                  if (_isBeach == 'No') ...[
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _belongsToBeach,
                      items: const [
                        DropdownMenuItem(value: 'Yes', child: Text('Sí')),
                        DropdownMenuItem(value: 'No', child: Text('No')),
                      ],
                      onChanged: (val) async {
                        setState(() {
                          _belongsToBeach = val;
                          _selectedBeach = null; // reset al cambiar
                        });
                        if (val == 'Yes') {
                          await cardViewModel.getAllBeaches(); // cargar opciones de la API
                        }
                      },
                      decoration: InputDecoration(
                        labelText: '¿Pertenece a una playa?',
                        prefixIcon: const Icon(Icons.beach_access),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      ),
                      validator: (val) => val == null ? 'Seleccione una opción' : null,
                    ),
                  ],
                  if (_belongsToBeach == 'Yes' && _isBeach == 'No') ...[
                    const SizedBox(height: 16),
                    DropdownButton<ClientModel>(
                      hint: const Text("Selecciona una playa"),
                      value: _selectedBeach,
                      items: cardViewModel.beaches.map((beach) {
                        return DropdownMenuItem(
                          value: beach,
                          child: Text(beach.cardName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBeach = value;
                        });

                        if (value != null) {
                          print("ID de la playa seleccionada: ${value.cardId}");
                          print("Nombre de la playa seleccionada: ${value.cardName}");
                        }
                      },
                    )
                  ],
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: 'Categoría',
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: (val) => setState(() => _selectedCategory = val),
                  ),
                  const SizedBox(height: 24),
                  const Text('¿Es miembro premium?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Sí'),
                          value: 'yes',
                          groupValue: _membershipType,
                          onChanged: (val) =>
                              setState(() => _membershipType = val!),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text('No'),
                          value: 'no',
                          groupValue: _membershipType,
                          onChanged: (val) =>
                              setState(() => _membershipType = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Imagen frontal',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildImagePicker(() => _pickImage(true), _frontImage),
                  const SizedBox(height: 16),
                  const Text('Imagen trasera',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildImagePicker(() => _pickImage(false), _backImage),
                  const SizedBox(height: 30),
                  _buildInputField(
                      'Latitud', _latController, TextInputType.name),
                  _buildInputField(
                      'Longitud', _longController, TextInputType.name),
                  Center(
                    child: ElevatedButton.icon(
                      icon: _isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.check_circle_outline),
                      label: Text(_isLoading ? 'Registrando...' : 'Registrar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _isLoading
                          ? null
                          : _submitForm, // ✅ Deshabilitado si cargando
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, TextInputType inputType,
      {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscure,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Ingrese $label';
        if (label == 'Contraseña' && value.length < 6)
          return 'Mínimo 6 caracteres';
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: label == 'Email'
            ? const Icon(Icons.email_outlined)
            : label == 'Contraseña'
                ? const Icon(Icons.lock_outline)
                : const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<Map<String, String>> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item['value'],
                child: Text(item['label'] ?? item['value']!),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.arrow_drop_down_circle_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      validator: (val) => val == null ? 'Seleccione $label' : null,
    );
  }

  Widget _buildImagePicker(VoidCallback onPressed, File? imageFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.photo_library),
          label: const Text('Seleccionar imagen'),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        if (imageFile != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              imageFile,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}
