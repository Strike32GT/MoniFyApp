# Estructura de datos y procesos del backend

## Modelo vigente

El backend es una API Django REST dividida en tres módulos de dominio: `users`, `expenses` y `gamification`. El siguiente diagrama representa exclusivamente los modelos que existen actualmente.

```mermaid
erDiagram
    USER ||--o{ TRANSACTION : registra
    CATEGORY ||--o{ TRANSACTION : clasifica
    USER ||--o{ USER_ACHIEVEMENT : obtiene
    ACHIEVEMENT ||--o{ USER_ACHIEVEMENT : corresponde
    USER ||--o| STREAK : mantiene

    USER {
        int id PK
        string nombre
        string correo UK
        string password
        string rol
        string avatar
        decimal presupuesto
        string moneda
        int nivel
        int xp_actual
        int mejor_racha
        datetime fecha_creacion
    }

    CATEGORY {
        int id PK
        string nombre
        string icono
        string color
    }

    TRANSACTION {
        int id PK
        int user_id FK
        int category_id FK
        string tipo
        decimal monto
        string descripcion
        datetime fecha
    }

    ACHIEVEMENT {
        int id PK
        string nombre
        string descripcion
        string icono
    }

    USER_ACHIEVEMENT {
        int id PK
        int user_id FK
        int achievement_id FK
        boolean desbloqueado
        datetime fecha
    }

    STREAK {
        int id PK
        int user_id FK, UK
        int racha_actual
        int mejor_racha
        date ultima_fecha
    }
```

## Entidades

- **User:** contiene identidad, rol, presupuesto, moneda y progreso general. El correo es único.
- **Category:** catálogo visual usado para clasificar movimientos.
- **Transaction:** ingreso o gasto asociado obligatoriamente a un usuario y una categoría.
- **Achievement:** definición reutilizable de un logro.
- **UserAchievement:** relación entre usuarios y logros, junto con su estado y fecha de desbloqueo.
- **Streak:** racha financiera de un usuario. La relación uno a uno garantiza como máximo una racha por usuario.

Las relaciones hacia `User`, `Category` y `Achievement` usan borrado en cascada. Eliminar una entidad principal elimina también sus registros relacionados.

## Ahorro y hábitos financieros

El ahorro no es una tabla. Es una métrica derivada para un periodo:

```text
ahorro = suma de ingresos - suma de gastos
```

El endpoint de resumen diario ya aplica esa fórmula. El presupuesto se almacena en `User`, mientras que las rachas y los logros permiten representar constancia y buenas prácticas.

```mermaid
flowchart TD
    A[Usuario registra un movimiento] --> B{Tipo de movimiento}
    B -->|Ingreso| C[Acumular ingresos del periodo]
    B -->|Gasto| D[Acumular gastos y categoría]
    C --> E[Calcular ahorro: ingresos menos gastos]
    D --> E
    D --> F[Comparar gasto con presupuesto]
    E --> G{Ahorro no negativo}
    F --> H{Dentro del presupuesto}
    G -->|Sí| I[Marcar comportamiento favorable]
    G -->|No| J[Mostrar oportunidad de mejora]
    H -->|Sí| K[Actualizar racha]
    H -->|No| L[Reiniciar o conservar según la regla futura]
    I --> M[Evaluar criterios de logros]
    K --> M
    M --> N[Actualizar UserAchievement y progreso]
```

> [!NOTE]
> El cálculo del resumen diario sí está implementado. La evaluación automática del presupuesto, la política completa de rachas y el desbloqueo automático de logros todavía no forman un flujo transaccional único en el backend; el diagrama muestra la evolución funcional prevista.

## Persistencia por entorno

```mermaid
flowchart LR
    DJ[Django ORM] --> C{DATABASE_URL definida}
    C -->|No| SQ[(SQLite local)]
    C -->|Sí| PG[(PostgreSQL)]
```

- **Desarrollo local:** Django crea `db.sqlite3`, archivo excluido de Git.
- **Producción:** `dj-database-url` configura PostgreSQL mediante `DATABASE_URL`.
- **Archivos estáticos:** WhiteNoise sirve el contenido recolectado en `staticfiles`.

## Evolución prevista

- Conectar los services de Flutter con los endpoints REST y reemplazar el estado temporal.
- Integrar `users.User` formalmente con el sistema de autenticación de Django o sustituirlo por un modelo compatible. Actualmente no está declarado como `AUTH_USER_MODEL`, aunque las vistas protegidas y Simple JWT dependen de `request.user`.
- Asegurar que las consultas y mutaciones de transacciones siempre estén limitadas al usuario autenticado.
- Definir reglas atómicas para presupuesto, rachas, experiencia y desbloqueo de logros.
- Evaluar una entidad de meta de ahorro solamente cuando existan requisitos de importe, plazo y progreso histórico; no forma parte del esquema vigente.
- Añadir restricciones de unicidad para evitar logros duplicados por usuario y pruebas de permisos entre usuarios.
