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

tomov() {
    ffmpeg -i "$1" -c:v dnxhd -profile:v dnxhr_hqx -pix_fmt yuv422p10le -c:a pcm_s24le -ar 48000 "${1%.*}.mov"
}

tomp4() {
    ffmpeg -i "$1" -vcodec libx264 -pix_fmt yuv420p -crf 20 -acodec aac "${1%.*}.mp4"
}

extsound() {
    ffmpeg -i "$1" -vn -c:a pcm_s16le -ar 48000 "${1%.*}.wav"
}

towav() {
    ffmpeg -i "$1" -ar 48000 -c:a pcm_s24le "${1%.*}.wav"
}

splitaudio() {
    demucs -d cuda "$1"
}

checkmedia() {
    if [[ -n "$1" ]]; then
        if [[ -f "$1" ]]; then
            echo "Analyzing media metadata for '$1'... 🎥📊"
            mediainfo "$1"
        else
            echo "Bro, media file '$1' not found! 🛑"
        fi
    else
        echo "Bro, specify a video/audio file! For example: checkmedia movie.mp4 🎬"
    fi
}

runpy() {
    if [[ -n "$1" ]]; then
        if [[ -f "$1" ]]; then
            python "$1"
        else
            echo "Bro, file '$1' not found in this directory! 🛑"
        fi
    else
        if [[ -f "main.py" ]]; then
            python main.py
        elif [[ -f "app.py" ]]; then
            python app.py
        else
            echo "Bro, specify a file (e.g., runpy test.py) or create main.py/app.py 🐍"
        fi
    fi
}

checkdocker() {
    local file="${1:-Dockerfile}"
    if [[ -f "$file" ]]; then
        hadolint "$file"
    else
        echo "Bro, file '$file' not found! 🐳"
    fi
}

checkcpp() {
    local target="${1:-.}"
    if [[ -e "$target" ]]; then
        echo "Running deep C/C++ analysis for '$target'... 🛠⚙️"
        cppcheck --enable=all --inconclusive --force "$target"
    else
        echo "Bro, file or directory '$target' not found! 🛑"
    fi
}

makeignore() {
    if [[ -z "$1" ]]; then
        echo "Bro, specify the technology! For example: makeignore python or makeignore node 🛠"
        echo "Popular: python, node, go, c++, java, jetbrains"
        return 1
    fi
    echo "Generating official .gitignore for '$1'... 📄✨"
    add-gitignore "$1"
    if [[ -f ".gitignore" ]]; then
        echo "Done! File .gitignore for '$1' successfully created in the current directory. ✅"
    fi
}

deleteorphans() {
    echo "Checking for unused dependencies in Fedora... 🔍"

    local orphans=$(dnf list --autoremove 2>/dev/null | tail -n +2)

    if [[ -n "$orphans" && "$orphans" != *"Доступные пакеты"* && "$orphans" != *"Available Packages"* ]]; then
        local count=$(echo "$orphans" | wc -l)
        echo "Found orphans: $count pcs. Removing... 🧹"
        echo "----------------------------------------"
        echo "$orphans"
        echo "----------------------------------------"

        sudo dnf autoremove
    else
        echo "System is clean, no unused dependencies to remove! ✨"
    fi
}

va() {
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
    else
        echo "Bro, there is no virtual environment here! Type 'venv' first 🐍"
    fi
}

liveserver() {
    echo "Starting local web server with live reload... 🚀🌐"
    browser-sync start --server --files "**/*.html, **/*.css, **/*.js, **/*.vue"
}

staticserver() {
    local port="${1:-5000}"
    echo "Starting quick static server on port $port... 🚀🌐"
    (sleep 1 && xdg-open "http://localhost:$port" &>/dev/null) &
    python -m http.server "$port"
}

alias venv="python -m venv .venv && source .venv/bin/activate"
alias postgresi="postgres-language-server init"
alias npmi="npm init -y"
alias startdjango="python manage.py runserver"
alias installdjango="pip install django"
alias createmigrations="python manage.py makemigrations"
alias applymigrations="python manage.py migrate"
alias migrations="python manage.py makemigrations && python manage.py migrate"
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

source <(kubectl completion zsh)

export PATH="$HOME/.local/bin:$PATH"

