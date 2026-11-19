
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  String _categoriaSeleccionada = 'Todas';

  final ScrollController _tablaScrollController =
      ScrollController();

  final List<Product> _productos = [
    Product(
      id: '1',
      nombre: 'Laptop HP',
      cantidad: 5,
      precio: 450000.0,
      categoria: 'Electrónica',
    ),
    Product(
      id: '2',
      nombre: 'Camiseta Polo',
      cantidad: 20,
      precio: 10000.0,
      categoria: 'Ropa',
    ),
    Product(
      id: '3',
      nombre: 'Arroz 1kg',
      cantidad: 50,
      precio: 1800.0,
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
      final index = _productos.indexWhere(
        (p) => p.id == productoActualizado.id,
      );

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
        content: Text(
          '¿Desea eliminar "${producto.nombre}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _productos.removeWhere(
                  (p) => p.id == producto.id,
                );
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
        builder: (_) => ProductFormScreen(
          producto: producto,
        ),
      ),
    );

    if (resultado == null) return;

    if (producto == null) {
      _agregarProducto(resultado);
    } else {
      _editarProducto(resultado);
    }
  }

  // PANTALLA DE INICIO

  Widget _buildInicio() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo_pequeno_mundo.png',
              height: 75,
              width: 220,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 20),

          const SizedBox(height: 20),

          const SizedBox(
            width: double.infinity,
            child: Text(
              '¡Bienvenido a Bodega!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 61, 110),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const SizedBox(
            width: double.infinity,
            child: Text(
              'Gestiona tus productos de manera sencilla y rápida.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Center(
            child: Container(
              width: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.list_alt_outlined,
                    size: 35,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    _productos.length.toString(),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 61, 110),
                    ),
                  ),

                  const Text(
                    'Productos',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 1, 61, 110),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _irAFormulario(),
              
              label: const Text('Agregar producto'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PANTALLA DE PRODUCTOS

  Widget _buildProductos() {
    final categorias = [
      'Todas',
      'Electrónica',
      'Ropa',
      'Alimentos',
      'Herramientas',
      'Papelería',
      'Otros',
    ];

    final productosFiltrados =
        _categoriaSeleccionada == 'Todas'
            ? _productos
            : _productos
                .where(
                  (p) => p.categoria == _categoriaSeleccionada,
                )
                .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FILTRO POR CATEGORÍA

          DropdownButtonFormField<String>(
            initialValue: _categoriaSeleccionada,
            decoration: const InputDecoration(
              labelText: 'Filtrar por categoría',
              border: OutlineInputBorder(),
            ),
            items: categorias.map((categoria) {
              return DropdownMenuItem<String>(
                value: categoria,
                child: Text(categoria),
              );
            }).toList(),
            onChanged: (valor) {
              if (valor != null) {
                setState(() {
                  _categoriaSeleccionada = valor;
                });

                if (_tablaScrollController.hasClients) {
                  _tablaScrollController.jumpTo(0);
                }
              }
            },
          ),

          const SizedBox(height: 20),

          // TABLA DE PRODUCTOS

          Scrollbar(
            controller: _tablaScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            thickness: 6,
            radius: const Radius.circular(10),
            scrollbarOrientation: ScrollbarOrientation.bottom,
            child: SingleChildScrollView(
              controller: _tablaScrollController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStatePropertyAll(
                  const Color.fromARGB(255, 106, 188, 255),
                ),

                columns: const [
                  DataColumn(
                    label: Text('Producto'),
                  ),
                  DataColumn(
                    label: Text('Cantidad'),
                  ),
                  DataColumn(
                    label: Text('Categoría'),
                  ),
                  DataColumn(
                    label: Text('Precio'),
                  ),
                  DataColumn(
                    label: SizedBox.shrink(),
                  ),
                  DataColumn(
                    label: SizedBox.shrink(),
                  ),
                ],

                rows: productosFiltrados.map((producto) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          producto.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      DataCell(
                        Text(
                          producto.cantidad.toString(),
                        ),
                      ),

                      DataCell(
                        Text(producto.categoria),
                      ),

                      DataCell(
                        Text(
                          '₡${producto.precio.toStringAsFixed(2)}',
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),

                      // EDITAR

                      DataCell(
                        TextButton(
                          onPressed: () {
                            _irAFormulario(
                              producto: producto,
                            );
                          },
                          child: const Text(
                            'Editar',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),

                      // ELIMINAR

                      DataCell(
                        TextButton(
                          onPressed: () {
                            _eliminarProducto(producto);
                          },
                          child: const Text(
                            'Eliminar',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tablaScrollController.dispose();
    super.dispose();
  }

  // CONSTRUCCIÓN PRINCIPAL

  @override
  Widget build(BuildContext context) {
    final bool enProductos = _selectedIndex == 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          enProductos ? 'Ver productos' : 'Inicio',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
      ),

      body: enProductos
          ? _buildProductos()
          : _buildInicio(),

      floatingActionButton: enProductos
          ? FloatingActionButton(
              onPressed: () => _irAFormulario(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : null,

      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          labelTextStyle:
              WidgetStatePropertyAll<TextStyle>(
            TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ),

        child: NavigationBar(
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
      ),
    );
  }
}
