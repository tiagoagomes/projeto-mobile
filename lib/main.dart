import 'package:flutter/material.dart';
import 'package:projetomobile/login.dart';
import 'package:projetomobile/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Adicionei a chave key aqui

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mix Colors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Definindo as rotas para cada tela
      initialRoute: '/', // Rota inicial
      routes: {
        '/': (context) => const Login(), // Tela de login como página inicial
        '/register': (context) => const Register(), // Tela de registro
      },
    );
  }
}
