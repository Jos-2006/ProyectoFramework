# Gestor de Inventario - Bodega Pequeño Mundo (Flutter MVP)

Aplicación móvil y multiplataforma desarrollada en **Flutter** para la demostración práctica e investigación del curso **Desarrollo de Software IV (UCR - Sede Regional del Pacífico)**.

---

## 🎯 Alcance y Funcionalidad del MVP

La aplicación implementa un sistema reactivo y responsivo de control de inventario adaptado con la identidad corporativa de **Pequeño Mundo**:

1. **Dashboard de Inicio (`HomeScreen`)**:
   - Visualización de marca oficial con logotipo institucional.
   - Tarjetas de métricas en tiempo real en fila responsiva: **Total de Referencias**, **Unidades en Stock** y **Valor Total Estimado del Inventario (₡)**.
   - Accesos directos a registro de productos e inventario general.

2. **Catálogo de Inventario (`HomeScreen` - Pestaña Inventario)**:
   - **Filtro dinámico por categorías** (Electrónica, Ropa, Alimentos, Herramientas, Papelería, Otros).
   - **Selector de vista adaptativa**:
     - *Vista Tarjetas (Mobile-First)*: Diseño optimizado para teléfonos con avatar de stock, badge de categoría, precio en colones y botones táctiles de editar/eliminar.
     - *Vista Tabla*: Cuadrícula completa de datos con desplazamiento horizontal táctil.
   - Diálogo de confirmación para eliminación segura.
   - Botón flotante (`FloatingActionButton`) para agregar nuevos productos.

3. **Formulario de Producto (`ProductFormScreen`)**:
   - Cuatro campos tipados con validación en tiempo real:
     - Nombre del producto (texto no vacío).
     - Cantidad en stock (entero $\ge 0$).
     - Precio unitario en colones (numérico $\ge 0$).
     - Categoría (selección obligatoria).
   - Modo dual automático: **Nuevo Producto** o **Editar Producto**.
   - Notificaciones emergentes con `SnackBar` tras cada operación.

---

## 📋 Cumplimiento de Requisitos de la Rúbrica (UCR)

| ID | Criterio de Evaluación | Estado | Implementación en el Proyecto |
|---|---|:---:|---|
| **DE-01** | Proyecto propio y ejecutable | ✅ | Compila sin errores (`flutter analyze: 0 issues`). Corre en Web (Edge/Chrome), Windows y Android. |
| **DE-02** | Interfaz móvil ($\ge$ 2 pantallas) | ✅ | Navegación desacoplada entre `HomeScreen` y `ProductFormScreen` mediante `Navigator.push` y `Navigator.pop`. |
| **DE-03** | Interacción y validación | ✅ | Formulario con validaciones tipadas (`_formKey`), teclado numérico y alertas reactivas. |
| **DE-04** | Manejo de datos dinámicos | ✅ | Colección reactiva en memoria con operaciones CRUD completas (Crear, Leer, Actualizar, Eliminar). |
| **DE-05** | Arquitectura y explicación técnica | ✅ | Modularidad estricta en capas: `models/`, `screens/`, `widgets/` y `theme/`. |
| **DE-06** | Reproducibilidad | ✅ | Documentación detallada de ejecución, dependencias y arquitectura técnica en `DOCUMENTO_TECNICO_MVP.md`. |

---

## 📂 Organización del Código Fuente

```text
lib/
├── main.dart                   # Inicialización, configuración de MaterialApp y tema global
├── models/
│   └── product.dart            # Entidad inmutable del dominio (Product)
├── screens/
│   ├── home_screen.dart        # Dashboard de métricas, catálogo y lógica reactiva de estado
│   └── product_form_screen.dart # Formulario de captura con validaciones de negocio
├── theme/
│   └── app_colors.dart         # Paleta de colores oficial Pequeño Mundo (#E00614)
└── widgets/
    └── product_card.dart       # Componente visual reutilizable para tarjetas móviles
```

---

## 🚀 Instrucciones de Ejecución

1. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Ejecutar en Navegador (Edge / Web):**
   ```bash
   flutter run -d edge
   ```
   *(Tip para presentación: en Edge presiona `F12` y activa la vista de emulación móvil `Ctrl + Shift + M`).*

3. **Compilar APK para Android (cuando se requiera):**
   ```bash
   flutter build apk --release
   ```
   *El instalador se generará en `build/app/outputs/flutter-apk/app-release.apk`.*
