
import 'package:lesson_extra_persistence/db/db_provider.dart';



import 'dart:convert';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allContactData = [];

  @override
  void initState() {
    super.initState();
    contactList();
  }

  void contactList() async {
    final allContacts = await dbHelper.queryAllContacts();
    setState(() {
      allContactData = allContacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contactos')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Para el scroll horizontal
        child: DataTable(
          headingTextStyle: TextStyle(
            color: Colors.white, // Color de letra de los encabezados
            fontWeight: FontWeight.bold,
          ),
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.orange, // Color de fondo de los encabezados
          ),
          columns: [
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Apellido')),
            DataColumn(label: Text('Móvil')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Categoría')),
            DataColumn(label: Text('Perfil')),
          ],
          rows: allContactData.map((contact) {
            return DataRow(
              cells: [
                DataCell(Text(contact[DatabaseHelper.columnName])),
                DataCell(Text(contact[DatabaseHelper.columnLName])),
                DataCell(Text(contact[DatabaseHelper.columnMobile])),
                DataCell(Text(contact[DatabaseHelper.columnEmail])),
                DataCell(Text(contact[DatabaseHelper.columnCategory])),
                DataCell(
                  CircleAvatar(
                    backgroundImage: MemoryImage(
                      base64Decode(contact[DatabaseHelper.columnProfile]),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}


