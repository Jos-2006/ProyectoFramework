
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product producto;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.producto,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(producto.cantidad.toString()),
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${producto.categoria}: ₡${producto.precio.toStringAsFixed(2)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: onEdit,
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                minimumSize: const Size(0, 36),
              ),
              child: const Text('Editar'),
            ),
            TextButton(
              onPressed: onDelete,
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                minimumSize: const Size(0, 36),
              ),
              child: const Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
