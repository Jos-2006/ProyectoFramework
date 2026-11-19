# Gestor de Inventario – Pequeño Mundo

## Descripción del proyecto

Este proyecto consiste en el desarrollo de una aplicación de gestión de inventario utilizando **Flutter** y el lenguaje de programación **Dart**.

La aplicación está inspirada en la tienda Pequeño Mundo y tiene como objetivo facilitar el registro y control de los productos de una bodega, permitiendo consultar las existencias, agregar nuevos productos, modificar su información y eliminar registros cuando sea necesario.

El proyecto fue desarrollado como parte de la investigación y demostración práctica del curso **Desarrollo de Software IV**, de la carrera de Informática Empresarial de la Universidad de Costa Rica, Sede del Pacífico.

La idea principal es demostrar el funcionamiento de Flutter mediante una aplicación sencilla, funcional y adaptable a diferentes tamaños de pantalla.

## Funcionalidades principales

La aplicación cuenta con las siguientes funcionalidades:

### 1. Pantalla de inicio

Al ingresar a la aplicación se muestra un panel principal con información general sobre el inventario.

En esta sección se pueden consultar tres datos importantes:

- **Total de productos:** cantidad de referencias registradas en el inventario.
- **Unidades disponibles:** suma de las existencias de todos los productos.
- **Valor del inventario:** cálculo del valor estimado de los productos registrados, expresado en colones costarricenses (₡).

También se incluyen accesos para consultar el inventario o registrar nuevos productos.

### 2. Consulta del inventario

Esta sección permite visualizar los productos registrados y consultar su información.

Cada producto contiene los siguientes datos:

- Nombre.
- Cantidad disponible.
- Precio unitario.
- Categoría.

Los productos pueden filtrarse según su categoría: Electrónica, Ropa, Alimentos, Herramientas, Papelería y Otros.

Además, se implementaron dos formas de visualizar la información:

**Vista de tarjetas:** presenta los productos de manera individual y está pensada principalmente para pantallas pequeñas, como las de los teléfonos.

**Vista de tabla:** permite consultar los productos en filas y columnas, facilitando la revisión de varios registros.

Desde esta sección también es posible editar o eliminar productos. Antes de eliminar un registro, la aplicación solicita una confirmación para evitar eliminaciones accidentales.

### 3. Registro y edición de productos

La aplicación incluye un formulario que se utiliza tanto para agregar nuevos productos como para modificar los existentes.

El formulario solicita el nombre, la cantidad, el precio y la categoría del producto.

Para evitar registros incorrectos, se implementaron algunas validaciones:

- El nombre no puede estar vacío.
- La cantidad debe ser un número entero mayor o igual a cero.
- El precio debe ser un número mayor o igual a cero.
- Es obligatorio seleccionar una categoría.

Después de registrar o modificar un producto, la aplicación muestra un mensaje indicando el resultado de la operación.

### 4. Actualización del inventario

Una de las características del proyecto es que los cambios realizados se reflejan en la interfaz sin necesidad de actualizar manualmente la pantalla.

Por ejemplo, cuando se registra un producto, se actualiza la lista del inventario y también cambian los indicadores de la pantalla principal.

Para esta primera versión se utiliza una lista de productos almacenada en memoria. Esto permite demostrar las operaciones de crear, consultar, actualizar y eliminar registros (CRUD) sin necesidad de configurar una base de datos.

**Importante:** al trabajar con almacenamiento en memoria, los cambios no se conservan de forma permanente cuando se reinicia la aplicación.

## Tecnologías utilizadas

| Tecnología | Utilización |
|---|---|
| Flutter | Desarrollo de la interfaz y funcionamiento general de la aplicación. |
| Dart | Lenguaje de programación utilizado. |
| Material Design | Componentes visuales, formularios, botones y navegación. |
| Visual Studio Code | Entorno de desarrollo. |
| Microsoft Edge | Ejecución y pruebas de la versión web. |

## Estructura del proyecto

El código fuente se organizó en diferentes carpetas para facilitar su comprensión y mantenimiento.

```text
lib/
├── main.dart
├── models/
│   └── product.dart
├── screens/
│   ├── home_screen.dart
│   └── product_form_screen.dart
├── theme/
│   └── app_colors.dart
└── widgets/
    └── product_card.dart
```

La función de los archivos principales es la siguiente:

- `main.dart`: inicia la aplicación y establece su configuración general.
- `product.dart`: define la estructura de los productos.
- `home_screen.dart`: contiene la pantalla principal, las estadísticas y el inventario.
- `product_form_screen.dart`: permite registrar y editar productos.
- `app_colors.dart`: contiene los colores utilizados en la interfaz.
- `product_card.dart`: define el diseño de las tarjetas de productos.

Esta organización permite separar las diferentes responsabilidades del código y facilita la realización de cambios.

## Cómo ejecutar el proyecto

Para ejecutar la aplicación es necesario tener instalado Flutter y contar con un editor de código compatible, como Visual Studio Code.

### 1. Abrir el proyecto

Abrir la carpeta del proyecto en Visual Studio Code y acceder a la terminal.

### 2. Instalar las dependencias

Ejecutar el siguiente comando:

```bash
flutter pub get
```

Este comando descarga las dependencias necesarias para ejecutar el proyecto.

### 3. Ejecutar la aplicación

Para iniciar la aplicación desde Microsoft Edge:

```bash
flutter run -d edge
```

Una vez finalizada la compilación, la aplicación se abrirá en el navegador.

### 4. Probar la vista móvil

Aunque la aplicación se esté ejecutando en un navegador, también es posible comprobar cómo se adapta a una pantalla de teléfono.

Para hacerlo desde Microsoft Edge:

1. Abrir las herramientas de desarrollador con `F12`.
2. Activar la vista de dispositivos móviles mediante `Ctrl + Shift + M`.
3. Seleccionar un dispositivo o ajustar manualmente las dimensiones de la pantalla.
4. Navegar por la aplicación y comprobar el comportamiento de sus componentes.

### 5. Generar una aplicación para Android

Si se cuenta con el entorno de desarrollo Android configurado, se puede generar un archivo APK utilizando:

```bash
flutter build apk --release
```

El archivo generado se encontrará en:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Alcance y limitaciones

Este proyecto corresponde a un **producto mínimo viable (MVP)**, por lo que se desarrollaron las funcionalidades necesarias para demostrar el uso de Flutter en una aplicación de inventario.

La versión actual permite realizar operaciones CRUD, validar formularios, consultar estadísticas y visualizar los productos de diferentes maneras.

Sin embargo, todavía existen algunas funcionalidades que podrían incorporarse en futuras versiones, como:

- Almacenamiento permanente mediante una base de datos.
- Inicio de sesión y administración de usuarios.
- Registro de entradas y salidas de mercadería.
- Búsqueda de productos por nombre.
- Generación de reportes del inventario.

Estas mejoras permitirían ampliar el proyecto y acercarlo al funcionamiento de un sistema de inventario utilizado en una empresa.

## Objetivo académico

El propósito de este proyecto es poner en práctica los conocimientos adquiridos durante la investigación sobre Flutter.

Mediante su desarrollo se busca demostrar cómo funciona la creación de interfaces, la navegación entre pantallas, el manejo de formularios, las validaciones y la actualización de información dentro de una aplicación.

También permite observar cómo Flutter facilita el desarrollo de aplicaciones que pueden adaptarse a diferentes plataformas utilizando una misma base de código.

---

**Universidad de Costa Rica – Sede del Pacífico**

Carrera: Informática Empresarial

Curso: Desarrollo de Software IV

Proyecto: Investigación y demostración práctica de Flutter

Año: 2026
