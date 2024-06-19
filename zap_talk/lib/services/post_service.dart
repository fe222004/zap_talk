import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

   final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addPost({
    required String text,
  }) async {
    CollectionReference posts = _db.collection('posts');
    try {
      await posts.add({
        'text': text,
        'createdAt': FieldValue.serverTimestamp(), // Timestamp del servidor
      });
      print("Post agregado exitosamente");
    } catch (e) {
      print("Error al agregar el post: $e");
    }
  }

 Future<List<Map<String, dynamic>>> getPosts() async {
    List<Map<String, dynamic>> posts = [];
    try {
      QuerySnapshot querySnapshot = await _db.collection('posts').get();
      querySnapshot.docs.forEach((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        posts.add(data);
      });
    } catch (e) {
      print("Error al obtener los posts: $e");
    }
    return posts;
  }


   Stream<List<Map<String, dynamic>>> streamPosts() {
    try {
      return _postsCollection.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
    } catch (e) {
      throw Exception('Error al escuchar los posts en tiempo real: $e');
    }
  }

    Future<void> deletePost(String postId) async {
    try {
      await _postsCollection.doc(postId).delete();
      print("Post eliminado exitosamente");
    } catch (e) {
      print("Error al eliminar el post: $e");
    }
  }
}
