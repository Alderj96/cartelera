import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> _getLoadingMessages() {
    const List<String> messages = [
      'Cargando peliculas',
      'Comprando palomitas de maíz', 
      'Cargando populares',
      'Cargando proximas peliculas',
      'Ya casi...',
      'Esto esta tardando más de los esperado :(',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Espero por favor...'),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10,),

          StreamBuilder(
            initialData: 'Cargando...',
            stream: _getLoadingMessages(),
            builder: (context, snapshot) => Text(snapshot.data!),
          ),
        ],
      ),
    );
  }
}