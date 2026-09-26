# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change the frequency the auto-updater is run (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to set how old an update must be before it's applied, manually or via the auto-updater (in days).
# zstyle ':omz:update' cooldown 10

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export KUBECONFIG=~/.kube/config
export PATH="$HOME/.local/bin:$PATH"
export LIBVA_DRIVER_NAME=nvidia
source <(kubectl completion zsh)

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

makeignore() {
    if [[ -z "$1" ]]; then
        echo -e "\e[31m[ ❌ ERROR ] Specify technology! Example: makeignore python\e[0m"
        echo "Popular: python, node, go, c++, java, jetbrains"
        return 1
    fi
    echo -e "\e[34m[ 📄 GENERATING ] Fetching official .gitignore for '$1'...\e[0m"
    add-gitignore "$1"
    if [[ -f ".gitignore" ]]; then
        echo -e "\e[32m[ 🎉 DONE ] .gitignore for '$1' successfully initialized!\e[0m"
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

liveserver() {
    echo -e "\e[34m[ 🚀 SERVING ] Spawning local node web server with hot-reload...\e[0m"
    browser-sync start --server --files "**/*.html, **/*.css, **/*.js, **/*.vue"
}

staticserver() {
    local port="${1:-5000}"
    echo -e "\e[34m[ 🚀 SERVING ] Spawning native Python static server on port $port...\e[0m"
    (sleep 1 && xdg-open "http://localhost:$port" &>/dev/null) &
    python -m http.server "$port"
}

alias update-all="echo '=== 1. Upgrading Fedora Repos ===' && sudo dnf upgrade --refresh && echo '=== 2. Upgrading Global NPM ===' && sudo npm update -g && echo '=== 3. Upgrading Rust Toolchain ===' && rustup update && echo '=== 4. Upgrading User Pip Packages ===' && pip list --outdated --format=columns | tail -n +3 | awk '{print \$1}' | xargs -n1 pip install --user --upgrade 2>/dev/null; echo '=== 5. Upgrading Flatpaks ===' && flatpak update && echo 'System synchronization completed successfully! 🚀🔥'"
alias up-venv="pip list --outdated --format=columns | tail -n +3 | awk '{print \$1}' | xargs -n1 pip install --upgrade 2>/dev/null && echo 'All packages in .venv are up to date! 🐍🚀'"
alias npmi="npm init -y"
alias up-node="if [[ -f \"package.json\" ]]; then echo 'Upgrading all local npm packages... 📦🚀' && npm update && echo 'All local dependencies are up to date! ✅'; else echo 'Bro, package.json not found! Are you sure this is a Node.js project? 🛑'; fi"
alias djrun="python manage.py runserver"
alias djinst="pip install django"
alias djmm="python manage.py makemigrations"
alias djmig="python manage.py migrate"
alias djm="python manage.py makemigrations && python manage.py migrate"
alias djuser="python manage.py createsuperuser"
alias djsh="python manage.py shell"
alias postgresi="postgres-language-server init"
alias dcup="docker compose up -d"
alias dcdwn="docker compose down"
alias dclog="docker compose logs -f"
alias dcps="docker compose ps"
alias dclean="docker system prune -a --volumes"
alias myos="fastfetch"
alias mygit="onefetch"
alias k8s-start="sudo systemctl start k3s && mkdir -p ~/.kube && sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config && sudo chown \$(id -u):\$(id -g) ~/.kube/config && chmod 600 ~/.kube/config && echo 'Cloud infrastructure initialized! Node Ready 🚀🐳'"
alias k8s-stop="sudo systemctl stop k3s && echo 'Cloud infrastructure stopped. RAM released! 🧹✨'"
alias k8s-status="sudo systemctl status k3s"
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias updatezsh="p10k configure"
