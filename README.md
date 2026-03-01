# 🛡️ Pixelado de caras automático (AI Face Anonymizer)

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

---

## <img src="https://raw.githubusercontent.com/lipis/flag-icons/main/flags/4x3/es.svg" width="20"> Castellano

Herramienta de alta seguridad para la protección de datos que detecta y destruye la información facial en fotos y vídeos de forma **totalmente irreversible**. Profesional, rápida y fácil de usar.

### ✨ Características
- **Seguridad Garantizada:** Pixelado mosaico destructivo e irreversible. Elimina físicamente la información original.
- **Multiformato:**  
  - **Fotos:** `.jpg`, `.jpeg`, `.png`, `.bmp`, `.webp`, `.tiff`, `.avif`, `.jfif`, etc.  
  - **Vídeos:** `.mp4`, `.webm`, `.avi`, `.mov`, `.mkv`, `.mpeg`, `.wmv`, `.flv`, etc.
- **Precisión IA:** Basado en YOLOv8 con 5 tamaños de modelo.
- **Preservación de Audio:** Mantiene la pista de audio original mediante FFmpeg.
- **Bilingüe:** Interfaz y registros en Castellano e Inglés.

### ⚙️ Configuración (config.ini)
El archivo `config.ini` se crea automáticamente la primera vez que arrancas el programa.

- `model_size`: Selección del modelo (n: Nano, s: Small, m: Medium, l: Large, x: Extra Large).
- `blocks_across`: Resolución del pixelado (10 recomendado para mayor seguridad).
- `box_padding`: Margen extra alrededor de la cara (0.25 = 25% extra).
- `video_crf`: Calidad de compresión (18: alta, 23: media, 28: baja).
- `min_confidence`: Sensibilidad de la IA (0.0 a 1.0).

### 🚀 Inicio Rápido
1. **Instalar Python:** [Python 3.10+](https://www.python.org/downloads/).
2. **Requisitos:** 
   ```bash
   pip install -r requirements.txt
   ```
3. **Uso:** 
   - Coloca tus archivos en la carpeta del programa.
   - Ejecuta: `python pixelado_caras_automatico.py`
   - Los resultados estarán en la carpeta `/anonymized`.

### 📦 Modelos Offline
Si quieres descargar todos los modelos de golpe para usarlos sin internet o distribuirlos:
```bash
python descargar_modelos.py
```

### ⚖️ Licencia
Este software se distribuye bajo la licencia **GNU Affero General Public License v3.0 (AGPL-3.0)**.

### 📝 Notas de Seguridad
- El pixelado es de 12 bloques fijos, garantizando el anonimato sin importar la resolución.
- El proceso es **destructivo**: los píxeles originales se eliminan y no pueden recuperarse.

---

## <img src="https://raw.githubusercontent.com/lipis/flag-icons/main/flags/4x3/gb.svg" width="20"> British English

High-security tool for data protection that detects and destroys facial information in photos and videos in a **completely irreversible** way. Professional, fast, and easy to use.

### ✨ Features
- **Guaranteed Security:** Destructive mosaic pixelation. Physically removes original information.
- **Multiformat:** Supports all major photo and video formats (`.jpg`, `.mp4`, `.webm`, etc.).
- **AI Precision:** Powered by YOLOv8 with 5 different model sizes.
- **Audio Preservation:** Keeps original audio track using FFmpeg.
- **Bilingual:** Interface and logs in English & Spanish.

### ⚙️ Configuration (config.ini)
The `config.ini` file is created automatically on the first run.

- `model_size`: AI model selection (n, s, m, l, x).
- `blocks_across`: Number of blocks for pixelation (10 is recommended).
- `box_padding`: Margin around the face.
- `video_crf`: Video compression quality.
- `min_confidence`: AI detection sensitivity.

### 🚀 Quick Start
1. **Install Python:** [Python 3.10+](https://www.python.org/downloads/).
2. **Requirements:** 
   ```bash
   pip install -r requirements.txt
   ```
3. **Usage:** 
   - Place your files in the program folder.
   - Run: `python pixelado_caras_automatico.py`
   - Results will be in the `/anonymized` folder.

### 📦 Offline Models
To download all models at once for offline use or redistribution:
```bash
python descargar_modelos.py
```

### ⚖️ License
Licensed under the **GNU Affero General Public License v3.0 (AGPL-3.0)**.

### 📝 Safety Notes
- Fixed 12-block pixelation ensures consistent anonymity regardless of image resolution.
- This process is **destructive**: original pixels are deleted and cannot be recovered.
