import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lesson_extra_persistence/db/db_provider.dart';
import 'package:lesson_extra_persistence/utils/colors.dart';
import 'package:lesson_extra_persistence/utils/mydrawal.dart';
import 'package:lesson_extra_persistence/screens/edit_contact_screen.dart';


class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allContactData = [];

  @override
  void initState() {
    super.initState();
    contactList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawal(),
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: const Text("Lista de Contactos"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Text(""),
            Expanded(
                child: ListView.builder(
              itemCount: allContactData.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                var item = allContactData[index];
                Uint8List bytes = base64Decode(item['profile']);
                return Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            minRadius: 20,maxRadius: 25,
                            child: Image.memory(bytes,fit: BoxFit.fill,),),
                          const SizedBox(width: 20,),
                          Text("${item['name']} "),
                          Text("${item['lname']}"),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              confirmDelete(context, item['_id']);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                          onPressed: () {
                            // Aquí navegaremos hacia la pantalla de edición.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditContactScreen(contactId: item['_id']),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                          const SizedBox(width: 20,)
                        ],
                      ),
                      const Divider(
                        color: MyColors.orangeDivider,
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
void confirmDelete(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmación'),
        content: Text('¿Estás seguro de que quieres eliminar este contacto?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          ),
          TextButton(
            child: Text('Eliminar'),
            onPressed: () {
              deleteContact(id);
              Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
            },
          ),
        ],
      );
    },
  );
}
  void contactList() async {
    final allContacts = await dbHelper.queryAllContacts();
    setState(() {
      allContactData = allContacts;
    });
  }

  void deleteContact(int id) async {
    final contactDeleted = await dbHelper.deleteContact(id);
    contactList();
  }
}