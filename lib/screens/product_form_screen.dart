import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? producto;

  const ProductFormScreen({super.key, this.producto});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _cantidadCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();

  final List<String> _categorias = const [
    'Electrónica',
    'Ropa',
    'Alimentos',
    'Herramientas',
    'Papelería',
    'Otros'
  ];

  String? _categoriaSeleccionada;
  bool get _esEdicion => widget.producto != null;

  @override
  void initState() {
    super.initState();
    final p = widget.producto;
    if (p != null) {
      _nombreCtrl.text = p.nombre;
      _cantidadCtrl.text = p.cantidad.toString();
      _precioCtrl.text = p.precio.toString();
      _categoriaSeleccionada = p.categoria;
    }
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _cantidadCtrl.dispose();
    _precioCtrl.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    final id = _esEdicion
        ? widget.producto!.id
        : DateTime.now().millisecondsSinceEpoch.toString();

    Navigator.pop(
      context,
      Product(
        id: id,
        nombre: _nombreCtrl.text.trim(),
        cantidad: int.parse(_cantidadCtrl.text.trim()),
        precio: double.parse(_precioCtrl.text.trim()),
        categoria: _categoriaSeleccionada!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _esEdicion ? 'Editar Producto' : 'Nuevo Producto',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Indicador de contexto
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _esEdicion ? Icons.edit_note : Icons.add_box_outlined,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _esEdicion
                                  ? 'Modifica los datos del producto en inventario.'
                                  : 'Ingresa los datos para registrar un nuevo producto.',
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Campo Nombre
                    TextFormField(
                      controller: _nombreCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del producto',
                        hintText: 'Ej. Arroz 1kg, Camiseta, etc.',
                        prefixIcon: Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      validator: (val) =>
                          (val == null || val.trim().isEmpty)
                              ? 'Ingrese el nombre del producto'
                              : null,
                    ),

                    const SizedBox(height: 16),

                    // Campo Cantidad
                    TextFormField(
                      controller: _cantidadCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Cantidad en stock',
                        hintText: 'Ej. 25',
                        prefixIcon: Icon(
                          Icons.format_list_numbered,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        final n = int.tryParse(val?.trim() ?? '');
                        if (n == null) return 'Ingrese un número entero';
                        return n >= 0 ? null : 'La cantidad no puede ser negativa';
                      },
                    ),

                    const SizedBox(height: 16),

                    // Campo Precio
                    TextFormField(
                      controller: _precioCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Precio (₡)',
                        hintText: 'Ej. 1500.00',
                        prefixIcon: Icon(
                          Icons.sell_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (val) {
                        final p = double.tryParse(val?.trim() ?? '');
                        if (p == null) return 'Ingrese un precio válido';
                        return p >= 0 ? null : 'El precio no puede ser negativo';
                      },
                    ),

                    const SizedBox(height: 16),

                    // Campo Categoría
                    DropdownButtonFormField<String>(
                      initialValue: _categoriaSeleccionada,
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        prefixIcon: Icon(
                          Icons.category_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      items: _categorias
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _categoriaSeleccionada = val),
                      validator: (val) =>
                          val == null ? 'Seleccione una categoría' : null,
                    ),

                    const SizedBox(height: 30),

                    // Botón Guardar
                    ElevatedButton.icon(
                      onPressed: _guardar,
                      icon: Icon(
                        _esEdicion ? Icons.save_outlined : Icons.add,
                        size: 20,
                      ),
                      label: Text(
                        _esEdicion ? 'Guardar Cambios' : 'Registrar Producto',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Botón Cancelar
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
