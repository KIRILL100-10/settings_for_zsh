if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

export LIBVA_DRIVER_NAME=nvidia

export PATH=/usr/local/cuda-13.4/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-13.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export GRADLE_HOME="/opt/gradle/gradle-9.9.1"
export JAVA_HOME="/usr/lib64/jvm/java-25-openjdk-25"
export PATH="$JAVA_HOME/bin:$GRADLE_HOME/bin:$PATH"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source "$ZSH/oh-my-zsh.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


devhelp() {
    printf "\033[36m╔══════════════════════════════════════════════════════════════════╗\033[0m\n"
    printf "\033[36m║            💻 MULTI-LANGUAGE DEV & LINTERS CHEATSHEET            ║\033[0m\n"
    printf "\033[36m╚══════════════════════════════════════════════════════════════════╝\033[0m\n"

    printf "\n\033[33m[ 🚀 RUNNERS & SANDBOXES ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "runpy [file.py]"          "Run Python script (default: main.py / app.py)"
    printf "  \033[32m%-26s\033[0m %s\n" "runc [file.c]"            "Compile via GCC (-O2), run & auto-clean binary"
    printf "  \033[32m%-26s\033[0m %s\n" "runcpp [file.cpp]"        "Compile via G++ (C++20), run & auto-clean binary"
    printf "  \033[32m%-26s\033[0m %s\n" "runcs [proj_name]"        "Run .NET project or scaffold new console app + Code"
    printf "  \033[32m%-26s\033[0m %s\n" "runphp [file.php]"        "Run PHP script or start localhost:8000 (index.php)"
    printf "  \033[32m%-26s\033[0m %s\n" "runnode [file.js]"        "Run JS file, npm dev/start, or server.js/app.js"
    printf "  \033[32m%-26s\033[0m %s\n" "runlua [file.lua]"        "Run Lua script (default: main.lua)"
    printf "  \033[32m%-26s\033[0m %s\n" "runsql [file.sql] [db]"   "Execute SQL in PostgreSQL (default: schema/query)"
    printf "  \033[32m%-26s\033[0m %s\n" "runsh [script.sh]"        "Auto chmod +x and run shell script"

    printf "\n\033[33m[ 🐍 PYTHON & NODE ENVIRONMENTS ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "venv / va"                "Create & activate .venv / activate existing .venv"
    printf "  \033[32m%-26s\033[0m %s\n" "up-venv"                  "Upgrade all outdated pip packages in active/.venv"
    printf "  \033[32m%-26s\033[0m %s\n" "up-node [package.json]"   "Update all local npm dependencies"

    printf "\n\033[33m[ 🔍 STATIC ANALYSIS & LINTERS ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "checkdocker [Dockerfile]" "Lint Dockerfile via Hadolint"
    printf "  \033[32m%-26s\033[0m %s\n" "checkcpp [path]"          "Deep C/C++ static analysis via Cppcheck"
    printf "  \033[32m%-26s\033[0m %s\n" "checkshell [script.sh]"   "Lint Bash/Shell script via ShellCheck"
    printf "\n"
}

javahelp() {
    printf "\033[36m╔══════════════════════════════════════════════════════════════════╗\033[0m\n"
    printf "\033[36m║               ☕ JAVA & JVM ZSH TOOLKIT CHEATSHEET               ║\033[0m\n"
    printf "\033[36m╚══════════════════════════════════════════════════════════════════╝\033[0m\n"

    printf "\n\033[33m[ 🔧 ENVIRONMENT & VERSIONS ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "javainfo"                 "Show active Java, Gradle & all installed JVMs"
    printf "  \033[32m%-26s\033[0m %s\n" "usejava <8|17|21|25>"     "Switch active JVM in current terminal session"

    printf "\n\033[33m[ 🚀 EXECUTION & FRAMEWORKS ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "runjava [File.java]"      "Compile, run & clean .class (default: Main.java)"
    printf "  \033[32m%-26s\033[0m %s\n" "runjar [app.jar] [args]"  "Run executable JAR (auto-detects single .jar)"
    printf "  \033[32m%-26s\033[0m %s\n" "runjavafx"                "Launch JavaFX via Maven or Gradle wrapper"
    printf "  \033[32m%-26s\033[0m %s\n" "runspring"                "Launch Spring Boot via Maven or Gradle wrapper"

    printf "\n\033[33m[ 📦 PACKAGING & ARCHIVES ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "buildjar [Main] [out.jar]" "Compile all .java into executable JAR"
    printf "  \033[32m%-26s\033[0m %s\n" "extract <archive>"         "Unpack .jar, .war, .zip, .tar.*, .7z, .rar"

    printf "\n\033[33m[ 🔍 REVERSE ENGINEERING & ANALYSIS ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "decompilejava [target]"    "Decompile .class/.jar via Vineflower + VS Code"
    printf "  \033[32m%-26s\033[0m %s\n" "bytecode [File.class]"     "Inspect JVM bytecode via javap (add 'save' for txt)"
    printf "  \033[32m%-26s\033[0m %s\n" "findjavaclass <Name>"     "Search for class inside all local .jar files"

    printf "\n\033[34m[ 💡 TIP ] Run '<cmd> --help' on any function for flags & examples! 😎\033[0m\n\n"
}

mediahelp() {
    printf "\033[36m╔══════════════════════════════════════════════════════════════════╗\033[0m\n"
    printf "\033[36m║             🎬 MEDIA, FFMPEG & CUDA AI CHEATSHEET                ║\033[0m\n"
    printf "\033[36m╚══════════════════════════════════════════════════════════════════╝\033[0m\n"

    printf "\n\033[33m[ ⬇️ DOWNLOAD & STUDIO ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "yt <best|1080|mp3> <url>" "Download video/audio via yt-dlp to current dir"
    printf "  \033[32m%-26s\033[0m %s\n" "davinci"                  "Launch DaVinci Resolve on NVIDIA GPU (prime-run)"
    printf "  \033[32m%-26s\033[0m %s\n" "checkmedia <file>"        "Inspect video/audio codecs & metadata (mediainfo)"

    printf "\n\033[33m[ 🎞️ FFMPEG TRANSCODING (CUDA / NVENC) ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "tomov <file> [lb|sq|hq]"  "Transcode to DNxHR .mov + PCM 24-bit (def: sq)"
    printf "  \033[32m%-26s\033[0m %s\n" "tomp4 <file> [cq]"        "Compress to H.264 MP4 via RTX NVENC + 320k AAC"
    printf "  \033[32m%-26s\033[0m %s\n" "extsound <file>"          "Extract audio track to studio WAV 24-bit 48kHz"
    printf "  \033[32m%-26s\033[0m %s\n" "towav <file>"             "Convert audio to studio WAV 24-bit PCM 48kHz"

    printf "\n\033[33m[ 🧠 NEURAL NETWORKS (NVIDIA CUDA) ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "splitaudio <file>"        "Separate stems via Demucs AI on CUDA"
    printf "  \033[32m%-26s\033[0m %s\n" "createsub <file>"         "Transcribe / generate subs via Faster Whisper"
    printf "\n"
}

opshelp() {
    printf "\033[36m╔══════════════════════════════════════════════════════════════════╗\033[0m\n"
    printf "\033[36m║           🐳 DOCKER, SERVERS, NETWORK & LOGS CHEATSHEET          ║\033[0m\n"
    printf "\033[36m╚══════════════════════════════════════════════════════════════════╝\033[0m\n"

    printf "\n\033[33m[ 🐳 DOCKER INFRASTRUCTURE ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "dps / dimages"            "List containers (formatted) / list local images"
    printf "  \033[32m%-26s\033[0m %s\n" "dclean"                   "Hard purge all unused containers, images & volumes"
    printf "  \033[32m%-26s\033[0m %s\n" "workwithdocker"           "Launch Lazydocker TUI manager"

    printf "\n\033[33m[ 🌐 WEB SERVER, PORTS & NETWORK ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "apache <start|stop|...>"  "Control Apache2 + PHP-FPM systemd services"
    printf "  \033[32m%-26s\033[0m %s\n" "killport [port]"          "Force kill process occupying port (default: 8080)"
    printf "  \033[32m%-26s\033[0m %s\n" "checkports"               "Inspect active network ports (snitch)"
    printf "  \033[32m%-26s\033[0m %s\n" "netmonitoring"            "Real-time network traffic monitor (netwatch)"
    printf "  \033[32m%-26s\033[0m %s\n" "checknet"                 "Run internet bandwidth speedtest"

    printf "\n\033[33m[ 📜 LOGS ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "workwithlogs [target]"    "Navigate system or file logs interactively (lnav)"
    printf "\n"
}

syshelp() {
    printf "\033[36m╔══════════════════════════════════════════════════════════════════╗\033[0m\n"
    printf "\033[36m║              🐧 OPENSUSE LEAP & SYSTEM CHEATSHEET                ║\033[0m\n"
    printf "\033[36m╚══════════════════════════════════════════════════════════════════╝\033[0m\n"

    printf "\n\033[33m[ 📦 ZYPPER PACKAGE MANAGER ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "zin <pkg...>"             "Install packages via sudo zypper install"
    printf "  \033[32m%-26s\033[0m %s\n" "zin-nogpg <pkg|rpm>"      "Install package/RPM ignoring GPG checks"
    printf "  \033[32m%-26s\033[0m %s\n" "zrm <pkg...>"             "Remove packages + unneeded dependencies (-u)"

    printf "\n\033[33m[ 🔄 UPDATES & MAINTENANCE ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "update-all"               "Upgrade Zypper, Pipx, Flatpak & check reboot status"
    printf "  \033[32m%-26s\033[0m %s\n" "cleanpip"                 "Purge pip cache & report freed disk space"
    printf "  \033[32m%-26s\033[0m %s\n" "changeconfzsh"            "Run Powerlevel10k configuration wizard"

    printf "\n\033[33m[ 💻 HARDWARE, SESSION & POWER ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "myosinfo"                 "Display system & hardware summary (fastfetch)"
    printf "  \033[32m%-26s\033[0m %s\n" "checksession"             "Show active display protocol (Wayland / X11)"
    printf "  \033[32m%-26s\033[0m %s\n" "rebootlaptop / offlaptop" "Reboot or power off laptop via systemctl"
    printf "\n"
}

