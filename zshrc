if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

export LIBVA_DRIVER_NAME=nvidia

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

tomov() {
    if [ -z "$1" ]; then
        echo -e "\e[31m[ ❌ ERROR ] Please specify a file! Example: tomov input.mp4\e[0m"
        return 1
    fi
    local start_time=$(date +%s)
    echo -e "\e[34m[ 🚀 PROCESS ] Transcoding '$1' to DNxHR HQX (.mov)... Hardware rendering enabled.\e[0m"

    ffmpeg -i "$1" -c:v dnxhd -profile:v dnxhr_hqx -pix_fmt yuv422p10le -c:a pcm_s24le -ar 48000 "${1%.*}.mov"

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    echo -e "\e[32m[ 🎉 DONE ] Successfully encoded in ${duration} seconds!\e[0m"
}

tomp4() {
    if [ -z "$1" ]; then
        echo -e "\e[31m[ ❌ ERROR ] Please specify a file! Example: tomp4 master.mov\e[0m"
        return 1
    fi
    local start_time=$(date +%s)
    echo -e "\e[34m[ 🚀 PROCESS ] Compressing '$1' to H.264 MP4 (CRF 20)... High efficiency.\e[0m"

    ffmpeg -i "$1" -vcodec libx264 -pix_fmt yuv420p -crf 20 -acodec aac "${1%.*}.mp4"

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    echo -e "\e[32m[ 🎉 DONE ] Compression completed in ${duration} seconds!\e[0m"
}

extsound() {
    if [ -z "$1" ]; then echo -e "\e[31m[ ❌ ERROR ] Specify a file!\e[0m"; return 1; fi
    echo -e "\e[34m[ 🚀 PROCESS ] Extracting audio to WAV 16-bit...\e[0m"
    ffmpeg -i "$1" -vn -c:a pcm_s16le -ar 48000 "${1%.*}.wav"
    echo -e "\e[32m[ 🎉 DONE ] Audio track saved!\e[0m"
}

towav() {
    if [ -z "$1" ]; then echo -e "\e[31m[ ❌ ERROR ] Specify a file!\e[0m"; return 1; fi
    echo -e "\e[34m[ 🚀 PROCESS ] Upconverting audio to WAV 24-bit PCM...\e[0m"
    ffmpeg -i "$1" -ar 48000 -c:a pcm_s24le "${1%.*}.wav"
    echo -e "\e[32m[ 🎉 DONE ] Audio upconverted successfully!\e[0m"
}

splitaudio() {
    if [ -z "$1" ]; then echo -e "\e[31m[ ❌ ERROR ] Specify an audio file!\e[0m"; return 1; fi
    echo -e "\e[34m[ 🧠 AI PROCESS ] Running Demucs neural network on CUDA (NVIDIA GPU)...🏼\e[0m"
    demucs -d cuda "$1"
}

createsub() {
    if [[ -z "$1" ]]; then
        echo -e "\e[31m[ ❌ ERROR ] Please specify an audio/video file! Example: createsub movie.wav\e[0m"
        return 1
    fi

    if [[ ! -f "$1" ]]; then
        echo -e "\e[31m[ ❌ ERROR ] Target file '$1' not found in this directory! 🛑\e[0m"
        return 1
    fi

    local TARGET_FILE=$(realpath "$1")
    local WHISPER_DIR="$HOME/Whisper AI"

    echo -e "\e[34m[ 🚀 INITIALIZING ] Activating Whisper Turbo context on Python 3.14... \e[0m"

    export LD_LIBRARY_PATH="$WHISPER_DIR/.venv/lib64/python3.14/site-packages/nvidia/cublas/lib:$WHISPER_DIR/.venv/lib64/python3.14/site-packages/nvidia/cudnn/lib:$LD_LIBRARY_PATH"

    pushd "$WHISPER_DIR" &>/dev/null
    source .venv/bin/activate

    python transcribe.py "$TARGET_FILE"

    deactivate
    popd &>/dev/null

    echo -e "\e[32m[ ✅ SUCCESS ] Terminal context restored to host Fedora.\e[0m"
}

