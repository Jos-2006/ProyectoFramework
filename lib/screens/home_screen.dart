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
  int _selectedIndex = 0;

  final List<Product> _productos = [
    Product(
      id: '1',
      nombre: 'Laptop HP',
      cantidad: 5,
      precio: 850.0,
      categoria: 'Electrónica',
    ),
    Product(
      id: '2',
      nombre: 'Camiseta Polo',
      cantidad: 20,
      precio: 15.0,
      categoria: 'Ropa',
    ),
    Product(
      id: '3',
      nombre: 'Arroz 1kg',
      cantidad: 50,
      precio: 2.5,
      categoria: 'Alimentos',
    ),
  ];

  void _agregarProducto(Product producto) {
    setState(() {
      _productos.add(producto);
    });
    _mostrarMensaje('Producto agregado correctamente');
  }

  void _editarProducto(Product productoActualizado) {
    setState(() {
      final index = _productos.indexWhere((p) => p.id == productoActualizado.id);
      if (index != -1) {
        _productos[index] = productoActualizado;
      }
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
              setState(() {
                _productos.removeWhere((p) => p.id == producto.id);
              });
              Navigator.pop(ctx);
              _mostrarMensaje('Producto eliminado');
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
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

    if (producto == null) {
      _agregarProducto(resultado);
    } else {
      _editarProducto(resultado);
    }
  }

    Widget _buildInicio() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          const SizedBox(
            width: double.infinity,
            child: const Text(
              'Bienvenido a Bodega',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Gestiona tus productos de manera sencilla y rápida.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 35),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _irAFormulario(),
              icon: const Icon(Icons.add),
              label: const Text('Agregar producto'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductos() {
    if (_productos.isEmpty) {
      return const Center(
        child: Text(
          'No hay productos registrados',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: _productos.length,
      itemBuilder: (context, index) {
        final producto = _productos[index];
        return ProductCard(
          producto: producto,
          onEdit: () => _irAFormulario(producto: producto),
          onDelete: () => _eliminarProducto(producto),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool enProductos = _selectedIndex == 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(enProductos ? 'Ver productos' : 'Inicio'),
      ),
      body: enProductos ? _buildProductos() : _buildInicio(),
      floatingActionButton: enProductos
          ? FloatingActionButton(
              onPressed: () => _irAFormulario(),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Ver productos',
          ),
        ],
      ),
    );
  }
}