toolshelp() {
    printf "\033[36m╔══════════════════════════════════════════════════════════════════╗\033[0m\n"
    printf "\033[36m║             🛠️ TUI WORKSPACE, FILES & UTILS CHEATSHEET           ║\033[0m\n"
    printf "\033[36m╚══════════════════════════════════════════════════════════════════╝\033[0m\n"

    printf "\n\033[33m[ 🖥️ TUI & CLI CLIENTS ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "workwithfiles"            "Terminal file manager (yazi)"
    printf "  \033[32m%-26s\033[0m %s\n" "workwithgit"              "Interactive Git TUI client (lazygit)"
    printf "  \033[32m%-26s\033[0m %s\n" "api <method> <url>"       "Fast terminal HTTP/API client (xh)"
    printf "  \033[32m%-26s\033[0m %s\n" "workwithsql"              "Terminal SQL database TUI (sqlit)"
    printf "  \033[32m%-26s\033[0m %s\n" "workwithmd [file.md]"     "Render Markdown in terminal via glow (default: README)"
    printf "  \033[32m%-26s\033[0m %s\n" "readdocs <cmd|update>"    "Quick command examples via tldr (fallback to man)"

    printf "\n\033[33m[ 📁 FILES, ARCHIVES & SECURITY ]\033[0m\n"
    printf "  \033[32m%-26s\033[0m %s\n" "ls / ll / lt"             "Modern eza listing / detailed + git / 2-level tree"
    printf "  \033[32m%-26s\033[0m %s\n" "cat <file>"               "Syntax-highlighted file viewer (bat)"
    printf "  \033[32m%-26s\033[0m %s\n" "extract <archive>"        "Universal unpacker (.zip/.jar/.tar.*/.7z/.rar/.zst)"
    printf "  \033[32m%-26s\033[0m %s\n" "genpass [length]"         "Generate strong password & copy to clipboard (def: 20)"
    printf "  \033[32m%-26s\033[0m %s\n" "gitprinfo"                "Show Git repository stats & languages (onefetch)"
    printf "\n"
}

myhelp() {
    case "$1" in
        java)   javahelp ;;
        dev)    devhelp ;;
        media)  mediahelp ;;
        ops)    opshelp ;;
        sys)    syshelp ;;
        tools)  toolshelp ;;
        -h|--help|help)
            printf "\033[34m[ 📚 MYHELP USAGE ]\033[0m\n"
            printf "  \033[32mmyhelp\033[0m        — Open full cheatsheet in interactive viewer (press 'q' to exit, '/' to search)\n"
            printf "  \033[32mmyhelp java\033[0m   — Java 8/17/21/25, Gradle, Spring, JAR & Vineflower\n"
            printf "  \033[32mmyhelp dev\033[0m    — Python, C/C++, C#, PHP, Node, Lua, SQL, Shell & Linters\n"
            printf "  \033[32mmyhelp media\033[0m  — yt-dlp, FFmpeg, DaVinci Resolve, Demucs & Whisper\n"
            printf "  \033[32mmyhelp ops\033[0m    — Docker, Apache2, Ports, Network & lnav Logs\n"
            printf "  \033[32mmyhelp sys\033[0m    — openSUSE updates, ZSH config, Fastfetch & Power\n"
            printf "  \033[32mmyhelp tools\033[0m  — Yazi, Lazygit, API (xh), Sqlit, Glow, Extract & Passwords\n"
            ;;
        "")
            {
                javahelp
                devhelp
                mediahelp
                opshelp
                syshelp
                toolshelp
            } | less -R
            ;;
        *)
            printf "\033[31m[ ❌ ERROR ] Unknown category '%s'! Available: java, dev, media, ops, sys, tools\033[0m\n" "$1"
            return 1
            ;;
    esac
}

zin() {
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 📦 ZIN USAGE ]\033[0m\n"
        printf "  \033[32mzin <package1> [package2 ...]\033[0m — Install packages via sudo zypper install\n"
        printf "\033[33m[ 💡 EXAMPLE ] zin htop curl git\033[0m\n"
        return 0
    fi
    printf "\033[34m[ 📦 ZYPPER ] Installing package(s): %s...\033[0m\n" "$*"
    sudo zypper install "$@"
}

zin-nogpg() {
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ⚠️ ZIN-NOGPG USAGE ]\033[0m\n"
        printf "  \033[32mzin-nogpg <package_or_rpm>\033[0m — Install local RPM or package ignoring GPG signature checks\n"
        printf "\033[33m[ 💡 EXAMPLE ] zin-nogpg ./app.rpm\033[0m\n"
        return 0
    fi
    printf "\033[33m[ ⚠️ ZYPPER ] Installing without GPG signature checks: %s...\033[0m\n" "$*"
    sudo zypper --no-gpg-checks install "$@"
}

zrm() {
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🗑️ ZRM USAGE ]\033[0m\n"
        printf "  \033[32mzrm <package1> [package2 ...]\033[0m — Remove packages along with unneeded dependencies (-u)\n"
        printf "\033[33m[ 💡 EXAMPLE ] zrm vlc\033[0m\n"
        return 0
    fi
    printf "\033[31m[ 🗑️ ZYPPER ] Removing package(s) with unneeded dependencies (-u): %s...\033[0m\n" "$*"
    sudo zypper remove -u "$@"
}

yt() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ⬇️ YT-DLP USAGE ]\033[0m\n"
        printf "  \033[32myt best \"<url>\"\033[0m  — Download highest available quality\n"
        printf "  \033[32myt 1080 \"<url>\"\033[0m  — Download up to 1080p MP4 video\n"
        printf "  \033[32myt mp3 \"<url>\"\033[0m   — Extract best quality MP3 audio\n"
        return 0
    fi
    if ! command -v yt-dlp &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'yt-dlp' not installed. Run: pipx install yt-dlp\033[0m\n"
        return 1
    fi

    local template="%(title)s.%(ext)s"

    case "$1" in
        best)
            [[ -z "$2" ]] && printf "\033[31m[ ❌ ERROR ] Missing URL. Usage: yt best \"<url>\"\033[0m\n" && return 1
            yt-dlp --no-playlist -o "$template" "$2" && \
            printf "\033[32m[ 🚀 DOWNLOADED ] Best quality media saved to current directory (%s)\033[0m\n" "$PWD"
            ;;
        1080)
            [[ -z "$2" ]] && printf "\033[31m[ ❌ ERROR ] Missing URL. Usage: yt 1080 \"<url>\"\033[0m\n" && return 1
            yt-dlp --no-playlist -f "bv*[height<=1080]+ba/b[height<=1080]" --merge-output-format mp4 -o "$template" "$2" && \
            printf "\033[32m[ 🎬 DOWNLOADED ] 1080p MP4 video saved to current directory (%s)\033[0m\n" "$PWD"
            ;;
        mp3)
            [[ -z "$2" ]] && printf "\033[31m[ ❌ ERROR ] Missing URL. Usage: yt mp3 \"<url>\"\033[0m\n" && return 1
            yt-dlp --no-playlist -x --audio-format mp3 --audio-quality 0 -o "$template" "$2" && \
            printf "\033[32m[ 🎧 EXTRACTED ] High-bitrate MP3 audio saved to current directory (%s)\033[0m\n" "$PWD"
            ;;
        *)
            printf "\033[33m[ 💡 INFO ] Usage: yt [best|1080|mp3] \"<url>\" (or 'yt --help')\033[0m\n"
            ;;
    esac
}

tomov() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🎞️ TOMOV USAGE ]\033[0m\n"
        printf "  \033[32mtomov <file> [lb|sq|hq]\033[0m — Transcode to DaVinci MOV + Studio PCM 24-bit Audio (default: sq)\n"
        printf "    \033[33mlb\033[0m — Low Bandwidth (smallest file size for long screen recordings)\n"
        printf "    \033[33msq\033[0m — Standard Quality (balanced size & crisp quality, default)\n"
        printf "    \033[33mhq\033[0m — High Quality 8-bit\n"
        printf "\033[33m[ 💡 EXAMPLE ] tomov recording.mp4 lb\033[0m\n"
        return 0
    fi
    if [[ ! -f "$1" ]]; then
        printf "\033[31m[ ❌ ERROR ] File '$1' not found!\033[0m\n"
        return 1
    fi

    local quality="${2:-sq}"
    local profile="dnxhr_sq"
    case "$quality" in
        lb) profile="dnxhr_lb" ;;
        sq) profile="dnxhr_sq" ;;
        hq) profile="dnxhr_hq" ;;
        *)  printf "\033[31m[ ❌ ERROR ] Unknown profile '%s'! Use: lb, sq, hq\033[0m\n" "$quality"; return 1 ;;
    esac

    local start_time=$(date +%s)
    printf "\033[34m[ 🚀 PROCESS ] Transcoding '$1' to DNxHR (%s) + PCM 24-bit 48kHz (CUDA decode)...\033[0m\n" "$profile"

    ffmpeg -hwaccel cuda -i "$1" -c:v dnxhd -profile:v "$profile" -pix_fmt yuv422p -c:a pcm_s24le -ar 48000 "${1%.*}.mov"

    local end_time=$(date +%s)
    printf "\033[32m[ 🎉 DONE ] Successfully encoded in %s seconds!\033[0m\n" "$((end_time - start_time))"
}

