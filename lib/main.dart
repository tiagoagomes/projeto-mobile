import 'package:flutter/material.dart';
import 'package:projetomobile/databasehelper.dart';
import 'package:projetomobile/login.dart';
import 'package:projetomobile/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Adicione o parâmetro de key aqui

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mix Colors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/register': (context) => const Register(),
        '/login': (context) => Login(key: UniqueKey()), // Adicione key aqui
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key}); // Adicione o parâmetro de key aqui

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Login(key: UniqueKey()), // Adicione key aqui
    const Register(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Register',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _handleLogin,
              child: const Icon(Icons.login),
            )
          : FloatingActionButton(
              onPressed: _handleRegister,
              child: const Icon(Icons.person_add),
            ),
    );
  }

  void _handleLogin() async {
    String email =
        Login.emailController.text; // Acesse o controlador do email do Login
    String senha = Login
        .senhaController.text; // Substitua pela senha fornecida pelo usuário

    bool loggedIn = await DatabaseHelper().authenticateUser(email, senha);
    if (loggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no login. Verifique suas credenciais.'),
        ),
      );
    }
  }

  void _handleRegister() async {
    String nome = "John Doe"; // Substitua pelo nome fornecido pelo usuário
    String email =
        Login.emailController.text; // Acesse o controlador do email do Login
    String senha = "senha123"; // Substitua pela senha fornecida pelo usuário

    bool registered = await DatabaseHelper().registerUser(nome, email, senha);
    if (registered) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no registro. Verifique suas informações.'),
        ),
      );
    }
  }
}
