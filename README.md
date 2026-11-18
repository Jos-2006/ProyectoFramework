# Gestor de Inventario - MVP (Flutter)

Aplicación Flutter mínima viable (MVP) para la gestión y demostración práctica de desarrollo móvil, correspondiente a la investigación del curso **Desarrollo de Software IV (UCR)**.

---

## 🎯 Alcance del MVP

El MVP se enfoca en la funcionalidad esencial requerida por la rúbrica de evaluación, reduciendo sobrecarga visual y capas complejas de diseño para facilitar su entendimiento y exposición en clase:

1. **Pantalla Principal (`HomeScreen`)**:
   - Listado reactivo de productos en memoria (`ListView.builder`).
   - Estado vacío cuando no existen elementos.
   - Acciones directas de edición y eliminación con confirmación.
   - Botón flotante (`FloatingActionButton`) para registrar nuevos productos.

2. **Formulario de Producto (`ProductFormScreen`)**:
   - Cuatro campos de entrada: Nombre, Cantidad, Precio y Categoría.
   - Validaciones de campos obligatorios y números mayores a cero.
   - Modo dual: Crear nuevo producto o Editar existente.
   - Navegación estándar mediante `Navigator.push` y `Navigator.pop`.
   - Retroalimentación visual inmediata con `SnackBar`.

---

## 📋 Cumplimiento de Requisitos de la Rúbrica

| ID | Requisito | Implementación en el MVP |
|---|---|---|
| **DE-01** | Proyecto propio y ejecutable | Código Flutter compatible con Web (Edge/Chrome) y Escritorio (Windows). |
| **DE-02** | Interfaz móvil (≥ 2 pantallas) | `HomeScreen` (catálogo/listado) y `ProductFormScreen` (formulario). |
| **DE-03** | Interacción y validación | 4 campos validados con mensajes de error y confirmación visual (`SnackBar`). |
| **DE-04** | Datos dinámicos | Manejo de estado en memoria con operaciones CRUD (Crear, Leer, Actualizar, Borrar). |
| **DE-05** | Explicación técnica clara | Arquitectura limpia dividida en `models/`, `screens/` y `widgets/`. |
| **DE-06** | Reproducibilidad | Instrucciones claras de instalación y comandos de ejecución. |

---

## 📂 Estructura del Código

```text
lib/
├── main.dart                   # Punto de entrada de la aplicación y MaterialApp
├── models/
│   └── product.dart            # Modelo de datos Producto
├── screens/
│   ├── home_screen.dart        # Pantalla principal: Listado y gestión de estado
│   └── product_form_screen.dart # Pantalla de formulario: Creación / Edición
└── widgets/
    └── product_card.dart       # Componente reutilizable para cada elemento
```

---

## 🚀 Instrucciones de Ejecución

1. **Obtener dependencias:**
   ```bash
   flutter pub get
   ```

2. **Ejecutar en Navegador (Edge):**
   ```bash
   flutter run -d edge
   ```

3. **Ejecutar en Escritorio (Windows):**
   ```bash
   flutter run -d windows
   ```
