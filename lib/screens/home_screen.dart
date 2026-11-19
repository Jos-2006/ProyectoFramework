import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/product_card.dart';
import 'product_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _categoriaSeleccionada = 'Todas';
  bool _vistaTabla = false; // Permite alternar entre tarjetas (móvil) y tabla

  final ScrollController _tablaScrollController = ScrollController();

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Eliminar producto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text('¿Desea eliminar "${producto.nombre}" de la bodega?'),
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
                _productos.removeWhere((p) => p.id == producto.id);
              });
              Navigator.pop(ctx);
              _mostrarMensaje('Producto eliminado');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.actionDelete,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

  // --- PANTALLA DE INICIO (DASHBOARD RESPONSIVO) ---
  Widget _buildInicio() {
    final int totalProductos = _productos.length;
    final int totalUnidades =
        _productos.fold<int>(0, (sum, p) => sum + p.cantidad);
    final double valorTotal = _productos.fold<double>(
      0.0,
      (sum, p) => sum + (p.cantidad * p.precio),
    );

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Institucional
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Image.asset(
                    'assets/images/logo_pequeno_mundo.png',
                    height: 65,
                    width: 220,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 24),

                // Títulos en la gama Pequeño Mundo
                const Text(
                  'Bodega Central',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Control de inventario, stock y productos en tiempo real.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 28),

                // Métricas en fila horizontal (Side by side en móvil)
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricaCard(
                        icon: Icons.inventory_2_outlined,
                        titulo: 'Referencias',
                        valor: totalProductos.toString(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildMetricaCard(
                        icon: Icons.layers_outlined,
                        titulo: 'Unidades Stock',
                        valor: totalUnidades.toString(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildMetricaCard(
                        icon: Icons.monetization_on_outlined,
                        titulo: 'Valor Inventario',
                        valor: '₡${valorTotal.toStringAsFixed(0)}',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Botones de acción rápida
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _irAFormulario(),
                    icon: const Icon(Icons.add_circle_outline, size: 22),
                    label: const Text('Registrar nuevo producto'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    icon: const Icon(Icons.table_chart_outlined, size: 20),
                    label: const Text('Ver lista de inventario'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricaCard({
    required IconData icon,
    required String titulo,
    required String valor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              valor,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // --- PANTALLA DE PRODUCTOS ---
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

    final productosFiltrados = _categoriaSeleccionada == 'Todas'
        ? _productos
        : _productos
            .where((p) => p.categoria == _categoriaSeleccionada)
            .toList();

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Barra de filtros y selector de vista
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    // Filtro por categoría
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _categoriaSeleccionada,
                        decoration: const InputDecoration(
                          labelText: 'Categoría',
                          prefixIcon: Icon(
                            Icons.filter_list,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                        items: categorias.map((categoria) {
                          return DropdownMenuItem<String>(
                            value: categoria,
                            child: Text(
                              categoria,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (valor) {
                          if (valor != null) {
                            setState(() {
                              _categoriaSeleccionada = valor;
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Selector de modo de vista: Tarjeta (móvil) vs Tabla
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Vista en tarjetas (recomendada para móvil)',
                            icon: Icon(
                              Icons.view_agenda_outlined,
                              color: !_vistaTabla
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                            onPressed: () {
                              setState(() {
                                _vistaTabla = false;
                              });
                            },
                          ),
                          IconButton(
                            tooltip: 'Vista en tabla',
                            icon: Icon(
                              Icons.table_chart_outlined,
                              color: _vistaTabla
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                            onPressed: () {
                              setState(() {
                                _vistaTabla = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de productos o tabla
              Expanded(
                child: productosFiltrados.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 56,
                              color: AppColors.textMuted.withOpacity(0.4),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No hay productos registrados',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Presiona el botón + para registrar uno',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _vistaTabla
                        ? _buildTablaProductos(productosFiltrados)
                        : _buildListaTarjetas(productosFiltrados),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Vista en tarjetas (Óptima para celulares y pantallas táctiles)
  Widget _buildListaTarjetas(List<Product> productos) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 6, bottom: 80),
      itemCount: productos.length,
      itemBuilder: (context, index) {
        final producto = productos[index];
        return ProductCard(
          producto: producto,
          onEdit: () => _irAFormulario(producto: producto),
          onDelete: () => _eliminarProducto(producto),
        );
      },
    );
  }

  // Vista en tabla con scroll horizontal suave
  Widget _buildTablaProductos(List<Product> productos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Scrollbar(
          controller: _tablaScrollController,
          thumbVisibility: true,
          trackVisibility: true,
          interactive: true,
          thickness: 6,
          radius: const Radius.circular(8),
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: SingleChildScrollView(
            controller: _tablaScrollController,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: DataTable(
                headingRowColor: const WidgetStatePropertyAll(
                  AppColors.tableHeader,
                ),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.tableHeaderText,
                  fontSize: 13,
                ),
                dataRowMinHeight: 52,
                dataRowMaxHeight: 56,
                columns: const [
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('Categoría')),
                  DataColumn(label: Text('Precio (₡)')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: productos.map((producto) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          producto.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            producto.cantidad.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(producto.categoria)),
                      DataCell(
                        Text(
                          '₡${producto.precio.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Editar',
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 19,
                                color: AppColors.actionEdit,
                              ),
                              onPressed: () =>
                                  _irAFormulario(producto: producto),
                            ),
                            IconButton(
                              tooltip: 'Eliminar',
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 19,
                                color: AppColors.actionDelete,
                              ),
                              onPressed: () => _eliminarProducto(producto),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tablaScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool enProductos = _selectedIndex == 1;

    return Scaffold(
      appBar: enProductos
          ? AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo_pequeno_mundo.png',
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Inventario',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: enProductos ? _buildProductos() : _buildInicio(),
      floatingActionButton: enProductos
          ? FloatingActionButton(
              onPressed: () => _irAFormulario(),
              tooltip: 'Agregar producto',
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
            label: 'Inventario',
          ),
        ],
      ),
    );
  }
}
