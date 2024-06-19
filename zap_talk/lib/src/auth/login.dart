import 'package:flutter/material.dart';
import 'package:zap_talk/src/pages/firstPage.dart';
import 'package:zap_talk/src/widget/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String _email;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final gradientBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      gradient: const LinearGradient(
        colors: [
          Colors.purple,
          Colors.red,
          Colors.orange,
          Colors.yellow,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(80, 155, 39, 176),
              Color.fromARGB(71, 244, 67, 54),
              Color.fromARGB(106, 255, 153, 0),
              Color.fromARGB(96, 255, 235, 59),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(183, 255, 255, 255),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.red,
                              Colors.orange,
                              Colors.yellow,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: const Icon(
                          Icons.cruelty_free,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ZapTalk',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: gradientBorder,
                              padding: const EdgeInsets.all(2),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa tu correo';
                                  }
                                  return null;
                                },
                                onChanged: (valor) {
                                  _email = valor;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: gradientBorder,
                              padding: const EdgeInsets.all(2),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa tu contraseña';
                                  }
                                  return null;
                                },
                                onChanged: (valor) {
                                  _password = valor;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          );
                        },
                        child: const Text(
                          '¿No tienes cuenta? Regístrate',
                          style: TextStyle(
                            color: Color.fromARGB(92, 0, 0, 0),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Si el formulario es válido, navega a la primera página
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Firstpages()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        side: BorderSide.none,
                      ).copyWith(
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.red,
                              Colors.orange,
                              Colors.yellow,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
