import 'package:flutter/material.dart';
import 'package:lesson_extra_persistence/screens/add_contact.dart';
import 'package:lesson_extra_persistence/screens/contact_list.dart';
import 'package:lesson_extra_persistence/screens/contacts_screen.dart';
import 'package:lesson_extra_persistence/screens/uno_screen.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int selectedPage = 0;
  
final screens = [

  const UnoScreen(), 
  const AddContact(), 
  const ContactList(), 
  ContactsScreen()
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedPage],
      bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(96, 77, 196, 180), blurRadius: 10, spreadRadius: 5)
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: BottomNavigationBar(
              items: itemsBNB(),
              currentIndex: selectedPage,
              onTap: (position) {
                setState(() {
                  selectedPage = position;
                  //selectionTab(position);
                });
              },
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.blueGrey,
              backgroundColor: Color.fromARGB(255, 91, 241, 229),
            ),
          )),
    );
  }

  List<BottomNavigationBarItem> itemsBNB() {
    List<BottomNavigationBarItem> list = [];
    list.add(const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"));
    list.add(const BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: "Contactos"));
    list.add(const BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lista"));
    list.add(const BottomNavigationBarItem(icon: Icon(Icons.view_list), label: "Lista Detalle"));
    return list;
  }


}