checkmedia() {
    if [[ -n "$1" ]]; then
        if [[ -f "$1" ]]; then
            echo -e "\e[34m[ 🔍 ANALYZING ] Fetching technical metadata for '$1'... 🎥📊\e[0m"
            mediainfo "$1"
        else
            echo -e "\e[31m[ ❌ ERROR ] Media file '$1' not found!\e[0m"
        fi
    else
        echo -e "\e[33m[ 💡 INFO ] Specify a file! Example: checkmedia movie.mp4\e[0m"
    fi
}

checkdocker() {
    local file="${1:-Dockerfile}"
    if [[ -f "$file" ]]; then
        echo -e "\e[34m[ 🔍 LINTING ] Running Hadolint on '$file'...\e[0m"
        hadolint "$file"
    else
        echo -e "\e[31m[ ❌ ERROR ] Dockerfile '$file' not found!\e[0m"
    fi
}

checkcpp() {
    local target="${1:-.}"
    if [[ -e "$target" ]]; then
        echo -e "\e[34m[ 🔍 ANALYSIS ] Running deep C/C++ analysis on '$target'... 🛠⚙️\e[0m"
        cppcheck --enable=all --inconclusive --force "$target"
    else
        echo -e "\e[31m[ ❌ ERROR ] Directory or file '$target' not found!\e[0m"
    fi
}

checkshell() {
    local file="${1:-script.sh}"
    if [[ -f "$file" ]]; then
        echo -e "\e[34m[ 🔍 LINTING ] Running ShellCheck on '$file'...\e[0m"
        shellcheck "$file"
    else
        echo -e "\e[31m[ ❌ ERROR ] Bash script '$file' not found!\e[0m"
    fi
}

deleteorphans() {
    echo -e "\e[34m[ 🔍 SCANNING ] Checking for unused dependencies in Fedora... 🔍\e[0m"
    local orphans=$(LANG=C dnf list --autoremove 2>/dev/null | tail -n +2)

    if [[ -n "$orphans" && "$orphans" != *"Available Packages"* ]]; then
        local count=$(echo "$orphans" | wc -l)
        echo -e "\e[33m[ 🧹 FOUND ] Detected $count unneeded dependencies. Cleaning up...\e[0m"
        echo "----------------------------------------"
        echo "$orphans"
        echo "----------------------------------------"
        sudo dnf autoremove
    else
        echo -e "\e[32m[ ✨ CLEAN ] System is pure! No unused packages found.\e[0m"
    fi
}

venv() {
    if [[ -d ".venv" ]]; then
        echo -e "\e[33m[ 💡 INFO ] Virtual environment already exists. Run 'va' to activate it.\e[0m"
    else
        echo -e "\e[34m[ 🛠️ ENVIRONMENT ] Initializing Python venv in '.venv'...\e[0m"
        python -m venv .venv

        if [[ -f ".venv/bin/activate" ]]; then
            echo -e "\e[34m[ 🚀 ACTIVATING ] Loading environment context...\e[0m"
            source .venv/bin/activate
            echo -e "\e[34m[ 🧹 UPGRADING ] Maximizing pip version...\e[0m"
            pip install --upgrade pip &>/dev/null
            echo -e "\e[32m[ 🎉 DONE ] Virtual environment is up, active and ready for Django!\e[0m"
        else
            echo -e "\e[31m[ ❌ ERROR ] Critical failure during venv deployment!\e[0m"
        fi
    fi
}

va() {
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
    else
        echo -e "\e[31m[ ❌ ERROR ] Local active target '.venv' not found! Build it via 'venv' first.\e[0m"
    fi
}

runpy() {
    if [[ -n "$1" ]]; then
        if [[ -f "$1" ]]; then
            python "$1"
        else
            echo -e "\e[31m[ ❌ ERROR ] Direct file target '$1' not found!\e[0m"
        fi
    else
        if [[ -f "main.py" ]]; then
            python main.py
        elif [[ -f "app.py" ]]; then
            python app.py
        else
            echo -e "\e[33m[ 💡 INFO ] Provide target file (e.g. runpy script.py) or create main.py/app.py\e[0m"
        fi
    fi
}