tomp4() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🎬 TOMP4 USAGE ]\033[0m\n"
        printf "  \033[32mtomp4 <file> [cq]\033[0m — Fast GPU H.264 MP4 via RTX NVENC + 320k AAC Audio (default CQ: 21)\n"
        printf "\033[33m[ 💡 EXAMPLE ] tomp4 master.mov 20\033[0m\n"
        return 0
    fi
    if [[ ! -f "$1" ]]; then
        printf "\033[31m[ ❌ ERROR ] File '$1' not found!\033[0m\n"
        return 1
    fi

    local cq="${2:-21}"
    local start_time=$(date +%s)
    printf "\033[34m[ 🚀 NVENC ] Compressing '$1' to H.264 MP4 on RTX 3050 (CQ %s, 320k AAC)...\033[0m\n" "$cq"

    ffmpeg -hwaccel cuda -i "$1" -c:v h264_nvenc -preset p5 -cq "$cq" -pix_fmt yuv420p -c:a aac -b:a 320k "${1%.*}.mp4"

    local end_time=$(date +%s)
    printf "\033[32m[ 🎉 DONE ] GPU compression completed in %s seconds!\033[0m\n" "$((end_time - start_time))"
}

extsound() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔊 EXTSOUND USAGE ]\033[0m\n"
        printf "  \033[32mextsound <file>\033[0m — Extract lossless 24-bit / 48kHz PCM WAV audio from video\n"
        printf "\033[33m[ 💡 EXAMPLE ] extsound lecture.mp4\033[0m\n"
        return 0
    fi
    if [[ ! -f "$1" ]]; then
        printf "\033[31m[ ❌ ERROR ] File '$1' not found!\033[0m\n"
        return 1
    fi
    printf "\033[34m[ 🚀 PROCESS ] Extracting lossless audio to WAV 24-bit 48kHz...\033[0m\n"
    ffmpeg -i "$1" -vn -c:a pcm_s24le -ar 48000 "${1%.*}.wav"
    printf "\033[32m[ 🎉 DONE ] Studio 24-bit WAV audio track saved!\033[0m\n"
}

towav() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🎵 TOWAV USAGE ]\033[0m\n"
        printf "  \033[32mtowav <file>\033[0m — Convert any audio file to studio 24-bit / 48kHz PCM WAV\n"
        printf "\033[33m[ 💡 EXAMPLE ] towav track.mp3\033[0m\n"
        return 0
    fi
    if [[ ! -f "$1" ]]; then
        printf "\033[31m[ ❌ ERROR ] File '$1' not found!\033[0m\n"
        return 1
    fi
    printf "\033[34m[ 🚀 PROCESS ] Converting audio to studio WAV 24-bit PCM 48kHz...\033[0m\n"
    ffmpeg -i "$1" -ar 48000 -c:a pcm_s24le "${1%.*}.wav"
    printf "\033[32m[ 🎉 DONE ] Studio 24-bit WAV saved successfully!\033[0m\n"
}

splitaudio() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🧠 SPLITAUDIO USAGE ]\033[0m\n"
        printf "  \033[32msplitaudio <audio_file>\033[0m — Separate vocals & instruments via Demucs AI on NVIDIA CUDA\n"
        printf "\033[33m[ 💡 EXAMPLE ] splitaudio song.wav\033[0m\n"
        return 0
    fi
    if [[ ! -f "$1" ]]; then
        printf "\033[31m[ ❌ ERROR ] Target file '$1' not found in this directory! 🛑\033[0m\n"
        return 1
    fi

    local TARGET_FILE=$(realpath "$1")
    local CURRENT_DIR="$PWD"
    local DEMUCS_DIR="$HOME/Demucs_AI"

    printf "\033[34m[ 🧠 AI PROCESS ] Running Demucs neural network on CUDA (NVIDIA GPU)...\033[0m\n"

    pushd "$DEMUCS_DIR" &>/dev/null
    source .venv/bin/activate
    demucs -d cuda -o "$CURRENT_DIR" "$TARGET_FILE"
    deactivate
    popd &>/dev/null
}

createsub() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🎙️ CREATESUB USAGE ]\033[0m\n"
        printf "  \033[32mcreatesub <media_file>\033[0m — Transcribe speech / generate subtitles via Faster Whisper on CUDA\n"
        printf "\033[33m[ 💡 EXAMPLE ] createsub interview.wav\033[0m\n"
        return 0
    fi
    if [[ ! -f "$1" ]]; then
        printf "\033[31m[ ❌ ERROR ] Target file '$1' not found in this directory! 🛑\033[0m\n"
        return 1
    fi

    local TARGET_FILE=$(realpath "$1")
    local WHISPER_DIR="$HOME/Whisper_AI"
    local OLD_LD_PATH="$LD_LIBRARY_PATH"

    printf "\033[34m[ 🚀 INITIALIZING ] Activating Faster Whisper Turbo context...\033[0m\n"

    pushd "$WHISPER_DIR" &>/dev/null
    source .venv/bin/activate

    local SITE_PACKAGES=$(python3 -c "import site; print(site.getsitepackages()[0])")
    export LD_LIBRARY_PATH="$SITE_PACKAGES/nvidia/cublas/lib:$SITE_PACKAGES/nvidia/cudnn/lib:$LD_LIBRARY_PATH"

    python3 transcribe.py "$TARGET_FILE"

    deactivate
    export LD_LIBRARY_PATH="$OLD_LD_PATH"
    popd &>/dev/null

    printf "\033[32m[ ✅ SUCCESS ] Terminal context restored to host openSUSE Leap.\033[0m\n"
}

checkmedia() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔍 CHECKMEDIA USAGE ]\033[0m\n"
        printf "  \033[32mcheckmedia <file>\033[0m — Inspect video/audio codecs, bitrate & metadata via mediainfo\n"
        printf "\033[33m[ 💡 EXAMPLE ] checkmedia movie.mp4\033[0m\n"
        return 0
    fi
    if [[ -f "$1" ]]; then
        printf "\033[34m[ 🔍 ANALYZING ] Fetching technical metadata for '$1'... 🎥📊\033[0m\n"
        mediainfo "$1"
    else
        printf "\033[31m[ ❌ ERROR ] Media file '$1' not found!\033[0m\n"
        return 1
    fi
}

checkdocker() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐳 CHECKDOCKER USAGE ]\033[0m\n"
        printf "  \033[32mcheckdocker [Dockerfile]\033[0m — Lint Dockerfile best practices via Hadolint (default: Dockerfile)\n"
        printf "\033[33m[ 💡 EXAMPLE ] checkdocker Dockerfile.prod\033[0m\n"
        return 0
    fi
    if ! command -v hadolint &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'hadolint' is not installed on openSUSE!\033[0m\n"
        return 1
    fi
    local file="${1:-Dockerfile}"
    if [[ -f "$file" ]]; then
        printf "\033[34m[ 🔍 LINTING ] Running Hadolint on '$file'...\033[0m\n"
        hadolint "$file"
    else
        printf "\033[31m[ ❌ ERROR ] Dockerfile '$file' not found!\033[0m\n"
        return 1
    fi
}

checkcpp() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ⚙️ CHECKCPP USAGE ]\033[0m\n"
        printf "  \033[32mcheckcpp [file_or_dir]\033[0m — Deep static code analysis for C/C++ via Cppcheck (default: .)\n"
        printf "\033[33m[ 💡 EXAMPLE ] checkcpp src/main.cpp\033[0m\n"
        return 0
    fi
    if ! command -v cppcheck &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'cppcheck' not installed. Run: sudo zypper in cppcheck\033[0m\n"
        return 1
    fi
    local target="${1:-.}"
    if [[ -e "$target" ]]; then
        printf "\033[34m[ 🔍 ANALYSIS ] Running deep C/C++ analysis on '$target'... 🛠⚙️\033[0m\n"
        cppcheck --enable=all --inconclusive --force "$target"
    else
        printf "\033[31m[ ❌ ERROR ] Directory or file '$target' not found!\033[0m\n"
        return 1
    fi
}

checkshell() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐚 CHECKSHELL USAGE ]\033[0m\n"
        printf "  \033[32mcheckshell [script.sh]\033[0m — Lint Bash/POSIX shell script via ShellCheck (default: script.sh)\n"
        printf "\033[33m[ 💡 EXAMPLE ] checkshell deploy.sh\033[0m\n"
        return 0
    fi
    if ! command -v shellcheck &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'shellcheck' not installed. Run: sudo zypper in ShellCheck\033[0m\n"
        return 1
    fi
    local file="${1:-script.sh}"
    if [[ -f "$file" ]]; then
        printf "\033[34m[ 🔍 LINTING ] Running ShellCheck on '$file'...\033[0m\n"
        shellcheck "$file"
    else
        printf "\033[31m[ ❌ ERROR ] Bash script '$file' not found!\033[0m\n"
        return 1
    fi
}

venv() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐍 VENV USAGE ]\033[0m\n"
        printf "  \033[32mvenv\033[0m — Create isolated Python '.venv', activate it & upgrade pip\n"
        printf "\033[33m[ 💡 TIP ] Use 'va' to activate an already existing '.venv' directory.\033[0m\n"
        return 0
    fi
    if [[ -d ".venv" ]]; then
        printf "\033[33m[ 💡 INFO ] Virtual environment already exists. Run 'va' to activate it.\033[0m\n"
    else
        printf "\033[34m[ 🛠️ ENVIRONMENT ] Initializing Python venv in '.venv'...\033[0m\n"
        python3 -m venv .venv

        if [[ -f ".venv/bin/activate" ]]; then
            printf "\033[34m[ 🚀 ACTIVATING ] Loading environment context...\033[0m\n"
            source .venv/bin/activate
            printf "\033[34m[ 🧹 UPGRADING ] Maximizing pip version...\033[0m\n"
            pip install --upgrade pip &>/dev/null
            printf "\033[32m[ 🎉 DONE ] Virtual environment is up, active and ready for development!\033[0m\n"
        else
            printf "\033[31m[ ❌ ERROR ] Critical failure during venv deployment!\033[0m\n"
        fi
    fi
}

va() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ⚡ VA USAGE ]\033[0m\n"
        printf "  \033[32mva\033[0m — Activate local Python '.venv' in current directory (exit with 'deactivate')\n"
        return 0
    fi
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
    else
        printf "\033[31m[ ❌ ERROR ] Local active target '.venv' not found! Build it via 'venv' first.\033[0m\n"
    fi
}

runpy() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐍 RUNPY USAGE ]\033[0m\n"
        printf "  \033[32mrunpy [script.py]\033[0m — Execute Python script (auto-detects main.py or app.py)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runpy parser.py\033[0m\n"
        return 0
    fi
    if [[ -n "$1" ]]; then
        if [[ -f "$1" ]]; then
            python3 "$1"
        else
            printf "\033[31m[ ❌ ERROR ] Direct file target '$1' not found!\033[0m\n"
        fi
    else
        if [[ -f "main.py" ]]; then
            python3 main.py
        elif [[ -f "app.py" ]]; then
            python3 app.py
        else
            printf "\033[33m[ 💡 INFO ] Provide target file (e.g. runpy script.py) or create main.py/app.py\033[0m\n"
        fi
    fi
}

javainfo() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ☕ JAVAINFO USAGE ]\033[0m\n"
        printf "  \033[32mjavainfo\033[0m — Show active JAVA_HOME, JDK/JRE type, Gradle version & all installed JVMs\n"
        return 0
    fi
    printf "\033[34m[ ☕ JVM & BUILD ENVIRONMENT ]\033[0m\n"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    printf "  \033[32m%-15s\033[0m %s\n" "JAVA_HOME:" "${JAVA_HOME:-not set}"
    printf "  \033[32m%-15s\033[0m %s\n" "Active Java:" "$(java -version 2>&1 | head -n 1)"
    printf "  \033[32m%-15s\033[0m %s\n" "Type:" "$([[ -x "$JAVA_HOME/bin/javac" ]] && echo 'Full JDK (Compiler + Runtime)' || echo 'JRE Only (Runtime only, no javac)')"
    printf "  \033[32m%-15s\033[0m %s\n" "Active Gradle:" "$(gradle -v 2>/dev/null | grep '^Gradle ' || echo 'not found')"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    printf "\033[34m[ 📂 INSTALLED JVMs IN /usr/lib64/jvm ]\033[0m\n"
    for dir in /usr/lib64/jvm/java-*(N/); do
        local clean_dir="${dir%/}"
        local tag=$([[ -x "$clean_dir/bin/javac" ]] && echo "JDK" || echo "JRE")
        if [[ "$clean_dir" == "${JAVA_HOME%/}" ]]; then
            printf "  \033[32m👉 %s [%s] (ACTIVE)\033[0m\n" "$clean_dir" "$tag"
        else
            printf "     %s [%s]\n" "$clean_dir" "$tag"
        fi
    done
}

usejava() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔄 USEJAVA USAGE ]\033[0m\n"
        printf "  \033[32musejava <8|17|21|25>\033[0m — Switch active Java version in current terminal session\n"
        printf "    \033[33m8\033[0m  — OpenJDK 8 JRE  (Minecraft 1.8–1.16.5)\n"
        printf "    \033[33m17\033[0m — OpenJDK 17 JDK (Minecraft 1.17–1.20.4)\n"
        printf "    \033[33m21\033[0m — OpenJDK 21 JDK (Minecraft 1.20.5–1.21.x)\n"
        printf "    \033[33m25\033[0m — OpenJDK 25 JDK (Minecraft 26.1+, Spring Boot, JavaFX, Vineflower, default)\n"
        return 0
    fi

    local ver="$1"
    if [[ -z "$ver" ]]; then
        printf "\033[33m[ 💡 INFO ] Specify version: 'usejava <8|17|21|25>'\033[0m\n"
        javainfo
        return 1
    fi

    local target_jvm=""
    case "$ver" in
        8)  target_jvm="/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0" ;;
        17) target_jvm="/usr/lib64/jvm/java-17-openjdk-17" ;;
        21) target_jvm="/usr/lib64/jvm/java-21-openjdk-21" ;;
        25) target_jvm="/usr/lib64/jvm/java-25-openjdk-25" ;;
        *)  target_jvm=$(ls -d /usr/lib64/jvm/java-${ver}-openjdk* 2>/dev/null | head -n 1) ;;
    esac

    target_jvm="${target_jvm%/}"

    if [[ -z "$target_jvm" || ! -d "$target_jvm" ]]; then
        printf "\033[31m[ ❌ ERROR ] JVM version '%s' not found in /usr/lib64/jvm! 🛑\033[0m\n" "$ver"
        return 1
    fi

    local old_bin="${JAVA_HOME%/}/bin:"
    local old_jre_bin="${JAVA_HOME%/}/jre/bin:"
    export PATH="${PATH//$old_bin/}"
    export PATH="${PATH//$old_jre_bin/}"

    export JAVA_HOME="$target_jvm"
    if [[ -d "$JAVA_HOME/bin" ]]; then
        export PATH="$JAVA_HOME/bin:$PATH"
    elif [[ -d "$JAVA_HOME/jre/bin" ]]; then
        export PATH="$JAVA_HOME/jre/bin:$PATH"
    fi

    rehash

    printf "\033[32m[ 🔄 SWITCHED ] Active JVM is now: %s 😎\033[0m\n" "$JAVA_HOME"
    java -version 2>&1 | head -n 1

    if [[ ! -x "$JAVA_HOME/bin/javac" ]]; then
        printf "\033[33m[ ⚠️ JRE ONLY ] Notice: 'javac' is missing here (Runtime only). Switch back with 'usejava 25' to compile! 🎮\033[0m\n"
    fi
}

