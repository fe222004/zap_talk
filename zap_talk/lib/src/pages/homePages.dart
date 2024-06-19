import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zap_talk/src/auth/login.dart'; // Asegúrate de importar tus archivos necesarios
import 'package:zap_talk/services/post_service.dart'; // Importa tu servicio para obtener los posts

class Homepages extends StatefulWidget {
  const Homepages({Key? key}) : super(key: key);

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  final PostService _postService = PostService(); // Instancia del servicio de posts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZapTalk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Publicaciones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _postService.getPosts(), // Obtener los posts del servicio
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay publicaciones.'));
                  }
                  // Mostrar lista de tarjetas de publicaciones
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _buildPostCard(snapshot.data![index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> postData) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postData['text'], // Mostrar el texto del post
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fecha: ${_formatTimestamp(postData['createdAt'])}', // Mostrar la fecha del post
                  style: TextStyle(color: Colors.grey),
                ),
                // Aquí puedes agregar más widgets según tus necesidades (botones, iconos, etc.)
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    // Función para formatear el timestamp (puedes personalizar según el formato deseado)
    if (timestamp is Timestamp) {
      DateTime dateTime = timestamp.toDate();
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
    return 'Fecha desconocida';
  }
}
