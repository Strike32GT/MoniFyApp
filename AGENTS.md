# Guía de agentes para Monify

## Propósito

Estas instrucciones aplican a todo el repositorio. Antes de modificar código, identifica el subsistema afectado, revisa su implementación actual y carga por completo las skills correspondientes. No presentes funcionalidades planificadas como si ya estuvieran implementadas.

## Mapa del repositorio

- `monify_app_mobile/`: cliente Flutter. Usa capas `presentation`, `domain` y `data`; actualmente obtiene datos de `LocalAppStore`.
- `Backend-Monify/Backend/`: API Django REST organizada en `users`, `expenses` y `gamification`.
- `.agents/skills/`: instrucciones especializadas disponibles para los agentes.
- `README.md`, `ARQUITECTURA.md`, `MOBILE-PATTERNS.md` y `BACKEND-STRUC.md`: fuentes de contexto técnico y funcional.

## Selección de skills

Usa el conjunto mínimo que cubra la tarea. Si una solicitud cruza áreas, combina las skills pertinentes.

| Tipo de tarea | Skill obligatoria | Combinar cuando corresponda |
| --- | --- | --- |
| Crear o refactorizar capas Flutter | `flutter-apply-architecture-best-practices` | `flutter-add-widget-test`, `fullstack-code-quality` |
| Diseñar UI adaptable o corregir overflows | `flutter-build-responsive-layout` | `flutter-add-widget-test` |
| Probar un widget o interacción aislada | `flutter-add-widget-test` | `fullstack-code-quality` |
| Automatizar un flujo Flutter completo | `flutter-add-integration-test` | `api-load-testing` solo si también se mide la API |
| Cambiar modelos, serializers, views, permisos o migraciones Django | `django-drf-backend` | `fullstack-code-quality` |
| Revisar análisis estático, formato, pruebas o mantenibilidad | `fullstack-code-quality` | La skill del subsistema revisado |
| Diseñar o ejecutar carga sobre endpoints | `api-load-testing` | `django-drf-backend` |
| Buscar una capacidad que no existe localmente | `find-skills` | Usar únicamente tras comprobar que ninguna skill instalada cubre la necesidad |

## Reglas del proyecto

- Conserva la dirección de dependencias Flutter: presentación → dominio → datos. La UI no debe acceder directamente a services ni a `LocalAppStore`.
- Mantén Views y Widgets centrados en renderizado e interacción; coloca estado en ViewModels/providers y reglas reutilizables en casos de uso.
- En Django, mantén cada cambio dentro de la app de dominio correspondiente y acompaña los cambios de modelo con migraciones versionadas.
- Trata toda operación autenticada como aislada por usuario. No expongas ni permitas modificar recursos de otro usuario.
- Nunca confirmes una integración Flutter–Django basándote solo en la existencia de endpoints: verifica que los services móviles realicen solicitudes de red.
- No incluyas secretos, tokens, bases locales, entornos virtuales ni artefactos de compilación en Git.
- No edites `skills-lock.json` manualmente para skills locales. Ese archivo registra las skills externas instaladas.
- Actualiza la documentación arquitectónica cuando una modificación cambie capas, persistencia, entidades o límites entre módulos.

## Verificación mínima

- Flutter: ejecutar `flutter analyze` y las pruebas relevantes con `flutter test`.
- Django: con las dependencias instaladas, ejecutar `python manage.py check` y `python manage.py test`.
- Skills nuevas o modificadas: ejecutar el validador de `skill-creator` sobre cada directorio.
- Documentación: comprobar enlaces relativos, rutas de imágenes y bloques Mermaid.

Los avisos preexistentes deben informarse por separado. No amplíes una tarea para corregirlos salvo que el usuario solicite calidad, refactorización o su corrección explícita.

