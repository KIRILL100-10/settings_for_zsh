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

### 🐍 Python & Docker Automation
* **`runpy [file]`** – Smart Python runner. Executes the specified file, or automatically falls back to `main.py` / `app.py` if no file is provided.
* **`va`** – Fast-activates your local Python virtual environment (`.venv`).
* **`checkdocker [file]`** – Lints your Dockerfile using `hadolint` to catch bad practices.
* **`drawdocker [file]`** – Generates and automatically opens a visual PNG graph architecture of your Dockerfile using `dockerfilegraph`.

### 🛡️ Git, C++, & Project Scaffolding
* **`checkcpp [path]`** – Runs deep, conclusive static analysis for C/C++ projects using `cppcheck`.
* **`makeignore <tech>`** – Instantly generates official boilerplate `.gitignore` files via `add-gitignore`.
* **`tomd <file>`** / **`toword <file>`** – Rapid bi-directional document conversion between Markdown and Word (`.docx`) using `pandoc`.

### 🌐 Web Servers & Development
* **`liveserver`** – Spins up a hot-reloading dev server for Frontend (`html`, `css`, `js`, `vue`) via `browser-sync`.
* **`staticserver [port]`** – Launches a quick Python HTTP server (default port `5000`) and automatically opens it in your browser.

## ⚡ Supercharged Aliases

* `venv` – Instantly creates and activates a local `.venv` environment.
* `migrations` – Groups Django `makemigrations` and `migrate` into one fast command.
* `dclean` – Nukes unused Docker cache, volumes, container images, and networks.
* `myos` – Displays clean system hardware specs using `fastfetch`.
* `mygit` – Displays project specs using `onefetch`.
* `k8s-start` – Initializes your lightweight Kubernetes (`k3s`) cluster on demand and verifies node status.
* `k8s-stop` – Stops the Kubernetes cluster completely and releases system RAM from background daemons.
* `k8s-status` – Checks the active `systemd` runtime logs and process state of the `k3s` server.
* `updatezsh` - Updates the Powerlevel10k configuration.

## 📄 License
This project is licensed under the MIT License — feel free to use, modify, and distribute it!
