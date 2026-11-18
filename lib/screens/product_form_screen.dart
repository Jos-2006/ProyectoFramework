import 'package:flutter/material.dart';
import '../models/product.dart';

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
        title: Text(_esEdicion ? 'Editar Producto' : 'Nuevo Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre del producto',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Ingrese el nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cantidadCtrl,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  final n = int.tryParse(val?.trim() ?? '');
                  if (n == null) return 'Ingrese un número entero';
                  return n > 0 ? null : 'La cantidad debe ser mayor a 0';
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precioCtrl,
                decoration: const InputDecoration(
                  labelText: 'Precio (USD)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (val) {
                  final p = double.tryParse(val?.trim() ?? '');
                  if (p == null) return 'Ingrese un número válido';
                  return p > 0 ? null : 'El precio debe ser mayor a 0';
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _categoriaSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                items: _categorias
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) => setState(() => _categoriaSeleccionada = val),
                validator: (val) =>
                    val == null ? 'Seleccione una categoría' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(_esEdicion ? 'Guardar Cambios' : 'Agregar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
