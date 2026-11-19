import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_form_screen.dart';

class ProductsScreen extends StatefulWidget {
  final List<Product> productos;
  final VoidCallback onChanged;

  const ProductsScreen({
    super.key,
    required this.productos,
    required this.onChanged,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  Future<void> _editarProducto(Product producto) async {
    final resultado = await Navigator.push<Product>(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormScreen(
          producto: producto,
        ),
      ),
    );

    if (resultado != null) {
      final index = widget.productos.indexWhere(
        (p) => p.id == resultado.id,
      );

      if (index != -1) {
        setState(() {
          widget.productos[index] = resultado;
        });

        widget.onChanged();
      }
    }
  }

  void _eliminarProducto(Product producto) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Eliminar producto'),
          content: Text(
            '¿Desea eliminar "${producto.nombre}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.productos.removeWhere(
                    (p) => p.id == producto.id,
                  );
                });

                widget.onChanged();

                Navigator.pop(ctx);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        centerTitle: true,
      ),
      body: widget.productos.isEmpty
          ? const Center(
              child: Text(
                'No hay productos registrados',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: widget.productos.length,
              itemBuilder: (context, index) {
                final producto = widget.productos[index];

                return ProductCard(
                  producto: producto,
                  onEdit: () => _editarProducto(producto),
                  onDelete: () => _eliminarProducto(producto),
                );
              },
            ),
    );
  }
}