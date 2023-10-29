import 'package:flutter/material.dart';

class UnoScreen extends StatelessWidget {
  const UnoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
        children: [
          // Imagen de fondo
          Center(
            child: AspectRatio(
              aspectRatio: 16/9,  // Esta relación de aspecto es común, pero puedes ajustarla según tus necesidades.
              child: Image.asset(
                'assets/images/contasctos3.jpg', // Asegúrate de que esta ruta coincida con la ubicación de tu imagen.
                fit: BoxFit.cover,
              ),
            ),
          ),     

          
          // Título
          Positioned(
            top: 80, // Puedes ajustar este valor para cambiar la posición vertical del título.
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "SISTEMA DE CONTACTOS",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
