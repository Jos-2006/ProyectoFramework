import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _productos = [
    Product(id: '1', nombre: 'Laptop HP', cantidad: 5, precio: 850.0, categoria: 'Electrónica'),
    Product(id: '2', nombre: 'Camiseta Polo', cantidad: 20, precio: 15.0, categoria: 'Ropa'),
    Product(id: '3', nombre: 'Arroz 1kg', cantidad: 50, precio: 2.5, categoria: 'Alimentos'),
  ];

  void _agregarProducto(Product producto) {
    setState(() => _productos.add(producto));
    _mostrarMensaje('Producto agregado correctamente');
  }

  void _editarProducto(Product productoActualizado) {
    setState(() {
      final index = _productos.indexWhere((p) => p.id == productoActualizado.id);
      if (index != -1) _productos[index] = productoActualizado;
    });
    _mostrarMensaje('Producto actualizado');
  }

  void _eliminarProducto(Product producto) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Desea eliminar "${producto.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _productos.removeWhere((p) => p.id == producto.id));
              Navigator.pop(ctx);
              _mostrarMensaje('Producto eliminado');
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _irAFormulario({Product? producto}) async {
    final resultado = await Navigator.push<Product>(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormScreen(producto: producto),
      ),
    );

    if (resultado == null) return;
    producto == null ? _agregarProducto(resultado) : _editarProducto(resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Inventario (MVP)'),
      ),
      body: _productos.isEmpty
          ? const Center(
              child: Text(
                'No hay productos registrados',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _productos.length,
              itemBuilder: (context, index) => ProductCard(
                producto: _productos[index],
                onEdit: () => _irAFormulario(producto: _productos[index]),
                onDelete: () => _eliminarProducto(_productos[index]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _irAFormulario(),
        tooltip: 'Agregar producto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