runjava() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ☕ RUNJAVA USAGE ]\033[0m\n"
        printf "  \033[32mrunjava [File.java]\033[0m — Compile, execute & auto-clean .class bytecode (default: Main.java)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runjava Algorithm.java\033[0m\n"
        return 0
    fi

    local file="$1"
    if [[ -z "$file" ]]; then
        if [[ -f "Main.java" ]]; then
            file="Main.java"
        else
            printf "\033[33m[ 💡 INFO ] Provide target file (e.g. runjava Script.java) or create Main.java\033[0m\n"
            return 1
        fi
    fi

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Target file '$file' not found in this directory! 🛑\033[0m\n"
        return 1
    fi

    local FILE_NAME="$file"
    local CLASS_NAME="${FILE_NAME%.java}"

    printf "\033[34m[ ⚙️ COMPILING ] Compiling %s via OpenJDK core...\033[0m\n" "$FILE_NAME"

    if javac "$FILE_NAME"; then
        printf "\033[32m[ 🎉 SUCCESS ] Compilation completed! Launching JVM environment...\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

        java "$CLASS_NAME"

        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        printf "\033[34m[ 🧼 CLEANING ] Purging temporary bytecode cache...\033[0m\n"

        rm -f "${CLASS_NAME}.class" 2>/dev/null
        rm -f ${CLASS_NAME}\$*.class(N) 2>/dev/null

        printf "\033[32m[ ✅ DONE ] System is clean, host context restored! 😎🏆\033[0m\n"
    else
        printf "\033[31m[ ❌ BUILD FAILED ] Target build crashed! Check your syntax inside VS Code.\033[0m\n"
        return 1
    fi
}

decompilejava() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔍 DECOMPILEJAVA USAGE ]\033[0m\n"
        printf "  \033[32mdecompilejava [target]\033[0m — Decompile .class, .jar or .war via Vineflower & open in VS Code\n"
        printf "    \033[33m.class\033[0m — Decodes into <Name>.java in same directory (default: Main.class)\n"
        printf "    \033[33m.jar\033[0m   — Unpacks & decodes whole archive into <Name>_src/ folder\n"
        printf "\033[33m[ 💡 EXAMPLE ] decompilejava Quadrant.class\033[0m\n"
        return 0
    fi

    local jar_path="$HOME/.local/share/vineflower/vineflower.jar"

    if [[ ! -f "$jar_path" ]]; then
        printf "\033[31m[ ❌ ERROR ] Vineflower core missing at '$jar_path'! 🛑\033[0m\n"
        return 1
    fi

    local file="$1"
    if [[ -z "$file" ]]; then
        if [[ -f "Main.class" ]]; then
            file="Main.class"
        else
            printf "\033[33m[ 💡 INFO ] Provide target (.class / .jar) or place Main.class here\033[0m\n"
            return 1
        fi
    fi

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Target file '$file' not found in this directory! 🛑\033[0m\n"
        return 1
    fi

    local EXT="${file:e:l}"
    local BASE_NAME="${file:t:r}"
    local PARENT_DIR="${file:h}"
    local OUT_TARGET=""
    local CODE_TARGET=""
    local SUCCESS_MSG=""

    if [[ "$EXT" == "jar" || "$EXT" == "war" ]]; then
        OUT_TARGET="${PARENT_DIR}/${BASE_NAME}_src"
        CODE_TARGET="$OUT_TARGET"
        mkdir -p "$OUT_TARGET"
        SUCCESS_MSG="Archive unpacked & decoded! Sources saved in ${OUT_TARGET}/"
    elif [[ "$EXT" == "class" ]]; then
        OUT_TARGET="$PARENT_DIR"
        CODE_TARGET="${OUT_TARGET}/${BASE_NAME}.java"
        SUCCESS_MSG="Bytecode decoded! Source saved as ${CODE_TARGET}"
    else
        printf "\033[31m[ ❌ ERROR ] Unsupported format '.%s'! Expected .class or .jar 🛑\033[0m\n" "$EXT"
        return 1
    fi

    printf "\033[34m[ 🔍 DECOMPILING ] Reverse-engineering %s via Vineflower core...\033[0m\n" "$file"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

    if java -jar "$jar_path" --ascii-strings=0 --decompile-generics=1 "$file" "$OUT_TARGET"; then
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        printf "\033[32m[ 🎉 SUCCESS ] %s 😎🏆\033[0m\n" "$SUCCESS_MSG"

        if command -v code >/dev/null 2>&1; then
            printf "\033[34m[ 💻 VS CODE ] Opening decoded target in editor...\033[0m\n"
            code "$CODE_TARGET"
        fi
    else
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        printf "\033[31m[ ❌ FAILED ] Decompilation crashed! Target might be corrupted or heavily obfuscated. 🛑\033[0m\n"
        return 1
    fi
}

bytecode() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔬 BYTECODE USAGE ]\033[0m\n"
        printf "  \033[32mbytecode [File.class] [save]\033[0m — Disassemble JVM instructions via javap (default: Main.class)\n"
        printf "    \033[33m(no 2nd arg)\033[0m — View full disassembly interactively in 'less'\n"
        printf "    \033[33msave\033[0m         — Dump to <File>_bytecode.txt & open in VS Code\n"
        printf "\033[33m[ 💡 EXAMPLE ] bytecode App.class save\033[0m\n"
        return 0
    fi

    local file="${1:-Main.class}"
    local mode="$2"

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Target bytecode '$file' not found! Provide a .class file or place Main.class here. 🛑\033[0m\n"
        return 1
    fi

    if ! command -v javap >/dev/null 2>&1; then
        printf "\033[31m[ ❌ ERROR ] 'javap' utility not found! Is OpenJDK devel package installed? 🛑\033[0m\n"
        return 1
    fi

    printf "\033[34m[ 🔬 DISASSEMBLING ] Inspecting JVM instructions for %s...\033[0m\n" "$file"

    if [[ "$mode" == "save" ]]; then
        local out_txt="${file%.class}_bytecode.txt"
        javap -c -p -v "$file" > "$out_txt"
        printf "\033[32m[ 🎉 SUCCESS ] Bytecode dump saved to %s 😎\033[0m\n" "$out_txt"
        command -v code >/dev/null 2>&1 && code "$out_txt"
    else
        printf "\033[33m[ 💡 TIP ] Press 'q' to exit viewer, or run 'bytecode %s save' to open in VS Code.\033[0m\n" "$file"
        sleep 0.5
        javap -c -p -v "$file" | less
    fi
}

buildjar() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 📦 BUILDJAR USAGE ]\033[0m\n"
        printf "  \033[32mbuildjar [Main.java] [out.jar]\033[0m — Compile all *.java in current dir into an executable JAR\n"
        printf "\033[33m[ 💡 EXAMPLE ] buildjar App.java myapp.jar\033[0m\n"
        return 0
    fi

    local main_file="${1:-Main.java}"

    if [[ ! -f "$main_file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Entry point '$main_file' not found! Provide Main.java or pass target file. 🛑\033[0m\n"
        return 1
    fi

    local MAIN_CLASS="${main_file%.java}"
    local JAR_NAME="${2:-${MAIN_CLASS}.jar}"
    local BUILD_DIR=".tmp_jar_build_$$"

    printf "\033[34m[ 📦 PACKAGING ] Compiling sources for entry point '%s'...\033[0m\n" "$MAIN_CLASS"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

    mkdir -p "$BUILD_DIR"

    if javac -d "$BUILD_DIR" *.java; then
        printf "\033[34m[ ⚙️ ARCHIVING ] Building executable JAR '%s'...\033[0m\n" "$JAR_NAME"
        if jar cfe "$JAR_NAME" "$MAIN_CLASS" -C "$BUILD_DIR" .; then
            rm -rf "$BUILD_DIR"
            printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
            printf "\033[32m[ 🎉 SUCCESS ] Executable archive '%s' is ready! Run it with: java -jar %s 😎🏆\033[0m\n" "$JAR_NAME" "$JAR_NAME"
        else
            rm -rf "$BUILD_DIR"
            printf "\033[31m[ ❌ FAILED ] JAR archiving crashed! 🛑\033[0m\n"
            return 1
        fi
    else
        rm -rf "$BUILD_DIR"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        printf "\033[31m[ ❌ BUILD FAILED ] Compilation errors detected! Fix your code first. 🛑\033[0m\n"
        return 1
    fi
}

runjar() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ☕ RUNJAR USAGE ]\033[0m\n"
        printf "  \033[32mrunjar [app.jar] [args...]\033[0m — Run executable JAR on active JVM (auto-detects single .jar)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runjar server.jar --port 8080\033[0m\n"
        return 0
    fi

    local file="$1"

    if [[ -z "$file" ]]; then
        local jars=(*.jar(N))
        if [[ ${#jars[@]} -eq 1 ]]; then
            file="${jars[1]}"
        elif [[ ${#jars[@]} -gt 1 ]]; then
            printf "\033[33m[ 💡 INFO ] Multiple JARs found! Specify target: %s\033[0m\n" "${jars[*]}"
            return 1
        else
            printf "\033[33m[ 💡 INFO ] Provide target archive (e.g. runjar app.jar) or place a .jar here\033[0m\n"
            return 1
        fi
    else
        shift
    fi

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Archive '$file' not found in this directory! 🛑\033[0m\n"
        return 1
    fi

    printf "\033[34m[ ☕ JAR LAUNCHER ] Executing '%s' on JVM (%s)... 🚀\033[0m\n" "$file" "$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

    java -jar "$file" "$@"
    local exit_code=$?

    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    if [[ $exit_code -eq 0 ]]; then
        printf "\033[32m[ ✅ OFFLINE ] JAR execution finished gracefully. 😎\033[0m\n"
    else
        printf "\033[31m[ ❌ CRASHED ] JAR exited with error code %d! 🛑\033[0m\n" "$exit_code"
        return $exit_code
    fi
}

findjavaclass() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔎 FINDJAVACLASS USAGE ]\033[0m\n"
        printf "  \033[32mfindjavaclass <ClassName>\033[0m — Recursively search for class inside all local .jar files\n"
        printf "\033[33m[ 💡 EXAMPLE ] findjavaclass Quadrant\033[0m\n"
        return 0
    fi

    local query="$1"

    if [[ -z "$query" ]]; then
        printf "\033[33m[ 💡 INFO ] Provide class name to search (e.g. findjavaclass ArrayList or findjavaclass com/example/App)\033[0m\n"
        return 1
    fi

    printf "\033[34m[ 🔎 SCANNING ] Searching for '%s' across all JAR archives...\033[0m\n" "$query"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

    local found=0
    local jar_file

    for jar_file in **/*.jar(N); do
        local matches
        matches=$(jar tf "$jar_file" 2>/dev/null | grep -i "$query")
        if [[ -n "$matches" ]]; then
            printf "\033[32m[ 📦 FOUND IN ] %s\033[0m\n" "$jar_file"
            echo "$matches" | sed 's/^/   ↳ /'
            found=1
        fi
    done

    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    if [[ "$found" -eq 0 ]]; then
        printf "\033[31m[ 🤷 NOT FOUND ] No classes matching '%s' found in local JARs.\033[0m\n" "$query"
    else
        printf "\033[32m[ ✅ DONE ] Search completed! 😎\033[0m\n"
    fi
}

runjavafx() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🖼️ RUNJAVAFX USAGE ]\033[0m\n"
        printf "  \033[32mrunjavafx\033[0m — Auto-detect Maven (pom.xml) or Gradle (build.gradle) & run JavaFX app\n"
        return 0
    fi

    printf "\033[34m[ 🖼️ JAVAFX ] Detecting build automation context...\033[0m\n"

    if [[ -f "pom.xml" ]]; then
        printf "\033[34m[ ⚙️ MAVEN ] Launching Apache Maven JavaFX plugin... 🚀\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        [[ -f "./mvnw" && ! -x "./mvnw" ]] && chmod +x ./mvnw
        [[ -x "./mvnw" ]] && ./mvnw javafx:run || mvn javafx:run
    elif [[ -f "build.gradle" || -f "build.gradle.kts" ]]; then
        printf "\033[34m[ ⚙️ GRADLE ] Launching Gradle JavaFX task... 🚀\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        [[ -f "./gradlew" && ! -x "./gradlew" ]] && chmod +x ./gradlew
        [[ -x "./gradlew" ]] && ./gradlew javafxRun || gradle javafxRun
    else
        printf "\033[31m[ ❌ ERROR ] Build blueprint (pom.xml / build.gradle) missing! Is this a Maven/Gradle JavaFX project? 🛑\033[0m\n"
        return 1
    fi
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    printf "\033[32m[ ✅ OFFLINE ] JavaFX graphical context closed gracefully.\033[0m\n"
}

runspring() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🚀 RUNSPRING USAGE ]\033[0m\n"
        printf "  \033[32mrunspring\033[0m — Auto-detect Maven or Gradle wrapper & start Spring Boot application\n"
        return 0
    fi

    printf "\033[34m[ 🚀 SPRING BOOT ] Detecting project architecture context...\033[0m\n"

    if [[ -f "pom.xml" ]]; then
        printf "\033[34m[ ⚙️ MAVEN ] Launching Apache Maven bootstrapper... 🍃\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        [[ -f "./mvnw" && ! -x "./mvnw" ]] && chmod +x ./mvnw
        [[ -x "./mvnw" ]] && ./mvnw spring-boot:run || mvn spring-boot:run
    elif [[ -f "build.gradle" || -f "build.gradle.kts" ]]; then
        printf "\033[34m[ ⚙️ GRADLE ] Launching modern Gradle wrapper context... 🍃\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        [[ -f "./gradlew" && ! -x "./gradlew" ]] && chmod +x ./gradlew
        [[ -x "./gradlew" ]] && ./gradlew bootRun || gradle bootRun
    else
        printf "\033[31m[ ❌ ERROR ] Critical Failure: Build context not found! Is this a Spring project, bro? 🛑\033[0m\n"
        return 1
    fi
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    printf "\033[32m[ ✅ OFFLINE ] Spring Boot context gracefully terminated.\033[0m\n"
}

killport() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 💀 KILLPORT USAGE ]\033[0m\n"
        printf "  \033[32mkillport [port]\033[0m — Force kill process occupying TCP port (default: 8080)\n"
        printf "\033[33m[ 💡 EXAMPLE ] killport 3000\033[0m\n"
        return 0
    fi

    local port="${1:-8080}"
    local pid=$(lsof -ti :"$port" 2>/dev/null || fuser "$port"/tcp 2>/dev/null)
    if [[ -n "$pid" ]]; then
        kill -9 $pid && printf "\033[32m[ 💀 KILLED ] Freed port %s (PID: %s)\033[0m\n" "$port" "$pid"
    else
        printf "\033[33m[ 💡 INFO ] Port %s is already free.\033[0m\n" "$port"
    fi
}

runc() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ⚙️ RUNC USAGE ]\033[0m\n"
        printf "  \033[32mrunc [file.c]\033[0m — Compile with GCC (-O2 -Wall -lm), run & remove binary (default: main.c)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runc lab1.c\033[0m\n"
        return 0
    fi

    if ! command -v gcc &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'gcc' not installed. Run: sudo zypper in gcc\033[0m\n"
        return 1
    fi

    local file="$1"
    if [[ -z "$file" ]]; then
        if [[ -f "main.c" ]]; then
            file="main.c"
        else
            printf "\033[33m[ 💡 INFO ] Provide target file (e.g. runc script.c) or create main.c\033[0m\n"
            return 1
        fi
    fi

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Source file '$file' not found! 🛑\033[0m\n"
        return 1
    fi

    local FILE_NAME="$file"
    local BIN_NAME="${FILE_NAME%.c}"

    printf "\033[34m[ ⚙️ COMPILING ] Compiling %s via GCC native engine...\033[0m\n" "$FILE_NAME"
    if gcc -O2 -Wall "$FILE_NAME" -o "$BIN_NAME" -lm; then
        printf "\033[32m[ 🎉 SUCCESS ] Binary compiled! Launching executable host context...\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        ./"$BIN_NAME"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        rm -f "$BIN_NAME"
        printf "\033[32m[ ✅ DONE ] Sandbox runtime destroyed, system is clean! 😎🏆\033[0m\n"
    else
        printf "\033[31m[ ❌ BUILD FAILED ] GCC compiler crashed! Check your syntax inside VS Code.\033[0m\n"
        return 1
    fi
}

runcpp() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ ⚙️ RUNCPP USAGE ]\033[0m\n"
        printf "  \033[32mruncpp [file.cpp]\033[0m — Compile with G++ (C++20 -O2), run & remove binary (default: main.cpp)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runcpp solution.cpp\033[0m\n"
        return 0
    fi

    if ! command -v g++ &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'g++' not installed. Run: sudo zypper in gcc-c++\033[0m\n"
        return 1
    fi

    local file="$1"
    if [[ -z "$file" ]]; then
        if [[ -f "main.cpp" ]]; then
            file="main.cpp"
        else
            printf "\033[33m[ 💡 INFO ] Provide target file (e.g. runcpp script.cpp) or create main.cpp\033[0m\n"
            return 1
        fi
    fi

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Source file '$file' not found! 🛑\033[0m\n"
        return 1
    fi

    local FILE_NAME="$file"
    local BIN_NAME="${FILE_NAME%.cpp}"

    printf "\033[34m[ ⚙️ COMPILING ] Compiling %s via G++ modern engine...\033[0m\n" "$FILE_NAME"
    if g++ -O2 -Wall -std=c++20 "$FILE_NAME" -o "$BIN_NAME"; then
        printf "\033[32m[ 🎉 SUCCESS ] Object built! Executing binary matrix...\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        ./"$BIN_NAME"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        rm -f "$BIN_NAME"
        printf "\033[32m[ ✅ DONE ] Space cleared, process completed successfully! 😎🏆\033[0m\n"
    else
        printf "\033[31m[ ❌ BUILD FAILED ] G++ architecture crashed! Check your syntax inside VS Code.\033[0m\n"
        return 1
    fi
}

runcs() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🚀 RUNCS USAGE ]\033[0m\n"
        printf "  \033[32mruncs [project_name]\033[0m — Run existing .csproj via 'dotnet run', or scaffold new console app + open VS Code\n"
        printf "\033[33m[ 💡 EXAMPLE ] runcs LabWork1\033[0m\n"
        return 0
    fi

    printf "\033[34m[ 🚀 .NET ] Detecting C# project configuration...\033[0m\n"

    local csproj=$(find . -maxdepth 1 -name "*.csproj" | head -n 1)

    if [[ -n "$csproj" ]]; then
        printf "\033[34m[ ⚙️ RUNNING ] Executing active C# target project '%s'... 🛠️\033[0m\n" "${csproj##*/}"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

        dotnet run

        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        printf "\033[32m[ ✅ DONE ] C# execution environment stopped.\033[0m\n"
    else
        local target_name="${1:-${PWD##*/}}"
        printf "\033[33m[ 💡 INFO ] No C# project found. Initializing new Console Application '%s'...\033[0m\n" "$target_name"

        if dotnet new console -o "$target_name"; then
            printf "\033[32m[ 🎉 SUCCESS ] C# workspace deployed! Moving context into directory...\033[0m\n"

            cd "$target_name" || return 1

            printf "\033[34m[ 📝 VS CODE ] Opening VS Code for your new lab... 🚀\033[0m\n"
            if command -v code &>/dev/null; then
                code .
            else
                flatpak run com.visualstudio.code . &>/dev/null &
            fi
        else
            printf "\033[31m[ ❌ ERROR ] Critical failure during .NET project bootstrap!\033[0m\n"
            return 1
        fi
    fi
}

runphp() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐘 RUNPHP USAGE ]\033[0m\n"
        printf "  \033[32mrunphp [script.php]\033[0m — Execute single PHP script, or start built-in server on http://localhost:8000 (if index.php exists)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runphp handler.php\033[0m\n"
        return 0
    fi

    if [[ -n "$1" ]]; then
        if [[ -f "$1" ]]; then
            printf "\033[34m[ 🐘 PHP ] Executing isolated server-side script '$1'...\033[0m\n"
            printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
            php "$1"
            printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        else
            printf "\033[31m[ ❌ ERROR ] PHP script target '$1' not found!\033[0m\n"
            return 1
        fi
    else
        if [[ -f "index.php" ]]; then
            printf "\033[34m[ 🐘 PHP ] Starting local routing engine on http://localhost:8000 ...\033[0m\n"
            php -S localhost:8000
        else
            printf "\033[33m[ 💡 INFO ] Usage: runphp [script.php] or create index.php to spin up dev-server.\033[0m\n"
        fi
    fi
}

runnode() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 📦 RUNNODE USAGE ]\033[0m\n"
        printf "  \033[32mrunnode [script.js]\033[0m — Run JS file, execute npm 'dev'/'start' from package.json, or launch server.js/app.js\n"
        printf "\033[33m[ 💡 EXAMPLE ] runnode index.js\033[0m\n"
        return 0
    fi

    local target="$1"

    if [[ -n "$target" ]]; then
        if [[ -f "$target" ]]; then
            printf "\033[34m[ 📦 NODE ] Executing isolated target script '$target'...\033[0m\n"
            printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
            node "$target"
            printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
            return 0
        else
            printf "\033[31m[ ❌ ERROR ] Direct JS target file '$target' not found!\033[0m\n"
            return 1
        fi
    fi

    if [[ -f "package.json" ]]; then
        printf "\033[34m[ 📦 NODE ] Analyzing javascript project automation manifests...\033[0m\n"
        printf "\033[34m[ 🛠️ ENVIRONMENT ] Activating Node ecosystem context...\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        if grep -q '"dev":' package.json; then
            npm run dev
        elif grep -q '"start":' package.json; then
            npm start
        else
            printf "\033[31m[ ❌ ERROR ] No execution scripts ('dev' / 'start') found in package.json!\033[0m\n"
            return 1
        fi
        return 0
    fi

    if [[ -f "server.js" ]]; then
        printf "\033[34m[ 📦 NODE ] No package.json found. Launching default 'server.js'...\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        node server.js
    elif [[ -f "app.js" ]]; then
        printf "\033[34m[ 📦 NODE ] No package.json found. Launching default 'app.js'...\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        node app.js
    else
        printf "\033[31m[ ❌ ERROR ] No JavaScript targets (app.js / server.js / package.json) detected in this context! 🛑\033[0m\n"
        return 1
    fi
}

runlua() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🌙 RUNLUA USAGE ]\033[0m\n"
        printf "  \033[32mrunlua [script.lua]\033[0m — Execute Lua script (default: main.lua)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runlua game.lua\033[0m\n"
        return 0
    fi

    if ! command -v lua &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'lua' not installed. Run: sudo zypper in lua54\033[0m\n"
        return 1
    fi

    local file="$1"
    if [[ -z "$file" ]]; then
        if [[ -f "main.lua" ]]; then
            file="main.lua"
        else
            printf "\033[33m[ 💡 INFO ] Provide target file (e.g. runlua script.lua) or create main.lua\033[0m\n"
            return 1
        fi
    fi

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] Target script '$file' not found in this directory! 🛑\033[0m\n"
        return 1
    fi

    printf "\033[34m[ 🌙 LUA ] Executing lightweight script context for '$file'... ⚙️\033[0m\n"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    lua "$file"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
    printf "\033[32m[ ✅ DONE ] Lua execution thread closed cleanly.\033[0m\n"
}

runsql() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐘 RUNSQL USAGE ]\033[0m\n"
        printf "  \033[32mrunsql [file.sql] [db_name]\033[0m — Run SQL script in PostgreSQL with ON_ERROR_STOP=1 (default: schema.sql / query.sql, db: \$USER)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runsql init.sql mydb\033[0m\n"
        return 0
    fi

    if ! command -v psql &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'psql' client not installed. Run: sudo zypper in postgresql\033[0m\n"
        return 1
    fi

    local file="$1"
    if [[ -z "$file" ]]; then
        if [[ -f "schema.sql" ]]; then
            file="schema.sql"
        elif [[ -f "query.sql" ]]; then
            file="query.sql"
        else
            printf "\033[33m[ 💡 INFO ] Provide a SQL target file (e.g. runsql script.sql) or create schema.sql\033[0m\n"
            return 1
        fi
    fi

    if [[ ! -f "$file" ]]; then
        printf "\033[31m[ ❌ ERROR ] SQL file target '$file' not found! 🛑\033[0m\n"
        return 1
    fi

    local SQL_FILE="$file"
    local DB_NAME="${2:-$USER}"

    printf "\033[34m[ 🐘 POSTGRESQL ] Injecting SQL script '%s' into database '%s'... 📊\033[0m\n" "$SQL_FILE" "$DB_NAME"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

    psql -v ON_ERROR_STOP=1 -d "$DB_NAME" -f "$SQL_FILE"

    local EXIT_CODE=$?
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

    if [[ $EXIT_CODE -eq 0 ]]; then
        printf "\033[32m[ 🎉 SUCCESS ] Queries executed. Database transaction state committed! 🏆\033[0m\n"
    else
        printf "\033[31m[ ❌ ERROR ] Postgres engine returned crash code $EXIT_CODE. Check your SQL constraints.\033[0m\n"
        return $EXIT_CODE
    fi
}

runsh() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐚 RUNSH USAGE ]\033[0m\n"
        printf "  \033[32mrunsh [script.sh]\033[0m — Auto-grant +x permissions and run shell script (auto-detects script.sh / build.sh / deploy.sh)\n"
        printf "\033[33m[ 💡 EXAMPLE ] runsh install.sh\033[0m\n"
        return 0
    fi

    local file="$1"
    if [[ -z "$file" ]]; then
        if [[ -f "script.sh" ]]; then
            file="script.sh"
        elif [[ -f "build.sh" ]]; then
            file="build.sh"
        elif [[ -f "deploy.sh" ]]; then
            file="deploy.sh"
        fi
    fi

    if [[ -n "$file" && -f "$file" ]]; then
        if [[ ! -x "$file" ]]; then
            printf "\033[33m[ 💡 INFO ] Target '$file' is not executable. Granting +x permissions... 🔐\033[0m\n"
            chmod +x "$file"
        fi

        printf "\033[34m[ 🐚 SHELL ] Launching bash script engine for '$file'... 🚀\033[0m\n"
        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

        ./"$file"

        printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
        printf "\033[32m[ ✅ DONE ] Shell execution context closed successfully.\033[0m\n"
    else
        printf "\033[31m[ ❌ ERROR ] Shell target not found! Provide a script path (e.g., runsh setup.sh) or create script.sh\033[0m\n"
        return 1
    fi
}

readdocs() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 📖 READDOCS USAGE ]\033[0m\n"
        printf "  \033[32mreaddocs <command|update>\033[0m — Fetch quick tldr examples (falls back to 'man') or sync offline cache\n"
        printf "\033[33m[ 💡 EXAMPLE ] readdocs tar\033[0m\n"
        return 0
    fi

    if ! command -v tldr &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'tldr' (tealdeer) binary not found in ~/.local/bin! 🛑\033[0m\n"
        return 1
    fi

    local cmd="$1"
    if [[ -z "$cmd" ]]; then
        printf "\033[33m[ 💡 INFO ] Usage: readdocs <command> (e.g. 'readdocs grep') or 'readdocs update' to sync cache.\033[0m\n"
        return 1
    fi

    if [[ "$cmd" == "update" ]]; then
        printf "\033[34m[ 🔄 SYNCING ] Updating tealdeer (tldr) offline pages cache...\033[0m\n"
        tldr --update && printf "\033[32m[ ✅ DONE ] Documentation cache is fresh and ready! 📚😎\033[0m\n"
        return 0
    fi

    printf "\033[34m[ 📖 CHEATSHEET ] Fetching quick examples for '%s'...\033[0m\n" "$cmd"
    printf "\033[33m──────────────────────────────────────────────────\033[0m\n"

    if ! tldr "$cmd" 2>/dev/null; then
        printf "\033[33m[ 🤷 NOT IN TLDR ] '%s' not found in tldr cache. Falling back to 'man %s'... 📜\033[0m\n" "$cmd" "$cmd"
        sleep 0.6
        man "$cmd"
    fi
}

workwithmd() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 📝 WORKWITHMD USAGE ]\033[0m\n"
        printf "  \033[32mworkwithmd [file.md]\033[0m — Render formatted Markdown in terminal via Glow (default: README.md)\n"
        printf "\033[33m[ 💡 EXAMPLE ] workwithmd NOTES.md\033[0m\n"
        return 0
    fi

    if ! command -v glow &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'glow' not installed. Run: sudo zypper in glow\033[0m\n"
        return 1
    fi

    local file="${1:-README.md}"
    if [[ -f "$file" ]]; then
        printf "\033[34m[ 📖 READING ] Rendering Markdown file '$file'...\033[0m\n"
        glow "$file"
    else
        printf "\033[31m[ ❌ ERROR ] Markdown file '$file' not found!\033[0m\n"
        return 1
    fi
}

workwithlogs() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 📜 WORKWITHLOGS USAGE ]\033[0m\n"
        printf "  \033[32mworkwithlogs [file_or_dir]\033[0m — Launch interactive log navigator lnav (default: system/journal logs)\n"
        printf "\033[33m[ 💡 EXAMPLE ] workwithlogs /var/log/apache2/\033[0m\n"
        return 0
    fi

    if ! command -v lnav &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'lnav' not installed in ~/.local/bin!\033[0m\n"
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        printf "\033[34m[ 📜 LOGS ] Launching interactive system & service logs navigator...\033[0m\n"
        lnav
    elif [[ -f "$1" || -d "$1" ]]; then
        printf "\033[34m[ 📜 LOGS ] Analyzing log target '$1'...\033[0m\n"
        lnav "$@"
    else
        printf "\033[31m[ ❌ ERROR ] Log file or directory '$1' not found!\033[0m\n"
        return 1
    fi
}

genpass() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔐 GENPASS USAGE ]\033[0m\n"
        printf "  \033[32mgenpass [length]\033[0m — Generate strong random password via pwgen & copy to clipboard (default: 20)\n"
        printf "\033[33m[ 💡 EXAMPLE ] genpass 32\033[0m\n"
        return 0
    fi

    local len="${1:-20}"
    pwgen -sy "$len" 1 | tee >(wl-copy 2>/dev/null || xclip -selection clipboard 2>/dev/null)
    printf "\033[32m[ 🔐 COPIED ] Strong %s-char password generated & copied to clipboard!\033[0m\n" "$len"
}

extract() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🗜️ EXTRACT USAGE ]\033[0m\n"
        printf "  \033[32mextract <archive>\033[0m — Universal archive unpacker (.zip, .jar/.war, .tar.*, .tgz, .txz, .7z, .rar, .gz, .xz, .zst)\n"
        printf "\033[33m[ 💡 EXAMPLE ] extract project.tar.zst\033[0m\n"
        return 0
    fi

    if [[ -f "$1" ]]; then
        case "$1" in
            *.zip)          ripunzip unzip-file "$1" ;;
            *.jar|*.war)    ripunzip unzip-file "$1" -d "${1%.*}" ;;
            *.tar.*)        tar -xf "$1" ;;
            *.tgz)          tar -xzf "$1" ;;
            *.txz)          tar -xJf "$1" ;;
            *.7z)           7z x "$1" ;;
            *.rar)          unrar x "$1" ;;
            *.gz)           gunzip "$1" ;;
            *.xz)           unxz "$1" ;;
            *.zst)          unzstd "$1" ;;
            *)              printf "\033[31m[ ❌ ERROR ] Unknown archive format: '$1'\033[0m\n"; return 1 ;;
        esac
    else
        printf "\033[31m[ ❌ ERROR ] Archive file '$1' not found!\033[0m\n"
        return 1
    fi
}

