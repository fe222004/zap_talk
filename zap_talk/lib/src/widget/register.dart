import 'package:flutter/material.dart';
import 'package:zap_talk/services/firebase_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _civilStatus;
  String? _dateBirth;
  String? _genders;

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
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const Text(
                  'Registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: _cedulaController,
                    decoration: const InputDecoration(
                      labelText: 'Cédula',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su cédula';
                      }
                      // Aquí puedes agregar validaciones adicionales para el campo de cédula si lo necesitas
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su nombre';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: _lastnameController,
                    decoration: const InputDecoration(
                      labelText: 'Apellido',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su apellido';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo Electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su correo electrónico';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Por favor ingrese un correo válido';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: DropdownButtonFormField<String>(
                    value: _civilStatus,
                    decoration: const InputDecoration(
                      labelText: 'Estado Civil',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: ['Soltero', 'Casado', 'Divorciado', 'Viudo', 'Soltera']
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _civilStatus = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione su estado civil';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Nacimiento (DD/MM/AAAA)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su fecha de nacimiento';
                      }
                      // Puedes agregar validaciones adicionales para la fecha de nacimiento si lo necesitas
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _dateBirth = value;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: gradientBorder,
                  padding: const EdgeInsets.all(2),
                  child: DropdownButtonFormField<String>(
                    value: _genders,
                    decoration: const InputDecoration(
                      labelText: 'Género',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: ['Masculino', 'Femenino', 'Otro']
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _genders = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione su género';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addUser(
                        cedula: _cedulaController.text,
                        name: _nameController.text,
                        lastname: _lastnameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        civilStatus: _civilStatus!,
                        dateBirth: _dateBirth!,
                        genders: _genders!,
                      ).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Usuario registrado exitosamente',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Error al registrar usuario: $error',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0, // Sin sombra
                    side: BorderSide.none, // Sin borde
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
