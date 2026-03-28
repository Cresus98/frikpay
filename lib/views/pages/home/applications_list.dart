import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

class AnimatedListPage extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => "Élément ${index + 1}");

  AnimatedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste Animée"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ImplicitlyAnimatedList<String>(
          itemData: items,
          itemBuilder: (context, item) {

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text("${items.indexOf(item) + 1}"),
                ),
                title: Text(
                  item,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: const Text("Description de l'élément"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