update-all() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔄 UPDATE-ALL USAGE ]\033[0m\n"
        printf "  \033[32mupdate-all\033[0m — Sync & upgrade openSUSE Zypper packages, Pipx tools, Flatpak apps & check reboot status\n"
        return 0
    fi

    printf "\033[34m=== 1. Upgrading openSUSE Leap Repos & Core System ===\033[0m\n"
    sudo zypper ref && sudo zypper up

    printf "\033[34m=== 2. Upgrading Isolated Pipx Applications ===\033[0m\n"
    if command -v pipx &>/dev/null; then
        pipx upgrade-all
    else
        printf "\033[33m[ 💡 INFO ] 'pipx' not installed, skipping Python CLI tools.\033[0m\n"
    fi

    printf "\033[34m=== 3. Upgrading Isolated Flatpak Applications ===\033[0m\n"
    if command -v flatpak &>/dev/null; then
        flatpak update
    fi

    printf "\033[34m=== 4. Checking Reboot Requirement ===\033[0m\n"
    sudo zypper needs-rebooting
    local reboot_status=$?

    if [[ $reboot_status -eq 102 ]]; then
        printf "\033[33m[ ⚠️  REBOOT ] Core libraries or kernel updated — reboot recommended!\033[0m\n"
    elif [[ $reboot_status -eq 0 ]]; then
        printf "\033[32m[ ✅ OK ] No reboot required.\033[0m\n"
    fi

    printf "\033[32mopenSUSE system synchronization completed successfully! 🚀🔥\033[0m\n"
}

