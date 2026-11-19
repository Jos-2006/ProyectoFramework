import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Eliminar producto'),
          content: Text(
            '¿Desea eliminar "${producto.nombre}" de la bodega?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.productos.removeWhere(
                    (p) => p.id == producto.id,
                  );
                });

                widget.onChanged();
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar'),
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: AppColors.textMuted.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No hay productos registrados',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
