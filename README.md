# Segmentacion Inteligente de Clientes mediante Modelo RFM y K-Means
### Proyecto de Mineria de Datos y Business Intelligence - Taller Donald
**Desarrollado por:** Cristian Chamo  
**Institucion:** Universidad Mariano Galvez de Guatemala (UMG)  
**Facultad:** Ingenieria en Sistemas de Informacion y Ciencias de la Computacion  

---

## Descripcion del Proyecto

Este proyecto implementa una solucion integral de Ciencia de Datos y Mineria de Datos para automatizar la clasificacion de la base de clientes de Taller Donald (base de datos DonaldV2). 

Utilizando el estandar de la industria RFM (Recencia, Frecuencia y Valor Monetario), los datos transaccionales crudos fueron extraidos, normalizados y procesados mediante el algoritmo de Machine Learning K-Means (Aprendizaje No Supervisado) en un entorno interactivo de Jupyter Notebook. 

Finalmente, los patrones ocultos descubiertos por la Inteligencia Artificial fueron exportados a Power BI Desktop, consolidando un Dashboard Ejecutivo multi-pagina disenado especificamente para que la gerencia pueda disenar estrategias de marketing directo de alta precision en el mercado guatemalteco.

---

## Objetivos

1. Estructurar un pipeline ETL: Construir una consulta SQL optimizada para consolidar el comportamiento historico de cada cliente unico.
2. Justificar Matematicamente los Segmentos: Utilizar el Metodo del Codo (Elbow Method) para hallar el numero ideal de clusters basados en la inercia interna de los datos.
3. Modelar con Machine Learning: Implementar el algoritmo K-Means para segmentar la base de datos de manera automatizada y dinamica.
4. Habilitar Business Intelligence (BI): Disenar un tablero interactivo en Power BI que permita aislar los grupos y obtener listas de accion inmediata para campanas de retencion y fidelizacion.

---

## Arquitectura Tecnologica y Stack

* Base de Datos: SQL Server (DonaldV2) empleando procedimientos de agregacion temporal.
* Lenguaje de Programacion: Python 3.13.5 dentro de un entorno virtualizado.
* IDE de Desarrollo: Visual Studio Code con la extension interactiva de Jupyter Notebooks.
* Librerias Clave (Python): pandas, numpy, pyodbc, scikit-learn (StandardScaler y KMeans), matplotlib y seaborn.
* Herramienta de BI: Power BI Desktop para el modelado visual y analisis de KPIs corporativos.

---

## Componentes del Codigo y Proceso Paso a Paso

El proyecto se divide de forma modular en 6 fases criticas ejecutadas de forma secuencial dentro del cuaderno analitico:

### 1. Configuracion del Entorno (Celda 1)
Se inicializan las librerias cientificas necesarias y se define un entorno visual limpio mediante parametros globales de seaborn para asegurar la legibilidad de los reportes embebidos.

### 2. Extraccion Transaccional y Matriz RFM (Celda 2)
Se establece un puente seguro mediante pyodbc hacia el servidor local. La consulta unifica miles de registros historicos calculando:
* Recencia (R): Dias transcurridos entre la ultima orden de trabajo documentada y la fecha de corte actual.
* Frecuencia (F): Conteo de visitas unicas / ordenes de trabajo por cliente.
* Valor Monetario (M): Suma total de los ingresos generados por mano de obra y consumo de repuestos/materiales.

### 3. Preprocesamiento y Escalamiento de Variables (Celda 3)
Dado que K-Means se basa en el calculo de distancias euclidianas, diferencias de magnitudes (ej. Q150,000.00 frente a 30 dias) sesgarian por completo el algoritmo. Se implementa StandardScaler para estandarizar las columnas bajo una escala comun con media 0 y desviacion estandar 1:

$$Z = \frac{x - \mu}{\sigma}$$

### 4. Determinacion del K Optimo via Metodo del Codo (Celda 4)
Se simulan de manera iterativa escenarios desde 1 hasta 6 clusters, extrayendo la Inercia / WCSS (Suma de cuadrados internos). Al graficar los resultados, se evidencia un punto de inflexion drastico en k=3, estabilizandose la curva a partir de ahi. Esto justifica matematicamente que 3 es la cantidad optima de clusters para evitar la sobresegmentacion.

### 5. Entrenamiento del Modelo y Logica Dinamica (Celda 5)
Se instancia el modelo definitivo de KMeans(n_clusters=3). Para evitar que el orden aleatorio de los indices numericos (0, 1, 2) rompa el mapeo al actualizar los datos en el futuro, el codigo analiza automaticamente los centroides promedio:
* El grupo con el mayor Valor Monetario se etiqueta de forma dinamica como: Clientes VIP (Alto Valor).
* El grupo con la mayor Recencia se etiqueta de forma dinamica como: Clientes en Riesgo de Abandono.
* El cluster restante se define como: Clientes Esporadicos (Ticket Medio).

### 6. Analisis Estadistico y Exportacion (Celda 6)
Genera un informe rapido en consola con el porcentaje exacto de participacion de mercado de cada grupo y exporta de manera limpia el archivo TallerDonald_Final.csv.

---

## Diseno del Dashboard en Power BI

Para maximizar el impacto de la entrega, los datos se organizan de forma limpia y desagregada en un informe de 3 pestanas de control, evitando errores comunes de agregacion de metricas:

### Pagina 1: Resumen Ejecutivo
Disenada para la alta gerencia. Muestra el estado macro de salud del taller:
* Grafico de Dona (Distribucion): Muestra los porcentajes reales de participacion del cliente utilizando CodigoCliente en modalidad Recuento Distintivo (eliminando errores de suma de IDs).
* Grafico de Barras Agrupadas (Ingresos): Suma el ValorMonetario total por cada categoria para identificar de que grupo proviene el flujo de caja dominante (Demostracion empirica de la Ley de Pareto 80/20).

### Pagina 2: Analisis de Clusters
Muestra el respaldo analitico del modelo de Inteligencia Artificial:
* Grafico de Dispersion (Scatter Chart): Mapea cada cliente individual como un punto unico en el plano bidimensional empleando NombreCompleto en los Detalles, Recencia (Eje X) y ValorMonetario (Eje Y) configurados bajo la propiedad No resumir/Minimo. La variable Categoria_Final actua como Leyenda, pintando las 3 nubes de puntos calculadas por la IA.

### Pagina 3: Plan de Accion Comercial
Modulo netamente operativo para la toma de decisiones:
* Un Segmentador de Datos (Slicer) conectado a Categoria_Final.
* Una Tabla Detallada (NombreCompleto, Recencia, Frecuencia, ValorMonetario en modo No Resumir). Al pulsar cualquier boton del filtro (ej. Clientes en Riesgo), la tabla se aisla de inmediato para entregarle al departamento de mercadeo un listado con nombres exactos para ejecutar campanas directas de reactivacion.

---

## Conclusiones del Estudio

* La Ley de Pareto se cumple: El cluster definido como VIP, a pesar de representar una de las proporciones mas pequenas en cantidad de clientes individuales, acumula el mayor impacto en el volumen total de facturacion de Taller Donald.
* Mitigacion del Churn: La identificacion masiva del segmento En Riesgo abre una ventana de oportunidad critica para frenar el abandono de clientes historicos mediante incentivos directos (cupones de mantenimiento o diagnosticos gratis).

---
### Desarrollado por:
* Cristian Eduardo Chamo Morales
* Keily Atalia Lopez Hernandez
* Delmy Maria Fajardo Borrayo

---
### Universidad Mariano Galvez de Guatemala sede Jalapa, Jalapa