up-venv() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐍 UP-VENV USAGE ]\033[0m\n"
        printf "  \033[32mup-venv\033[0m — Upgrade all outdated pip packages inside active VIRTUAL_ENV or local '.venv'\n"
        return 0
    fi

    if [[ -n "$VIRTUAL_ENV" ]]; then
        printf "\033[34m[ ⚙️ PYTHON ] Upgrading outdated packages inside active virtual environment...\033[0m\n"
        pip list --outdated --format=columns 2>/dev/null | tail -n +3 | awk '{print $1}' | xargs -r -n1 pip install --upgrade 2>/dev/null
        printf "\033[32m[ ✅ DONE ] All packages in active venv are up to date! 🐍🚀\033[0m\n"
    elif [[ -d ".venv" ]]; then
        printf "\033[34m[ ⚙️ PYTHON ] Upgrading outdated packages inside local '.venv'...\033[0m\n"
        .venv/bin/pip list --outdated --format=columns 2>/dev/null | tail -n +3 | awk '{print $1}' | xargs -r -n1 .venv/bin/pip install --upgrade 2>/dev/null
        printf "\033[32m[ ✅ DONE ] All packages in .venv are up to date! 🐍🚀\033[0m\n"
    else
        printf "\033[31m[ ❌ ERROR ] Python virtual environment target not active or '.venv' directory missing!\033[0m\n"
        return 1
    fi
}

