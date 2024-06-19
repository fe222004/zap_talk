import 'package:flutter/material.dart';
import 'package:zap_talk/src/pages/firstPage.dart';
import 'package:zap_talk/services/post_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PostService _postService = PostService();
  late Stream<List<Map<String, dynamic>>> _postsStream;

  @override
  void initState() {
    super.initState();
    _postsStream = _postService.streamPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              _buildProfileStats(),
              _buildProfileBio(),
              _buildTabs(context),
            ],
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
                  MaterialPageRoute(builder: (context) => Firstpages()),
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
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 90, 51, 197),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/descarga.jpeg'),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EstefaniA Andrade',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '@estefaniaAndrade',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Posts', '123'),
          _buildStatItem('Followers', '456K'),
          _buildStatItem('Following', '789'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileBio() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '“A veces, cuando innovas, cometes errores. Lo mejor es admitirlos y centrarse en perfeccionar otras ideas”, Steve Jobs.',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Color.fromARGB(255, 90, 51, 197),
            tabs: [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.bookmark)),
            ],
          ),
          Container(
            height: 400,
            child: TabBarView(
              children: [
                _buildGridPosts(),
                _buildListPosts(),
                _buildBookmarkedPosts(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridPosts() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _postsStream,
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
        return GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            return Container(
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  'Post ${index + 1}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          },
          itemCount: snapshot.data!.length,
        );
      },
    );
  }

  Widget _buildListPosts() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _postsStream,
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
          padding: EdgeInsets.all(16.0),
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/descarga(3).jpeg'),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'UsuarioEjemplo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deletePost(snapshot.data![index]['id']);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      snapshot.data![index]['text'] ?? '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: snapshot.data!.length,
        );
      },
    );
  }

  Widget _buildBookmarkedPosts() {
    return Center(
      child: Text('No hay publicaciones guardadas.'),
    );
  }

  void _deletePost(String postId) {
    _postService.deletePost(postId).then((_) {
      // Aquí puedes agregar lógica adicional si es necesario, como actualizar el estado
      print('Publicación eliminada correctamente');
    }).catchError((error) {
      print('Error al eliminar la publicación: $error');
    });
  }
}
