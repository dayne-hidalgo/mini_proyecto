import 'package:flutter/material.dart';
import 'package:lesson_extra_persistence/db/db_provider.dart';
import 'package:lesson_extra_persistence/utils/colors.dart';
import 'package:lesson_extra_persistence/utils/mydrawal.dart';

class EditContactScreen extends StatefulWidget {
  final int contactId;

  EditContactScreen({required this.contactId});

  @override
  _EditContactScreenState createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final dbHelper = DatabaseHelper.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContact();
  }

  _loadContact() async {
    Map<String, dynamic>? contact = await dbHelper.queryContact(widget.contactId);
    if (contact != null) {
      _firstNameController.text = contact['name'];
      _lastNameController.text = contact['lname'];
      _mobileController.text = contact['mobile'];
      _emailController.text = contact['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Contacto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un apellido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Número Móvil'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número móvil';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Aquí puedes actualizar la base de datos con la nueva información
                    Map<String, dynamic> updatedContact = {
                      'name': _firstNameController.text,
                      'lname': _lastNameController.text,
                      'mobile': _mobileController.text,
                      'email': _emailController.text,
                    };
                    await dbHelper.updateContact(widget.contactId, updatedContact);
                    Navigator.pop(context);
                  }
                },
                child: Text("Actualizar Contacto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
