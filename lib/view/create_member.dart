import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';

class RegisterMemberPage extends StatefulWidget {
  const RegisterMemberPage({super.key});

  @override
  State<RegisterMemberPage> createState() => _RegisterMemberPageState();
}

class _RegisterMemberPageState extends State<RegisterMemberPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String? _selectedCity;
  String? _selectedCategory;
  String _membershipType = 'no';

  File? _frontImage;
  File? _backImage;

  //final picker = ImagePicker();

  /*Future<void> _pickImage(bool isFront) async {
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
  }*/

  final List<String> _cities = ['Guerrero', 'Jalisco', 'Oaxaca'];
  final List<String> _categories = ['Hotel', 'Restaurante', 'Turismo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniTourist'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Registrar nuevo miembro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Ingrese un email válido' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                validator: (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _selectedCity,
                items: _cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                onChanged: (value) => setState(() => _selectedCity = value),
                decoration: const InputDecoration(labelText: 'Ciudad'),
                validator: (value) => value == null ? 'Seleccione una ciudad' : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (value) => value == null ? 'Seleccione una categoría' : null,
              ),
              const SizedBox(height: 16),

              const Text('¿Es miembro premium?'),
              RadioListTile(
                title: const Text('Sí'),
                value: 'yes',
                groupValue: _membershipType,
                onChanged: (value) => setState(() => _membershipType = value!),
              ),
              RadioListTile(
                title: const Text('No'),
                value: 'no',
                groupValue: _membershipType,
                onChanged: (value) => setState(() => _membershipType = value!),
              ),
              const SizedBox(height: 16),

              const Text('Imagen frontal'),
              ElevatedButton(
                onPressed: () => ()/*_pickImage(true)*/,
                child: const Text('Seleccionar desde galería'),
              ),
              if (_frontImage != null) Image.file(_frontImage!, height: 100),
              const SizedBox(height: 12),

              const Text('Imagen trasera'),
              ElevatedButton(
                onPressed: () => () /*_pickImage(false)*/,
                child: const Text('Seleccionar desde galería'),
              ),
              if (_backImage != null) Image.file(_backImage!, height: 100),

              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Lógica de registro aquí
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Formulario válido. Registrando...')),
                      );
                    }
                  },
                  child: const Text('Registrar', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
} 