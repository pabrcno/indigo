# Indigo Challenge - Flutter Web Project

### Demo en Vivo

Puedes probar la aplicación directamente en el siguiente enlace:  
[Indigo Challenge - Demo en Vivo](https://indigo-challenge-21-11-24.web.app/)

## Cómo Descargar e Instalar el Proyecto

Para comenzar con el proyecto, sigue estos pasos:

1. **Clona el repositorio**:

   ```bash
   git clone https://github.com/pabrcno/indigo.git
   cd indigo_challenge
   ```

2. **Instala las dependencias**:
   Ejecuta el siguiente comando para instalar las dependencias necesarias:

   ```bash
   flutter pub get
   ```

3. **Genera el código necesario**:
   Si deseas regenerar el codigo necesario para correr la app (incluido por default), ejecuta:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

   Este comando asegura que cualquier archivo generado sea actualizado sin conflictos.

4. **Inicia el proyecto**:
   Inicia la aplicación web localmente con el siguiente comando:

   ```bash
   flutter run -d chrome
   ```

---

## Dependencias

A continuación, se detallan las dependencias principales utilizadas en el proyecto y las razones detrás de su elección:

### 1. **Drift: `^2.21.0`**

Drift se seleccionó como la solución de base de datos local debido a sus capacidades de ORM typesafe. Permite:

- Consultas SQL seguras y eficientes.
- Manejo de datos typesafe de punta a punta.
- Una integración sencilla con Flutter Web.

### 2. **Riverpod: `^2.6.1`**

Riverpod es el paquete elegido para el manejo de estados y la inyección de dependencias mediante providers. Ofrece:

- Una estructura predecible y escalable.
- Eficiencia en la administración de estados complejos.
- Compatibilidad con buenas prácticas como SOLID.

### 3. **Freezed: `^2.5.7`**

Freezed se utiliza para la generación automática de modelos inmutables y typesafe, simplificando:

- La creación de clases de datos.
- La serialización y deserialización necesaria para gestionar datos complejos.

### 4. **FL Chart: `^0.69.0`**

FL Chart se incluye para la representación gráfica de métricas y estadísticas. Es ideal debido a:

- Su flexibilidad y facilidad de personalización.
- Su compatibilidad con Flutter Web y otros dispositivos.

---

## Descripción General

Este proyecto implementa una aplicación web utilizando Flutter Web, basada en el desafío planteado para desarrollar tres pantallas completamente responsivas. Dos de estas pantallas son interactivas: la búsqueda de pacientes y el perfil del paciente.

### Referencia al Diseño

El diseño inicial se basó en el prototipo de Figma proporcionado: [Indigo Challenge Figma](https://www.figma.com/design/jf06l7GcsarFXMsuLMH3Bg/Indigo---Challenge---Web?node-id=3-6&node-type=canvas&t=oNjHIVxGzRWZEkLT-0). Sin embargo, debido a inconsistencias en el diseño y la ausencia de una versión responsiva, decidí tomarme la libertad creativa para reimaginar el diseño, respetando los principios visuales y funcionales del prototipo.

### Arquitectura del Proyecto

El enfoque utilizado se basa en una versión simplificada de **Domain-Driven Design (DDD)**, con una separación clara en las siguientes capas:

- **db**: Manejo de la base de datos.
- **models**: Definición de los tipos de datos internos utilizados en la aplicación.
- **presentation**: Widgets y pantallas responsables de la interfaz de usuario.
- **providers**: Manejo de estado e inyección de dependencias mediante Riverpod.

Se utilizan exclusivamente los tipos de datos internos definidos en `models` como comunicadores entre las capas, junto con interfaces y el uso de DI (Dependency Injection) para lograr una arquitectura altamente desacoplada.

### Modelado de Datos

El modelado de datos se inspiró en el prototipo de Figma, diseñándolos con un enfoque en la extensibilidad.

Por ejemplo, el tipo **PatientHealthMetric** es central en la aplicación y permite manejar información clave:

```dart
class PatientHealthMetric {
    required int patientId, // Foreign key
    required EPatientHealthMetricField metricType,
    required double value, // Value of the metric
    required DateTime createdAt, // Timestamp for when the metric was recorded
}
```

El uso de `EPatientHealthMetricField` permite extender los tipos de métricas guardadas en el futuro de manera fácil y eficiente.

### Testing

Se implementaron pruebas unitarias para la mayoría de los componentes, unidades lógicas y providers, con las siguientes excepciones:

- **Implementaciones triviales**.
- **Pantallas dependientes de providers**, ya que el uso de Drift Web introduce dependencias con `dart:js_interop`. Esto, aunque no es utilizado directamente en las capas superiores, termina afectando el entorno de pruebas debido a su incompatibilidad con la VM utilizada por `flutter test`. Como resultado, los tests que dependen de Drift Web no pueden ejecutarse en este entorno.

---

## Checks y Extras

### Cumplimiento de Requerimientos Básicos

✔️ **Funcionalidad**: Todas las funcionalidades requeridas en el desafío están implementadas según los prototipos proporcionados, con ajustes para mayor robustez y usabilidad.  
✔️ **Diseño**: Se implementó un diseño moderno y limpio basado en el prototipo de Figma, con mejoras creativas para solucionar inconsistencias y adaptar la interfaz a un diseño responsivo.  
✔️ **Calidad de Código**: El proyecto sigue principios SOLID, aplica clean code, y utiliza una arquitectura simplificada de DDD (Domain-Driven Design) para lograr desacoplamiento y escalabilidad.  
✔️ **Diseño Responsivo**: Todas las pantallas son completamente responsivas, adaptándose a diversos tamaños de pantalla, desde dispositivos móviles hasta desktop.  
✔️ **Pruebas Unitarias y de Widgets**: Se implementaron pruebas en componentes clave, incluyendo lógica de negocio y providers. Sin embargo, debido a limitaciones técnicas con `drift web` y `dart:js_interop`, no se pudieron testear pantallas que dependen de providers.

### Innovación y Valor Añadido

✨ **Componentes Interactivos**: Se añadieron gráficos interactivos utilizando `fl_chart` para visualizar el historial de métricas de los pacientes. Esto mejora significativamente la experiencia del usuario, proporcionando una representación clara y atractiva de los datos.  
✨ **Diseño Fresco y Amable**: El diseño reimaginado tiene un enfoque más limpio y moderno, haciendo que la interfaz sea más agradable y fácil de usar.  
✨ **Extensibilidad de Datos**: La estructura de datos diseñada permite agregar fácilmente nuevas métricas de salud, mejorando la sostenibilidad y escalabilidad del proyecto.
