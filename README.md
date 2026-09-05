<p align="center">
  <img src="img/Monify_Logo.png" alt="Logo de Monify" width="220">
</p>

<h1 align="center">Monify</h1>

<p align="center">
  Una aplicación móvil para registrar movimientos, comprender hábitos financieros y fomentar el ahorro.
</p>

## ¿Qué es Monify?

Monify es un proyecto de educación y control financiero personal. Su propósito es ayudar a las personas a registrar ingresos y gastos, revisar su balance, comparar sus consumos con un presupuesto y mantener buenos hábitos mediante estadísticas, rachas y logros.

Está dirigido principalmente a estudiantes, jóvenes y personas que desean comenzar a organizar sus finanzas desde una experiencia móvil sencilla y visual.

## Funcionalidades

- Registro e inicio de sesión de usuarios.
- Registro y clasificación de ingresos y gastos.
- Resumen diario y estadísticas de movimientos.
- Presupuesto personal expresado en una moneda configurable.
- Historial, búsqueda y filtros de transacciones.
- Rachas y logros para reforzar hábitos financieros.
- Temas claro y oscuro en la interfaz móvil.

> [!IMPORTANT]
> El cliente Flutter se encuentra en fase de prototipo y actualmente usa `LocalAppStore`, un almacenamiento temporal en memoria. La API Django existe en el mismo repositorio, pero todavía no está conectada al cliente móvil; los datos se pierden al reiniciar la aplicación.

## Tecnologías

| Área | Tecnologías |
| --- | --- |
| Aplicación móvil | Flutter, Dart, Material Design |
| API | Python, Django 6, Django REST Framework |
| Autenticación del backend | JSON Web Tokens mediante Simple JWT |
| Datos | SQLite en desarrollo y PostgreSQL cuando se define `DATABASE_URL` |
| Despliegue del backend | Gunicorn y WhiteNoise |

## Estructura del repositorio

```text
MoniFyApp/
├── monify_app_mobile/     # Cliente Flutter
├── Backend-Monify/        # API Django REST
├── .agents/skills/        # Skills locales y dependencias de agentes
├── img/                   # Recursos gráficos de la documentación
├── AGENTS.md              # Reglas de trabajo y selección de skills
├── ARQUITECTURA.md        # Arquitectura integral del sistema
├── BACKEND-STRUC.md       # Modelo de datos y procesos del backend
└── MOBILE-PATTERNS.md     # Patrones usados en Flutter
```

## Inicio rápido

### Aplicación Flutter

Requiere Flutter compatible con Dart `^3.11.1`.

```bash
cd monify_app_mobile
flutter pub get
flutter run
```

Para ejecutar la prueba disponible:

```bash
flutter test
```

### API Django

Requiere Python compatible con Django 6. Se recomienda trabajar en un entorno virtual.

```bash
cd Backend-Monify/Backend
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

Sin `DATABASE_URL`, Django utiliza `db.sqlite3`. En producción, `DATABASE_URL` debe apuntar a PostgreSQL. Las credenciales y secretos deben configurarse mediante variables de entorno y nunca versionarse.

## Documentación

- [Arquitectura general](ARQUITECTURA.md)
- [Patrones de la aplicación móvil](MOBILE-PATTERNS.md)
- [Estructura y procesos del backend](BACKEND-STRUC.md)
- [Guía para agentes y selección de skills](AGENTS.md)

## Autoría

Idea original y desarrollo por **Roberto Mas**, [Strike32GT](https://github.com/Strike32GT).

