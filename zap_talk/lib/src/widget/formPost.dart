import 'package:flutter/material.dart';

class CreatePostModal extends StatefulWidget {
  final Function(String) onPostCreated;

  const CreatePostModal({Key? key, required this.onPostCreated}) : super(key: key);

  @override
  _CreatePostModalState createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Publicación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _postController,
              decoration: const InputDecoration(
                hintText: '¿Qué está pasando?',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Acción para publicar el post
                widget.onPostCreated(_postController.text);
              },
              child: const Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }
}
