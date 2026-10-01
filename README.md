# My Fedora Zsh Configuration 🚀

An optimized, feature-rich, and automation-heavy `.zshrc` configuration designed specifically for Fedora Linux. It focuses on developer velocity, media conversion, and system cleaning with helpful visual feedback.

## 🛠️ Functions

### 🎥 Media & Audio Processing (`ffmpeg` & `demucs`)
* **`tomov <file>`** – Converts video into high-quality Avid DNxHD/DNxHR (`dnxhr_hqx`) with 10-bit color and 24-bit audio for professional editing.
* **`tomp4 <file>`** – Converts video into highly compatible H.264 MP4 format (`crf 20`) with AAC audio.
* **`extsound <file>`** – Extracts and strips audio from video tracks into a clean 16-bit WAV file (`pcm_s16le`).
* **`towav <file>`** – Converts an input file's audio track into studio-standard 24-bit 48kHz WAV format (`pcm_s24le`).
* **`splitaudio <file>`** – Splits audio into 4 separate stems (vocals, drums, bass, other) using AI via `demucs` with CUDA hardware acceleration.
* **`checkmedia <file>`** – Runs deep technical analysis of video or audio metadata using `mediainfo` to verify codecs, containers, and precise frame rates.

### 🐍 Python & Docker
* **`runpy [file]`** – Smart Python runner. Executes the specified file, or automatically falls back to `main.py` / `app.py` if no file is provided.
* **`va`** – Fast-activates your local Python virtual environment (`.venv`).
* **`checkdocker [file]`** – Lints your Dockerfile using `hadolint` to catch bad practices.

### 🛡️ C++ sh
* **`checkcpp [path]`** – Runs deep, conclusive static analysis for C/C++ projects using `cppcheck`.
* **`checkshell [path]`** – Runs  analysis for shell scripts using `shellcheck`.

## ⚡ Supercharged Aliases

* `venv && va` – Instantly creates and activates a local `.venv` environment.
* `dclean` – Nukes unused Docker cache, volumes, container images, and networks.
* `myos` – Displays clean system hardware specs using `fastfetch`.
* `mygit` – Displays project specs using `onefetch`.
* `updatezsh` - Updates the Powerlevel10k configuration.
* `update-all` - Updates all packages.

## 📄 License
This project is licensed under the MIT License — feel free to use, modify, and distribute it!
