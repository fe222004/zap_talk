import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future <List> getUser() async{
  List users = [];

  CollectionReference collectionReferenceUsers = db.collection('users');

  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  queryUsers.docs.forEach((documento){
    users.add(documento.data());
  });

  return users;
}  


Future<void> addUser({
  required String cedula,
  required String name,
  required String lastname,
  required String email,
  required String password,
  required String civilStatus,
  required String dateBirth,
  required String genders,
}) async {
  CollectionReference users = db.collection('users');
  try {
    await users.add({
      'cedula': cedula,
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
      'civilStatus': civilStatus,
      'dateBirth': dateBirth,
      'genders': genders,
    });
    print("Usuario agregado exitosamente");
  } catch (e) {
    print("Error al agregar usuario: $e");
  }
}