up-node() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 📦 UP-NODE USAGE ]\033[0m\n"
        printf "  \033[32mup-node [package.json]\033[0m — Update all local npm dependencies in project directory\n"
        return 0
    fi

    local target="${1:-package.json}"
    if [[ -f "$target" ]]; then
        printf "\033[34m[ 📦 NODE ] Upgrading all local npm dependencies based on '$target'... 📦🚀\033[0m\n"
        npm update
        printf "\033[32m[ 🎉 SUCCESS ] All local dependencies are up to date! ✅\033[0m\n"
    else
        printf "\033[31m[ ❌ ERROR ] Bro, package.json not found! Are you sure this is a Node.js project? 🛑\033[0m\n"
        return 1
    fi
}

apache() {
    if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🌐 APACHE USAGE ]\033[0m\n"
        printf "  \033[32mapache <start|stop|status|restart>\033[0m — Control Apache2 & PHP-FPM systemd services\n"
        printf "\033[33m[ 💡 EXAMPLE ] apache start\033[0m\n"
        return 0
    fi

    case "$1" in
        start)
            sudo systemctl start apache2 php-fpm && \
            printf "\033[32m[ 🚀 ONLINE ] Apache2 and PHP-FPM processes launched successfully! Check http://localhost\033[0m\n"
            ;;
        stop)
            sudo systemctl stop apache2 php-fpm && \
            printf "\033[31m[ 🛑 OFFLINE ] Web-server infrastructure gracefully shut down. Context cleared.\033[0m\n"
            ;;
        status|restart)
            sudo systemctl "$1" apache2 php-fpm
            ;;
        *)
            printf "\033[31m[ ❌ ERROR ] Unknown action '%s'! Usage: apache [start|stop|status|restart]\033[0m\n" "$1"
            return 1
            ;;
    esac
}

api() {
    if ! command -v xh &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'xh' not installed. Run: sudo zypper in xh\033[0m\n"
        return 1
    fi

    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🌐 API CLIENT (xh) USAGE ]\033[0m\n"
        printf "  \033[32mapi get <url> [params...]\033[0m     — Send HTTP GET request\n"
        printf "  \033[32mapi post <url> [json/data...]\033[0m — Send HTTP POST JSON request\n"
        printf "  \033[32mapi put <url> [json/data...]\033[0m  — Send HTTP PUT JSON request\n"
        printf "  \033[32mapi patch <url> [data...]\033[0m     — Send HTTP PATCH JSON request\n"
        printf "  \033[32mapi delete <url> [params...]\033[0m  — Send HTTP DELETE request\n"
        printf "  \033[32mapi head <url>\033[0m                — Fetch response headers only\n"
        printf "\033[33m[ 💡 EXAMPLE ] api post https://httpbin.org user=kirill role=dev\033[0m\n"
        return 0
    fi

    local method="${1:u}"
    local url="$2"

    case "$method" in
        GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS)
            if [[ -z "$url" ]]; then
                printf "\033[31m[ ❌ ERROR ] Missing URL! Usage: api %s <url> [args...]\033[0m\n" "${method:l}"
                return 1
            fi
            shift 2
            printf "\033[34m[ 🚀 %s ] Sending request to %s ...\033[0m\n" "$method" "$url"
            printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
            xh "$method" "$url" "$@"
            local exit_code=$?
            printf "\033[33m──────────────────────────────────────────────────\033[0m\n"
            return $exit_code
            ;;
        *)
            printf "\033[31m[ ❌ ERROR ] Unknown HTTP method '%s'! Use: get, post, put, patch, delete, head\033[0m\n" "$1"
            return 1
            ;;
    esac
}

dimages() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 💿 DIMAGES USAGE ]\033[0m\n"
        printf "  \033[32mdimages [docker_args...]\033[0m — List locally stored Docker images\n"
        return 0
    fi

    docker images "$@"
    printf "\033[34m[ 💿 ] Local images indexed.\033[0m\n"
}

dps() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🐋 DPS USAGE ]\033[0m\n"
        printf "  \033[32mdps [docker_args...]\033[0m — List all Docker containers (Names, Status & Ports table)\n"
        return 0
    fi

    docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' "$@"
    printf "\033[32m[ 🐋 ] Active containers logged successfully.\033[0m\n"
}

dclean() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🔥 DCLEAN USAGE ]\033[0m\n"
        printf "  \033[32mdclean\033[0m — Hard purge all unused Docker containers, images, networks & volumes (with confirmation)\n"
        return 0
    fi

    printf "\033[33m[ ⚠️ WARNING ] Hard purging unused Docker infrastructure... Are you sure, bro? [y/N]: \033[0m"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        docker system prune -a --volumes -f
        printf "\033[31m[ 🔥 CLEAN ] Every unused container, image and network has been hard purged!\033[0m\n"
    else
        printf "\033[34m[ 🧊 CANCELED ] Purge context skipped.\033[0m\n"
    fi
}

cleanpip() {
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
        printf "\033[34m[ 🧹 CLEANPIP USAGE ]\033[0m\n"
        printf "  \033[32mcleanpip\033[0m — Purge downloaded pip wheels & HTTP cache and report freed disk space\n"
        return 0
    fi

    if ! command -v pip &>/dev/null; then
        printf "\033[33m[ ⚠️ MISSING ] 'pip' not found in current environment!\033[0m\n"
        return 1
    fi

    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/pip"
    local before_size="0B"
    [[ -d "$cache_dir" ]] && before_size=$(du -sh "$cache_dir" 2>/dev/null | awk '{print $1}')

    printf "\033[34m[ 🧹 PIP CACHE ] Purging downloaded wheels & HTTP cache (size: %s)...\033[0m\n" "$before_size"
    pip cache purge 2>/dev/null
    rm -rf "$cache_dir"/* 2>/dev/null
    printf "\033[32m[ ✅ DONE ] Pip cache purged (%s freed)!\033[0m\n" "$before_size"
}


alias myosinfo="fastfetch"
alias gitprinfo="onefetch"
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons'
alias cat='bat --paging=never'
alias offlaptop="systemctl poweroff"
alias rebootlaptop="systemctl reboot"
alias checksession='echo $XDG_SESSION_TYPE'
alias checknet="speedtest"
alias checkports="snitch"
alias netmonitoring="netwatch"
alias changeconfzsh="p10k configure"
alias workwithgit="lazygit"
alias workwithdocker="lazydocker"
alias workwithfiles="yazi"
alias workwithsql="sqlit"
alias davinci="prime-run /opt/resolve/bin/resolve"