runjava() {
    if [[ -z "$1" ]]; then
        echo -e "\e[31m[ ❌ ERROR ] Please specify a Java file, bro! Example: runjava Main.java\e[0m"
        return 1
    fi

    if [[ ! -f "$1" ]]; then
        echo -e "\e[31m[ ❌ ERROR ] Target file '$1' not found in this directory! 🛑\e[0m"
        return 1
    fi

    local FILE_NAME="$1"
    local CLASS_NAME="${FILE_NAME%.java}"

    echo -e "\e[34m[ ⚙️ COMPILING ] Compiling $FILE_NAME via OpenJDK core...\e[0m"

    if javac "$FILE_NAME"; then
        echo -e "\e[32m[ 🎉 SUCCESS ] Compilation completed! Launching JVM environment...\e[0m"
        echo -e "\e[33m──────────────────────────────────────────────────\e[0m"

        java "$CLASS_NAME"

        echo -e "\e[33m──────────────────────────────────────────────────\e[0m"
        echo -e "\e[34m[ 🧼 CLEANING ] Purging temporary bytecode cache...\e[0m"

        rm -f "${CLASS_NAME}.class"
        echo -e "\e[32m[ ✅ DONE ] System is clean, host context restored! 😎🏆\e[0m"
    else
        echo -e "\e[31m[ ❌ BUILD FAILED ] Target build crashed! Check your syntax inside Zed.\e[0m"
        return 1
    fi
}

alias update-all="echo '=== 1. Upgrading Fedora Repos ===' && sudo dnf upgrade --refresh && echo '=== 2. Upgrading User Pip Packages ===' && pip list --outdated --format=columns | tail -n +3 | awk '{print \$1}' | xargs -n1 pip install --user --upgrade 2>/dev/null; echo '=== 3. Upgrading Flatpaks ===' && flatpak update && echo 'System synchronization completed successfully! 🚀🔥'"
alias up-venv="pip list --outdated --format=columns | tail -n +3 | awk '{print \$1}' | xargs -n1 pip install --upgrade 2>/dev/null && echo 'All packages in .venv are up to date! 🐍🚀'"
alias npmi="npm init -y"
alias up-node="if [[ -f \"package.json\" ]]; then echo 'Upgrading all local npm packages... 📦🚀' && npm update && echo 'All local dependencies are up to date! ✅'; else echo 'Bro, package.json not found! Are you sure this is a Node.js project? 🛑'; fi"
alias webstart="sudo systemctl start httpd php-fpm && echo -e '\e[32m[ 🚀 ONLINE ] Apache and PHP-FPM processes launched successfully! Check http://localhost\e[0m'"
alias webstatus="sudo systemctl status httpd"
alias webstop="sudo systemctl stop httpd php-fpm && echo -e '\e[31m[ 🛑 OFFLINE ] Web-server infrastructure gracefully shut down. Context cleared.\e[0m'"
alias cleanpip="pip cache purge"
alias djrun="python manage.py runserver"
alias djinst="pip install django"
alias djmm="python manage.py makemigrations"
alias djmig="python manage.py migrate"
alias djm="python manage.py makemigrations && python manage.py migrate"
alias djuser="python manage.py createsuperuser"
alias djsh="python manage.py shell"
alias dps="docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' && echo -e '\e[32m[ 🐋 ] Active containers logged successfully.\e[0m'"
alias dimages="docker images && echo -e '\e[34m[ 💿 ] Local images indexed.\e[0m'"
alias dpurge="docker system prune -a --volumes -f && echo -e '\e[31m[ 🔥 CLEAN ] Every unused container, image and network has been hard purged!\e[0m'"
alias dcup="docker compose up -d"
alias dcdwn="docker compose down"
alias dclog="docker compose logs -f"
alias dcps="docker compose ps"
alias myos="fastfetch"
alias checkdisk="duf"
alias mygit="onefetch"
alias updatezsh="p10k configure"
