# My Manjaro Zsh Configuration 🚀

An optimized, feature-rich, and automation-heavy `.zshrc` configuration designed specifically for Manjaro Linux. It focuses on developer velocity, media conversion, and system cleaning with helpful visual feedback.

## 🛠️ Functions

### 🎥 Media & Audio Processing (`ffmpeg` & `demucs`)
* **`tomov <file>`** – Converts video into high-quality Avid DNxHD/DNxHR (`dnxhr_hqx`) with 10-bit color and 24-bit audio for professional editing.
* **`tomp4 <file>`** – Converts video into highly compatible H.264 MP4 format (`crf 20`) with AAC audio.
* **`extsound <file>`** – Extracts and strips audio from video tracks into a clean 16-bit WAV file (`pcm_s16le`).
* **`towav <file>`** – Converts an input file's audio track into studio-standard 24-bit 48kHz WAV format (`pcm_s24le`).
* **`splitaudio <file>`** – Splits audio into 4 separate stems (vocals, drums, bass, other) using AI via `demucs` with CUDA hardware acceleration.

### 🐍 Python & Docker Automation
* **`runpy [file]`** – Smart Python runner. Executes the specified file, or automatically falls back to `main.py` / `app.py` if no file is provided.
* **`va`** – Fast-activates your local Python virtual environment (`.venv`).
* **`checkdocker [file]`** – Lints your Dockerfile using `hadolint` to catch bad practices.
* **`drawdocker [file]`** – Generates and automatically opens a visual PNG graph architecture of your Dockerfile using `dockerfilegraph`.

### 🛡️ Git, C++, & Project Scaffolding
* **`drawgit`** – Generates a comprehensive visual map of your repository branches and commit history using `git-big-picture`.
* **`checkcpp [path]`** – Runs deep, conclusive static analysis for C/C++ projects using `cppcheck`.
* **`makeignore <tech>`** – Instantly generates official boilerplate `.gitignore` files via `add-gitignore`.
* **`tomd <file>`** / **`toword <file>`** – Rapid bi-directional document conversion between Markdown and Word (`.docx`) using `pandoc`.

### 🌐 Web Servers & Development
* **`liveserver`** – Spins up a hot-reloading dev server for Frontend (`html`, `css`, `js`, `vue`) via `browser-sync`.
* **`staticserver [port]`** – Launches a quick Python HTTP server (default port `5000`) and automatically opens it in your browser.

### 🧹 System Maintenance
* **`deleteorphans`** – Scans, calculates, and safely removes unneeded orphan packages from your Manjaro system using `yay`.

## ⚡ Supercharged Aliases

* `venv` – Instantly creates and activates a local `.venv` environment.
* `migrations` – Groups Django `makemigrations` and `migrate` into one fast command.
* `dclean` – Nukes unused Docker cache, volumes, container images, and networks.
* `gg` / `dd` – Quick-launch triggers for `git-graph` and `dockerydo`.
* `tcc` – Shorthand for `temperature-converter-cli`, a custom temperature conversion utility **developed by me** and available in the **AUR**.
* `myos` – Displays clean system hardware specs using `fastfetch`.

## 📄 License
This project is licensed under the MIT License — feel free to use, modify, and distribute it!
