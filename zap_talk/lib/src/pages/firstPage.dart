import 'package:flutter/material.dart';
import 'package:zap_talk/src/pages/perfil.dart';
import 'package:zap_talk/src/widget/navbar.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(150, 155, 39, 176),
              const Color.fromARGB(150, 244, 67, 54),
              const Color.fromARGB(150, 255, 153, 0),
              const Color.fromARGB(150, 255, 235, 59),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPostCard(), // Tarjeta para postear
                _buildUserPost(
                  avatarUrl: 'images/cereza.jpeg',
                  username: 'UsuarioEjemplo',
                  content: 'Este es un ejemplo de cómo se vería una publicación de texto.',
                ),
                _buildUserPost(
                  avatarUrl: 'images/descarga.jpeg',
                  username: 'UsuarioEjemplo',
                  content: 'Tu sonrisa me reconforta e ilumina mis días grises.',
                  imageUrl: 'images/cereza.jpeg',
                ),
                _buildInfoCard(
                  title: 'Descripción de ZapTalk',
                  content:
                      'ZapTalk es una plataforma de redes sociales donde puedes conectarte con amigos, familiares y personas de todo el mundo.',
                ),
                _buildInfoCard(
                  title: 'Funcionalidades principales',
                  content:
                      'Aquí puedes compartir tus pensamientos, ideas y momentos especiales con la comunidad. Publica tus posts, interactúa con otras publicaciones y mantente al día con las últimas tendencias.',
                ),
              ],
            ),
          ),
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
                  MaterialPageRoute(builder: (context) => const FirstPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(55, 23, 3, 78),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildPostCard() {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: '¿Qué está pasando?',
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Acción para publicar el post
                print(_postController.text);
              },
              child: Text('Publicar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 90, 51, 197),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserPost({
    required String avatarUrl,
    required String username,
    required String content,
    String? imageUrl,
  }) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(avatarUrl),
                ),
                SizedBox(width: 10.0),
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            if (imageUrl != null) ...[
              SizedBox(height: 10.0),
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
