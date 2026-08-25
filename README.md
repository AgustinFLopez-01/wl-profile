<!--
SPDX-FileCopyrightText: 2026 Gus F. López

SPDX-License-Identifier: GPL-3.0-or-later
-->

# WL-PROFILE

![Wayland](https://img.shields.io/badge/Wayland-000000?style=for-the-badge&logo=wayland&logoColor=white)
![Sway](https://img.shields.io/badge/Sway-68751C?style=for-the-badge&logo=sway&logoColor=white)
![Kanshi](https://img.shields.io/badge/Kanshi-monitor_profiles-blue?style=for-the-badge)
![CLI](https://img.shields.io/badge/CLI-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)

Script interactivo de Bash para generar perfiles para Kanshi en Sway/Wayland.

Permite seleccionar monitores, resoluciones, modos y posiciones automaticamente usando EDID.

## Caracteristicas implementadas actualmente

- Detección automática de monitores
- Soporte para EDID
- Generación automática de perfiles de Kanshi (únicamente un perfil a la vez)
- Selección interactiva de resoluciones mediante CLI
- Configuración de posiciones relativas de los monitores en cruz
- Recarga automática de Sway (con vistas a Wayland)

## Requisitos

- **Bash**
- **Sway**
- **Kanshi**
- **jq**

## Modo de uso

1. Clonar el repositorio y dar permisos de ejecución:
   ```bash
   git clone https://github.com/AgustinFLopez-01/wl-profile.git
   cd wl-profile
   chmod +x wl-profile.sh
   ```
2. Ejecutar el script interactivo:
   ```bash
   ./wl-profile.sh
   ```

[![asciicast](https://asciinema.org/a/Ck6nMnCxCCZrOcDk.svg)](https://asciinema.org/a/Ck6nMnCxCCZrOcDk)

## Contribución

¡Las contribuciones son bienvenidas! Consulta nuestra [Guía de Contribución](.github/CONTRIBUTING.md) para conocer la convención de commits, ramas y el flujo de trabajo con la rama `develop`.

## Licencia

Este proyecto se distribuye bajo la licencia **GNU General Public License v3.0**. Consulta el archivo [LICENSE](LICENSES/GPL-3.0-or-later.txt) para más detalles. Los comentarios acerca de la licencia usan el estandar SPDX.
