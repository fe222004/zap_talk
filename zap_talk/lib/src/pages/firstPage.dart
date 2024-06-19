import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zap_talk/src/auth/login.dart';
import 'package:zap_talk/services/post_service.dart';
import 'package:zap_talk/src/pages/perfil.dart';
import 'package:zap_talk/src/widget/formPost.dart';

class Firstpages extends StatefulWidget {
  const Firstpages({Key? key}) : super(key: key);

  @override
  _FirstpagesState createState() => _FirstpagesState();
}

class _FirstpagesState extends State<Firstpages> {
  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZapTalk'),
        backgroundColor: const Color.fromARGB(0, 255, 153, 0), // Color de fondo del appbar
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
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _postService.streamPosts(), // Obtener el stream de posts
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Firstpages()),
                );
              },
            ),
           
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                _showCreatePostModal(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostModal(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 90, 51, 197),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              postData['text'],
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fecha: ${_formatTimestamp(postData['createdAt'])}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      DateTime dateTime = timestamp.toDate();
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
    return 'Fecha desconocida';
  }

  void _showCreatePostModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CreatePostModal(
          onPostCreated: (text) {
            _postService.addPost(text: text); // Agregar el post
            Navigator.pop(context); // Cerrar el modal
          },
        );
      },
    );
  }
}
