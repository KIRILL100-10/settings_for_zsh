# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

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

deleteorphans() {
    local orphans=$(yay -Qdtq)
    if [[ -n "$orphans" ]]; then
        echo "Found orphans: $(echo "$orphans" | wc -l) pcs. Removing... 🧹"
        yay -Rns $orphans
    else
        echo "System is clean, nothing to remove! ✨"
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

drawdocker() {
    local file="${1:-Dockerfile}"
    if [[ -f "$file" ]]; then
        echo "Generating visual graph for '$file'... 🎨"
        dockerfilegraph -f "$file" -o png --legend
        echo "Done! Automatically opening the image... ✨"

        xdg-open "$PWD/Dockerfile.png" &>/dev/null &
    else
        echo "Bro, file '$file' not found! 🐳"
    fi
}

drawgit() {
    if [[ -d ".git" ]] || git rev-parse --is-inside-work-tree &>/dev/null; then
        local output="git-history.png"
        echo "Generating a large visual map of commits and branches... 🎨"

        git-big-picture -o "$output"

        echo "Done! Automatically opening the image '$output'... ✨"
        xdg-open "$PWD/$output" &>/dev/null &
    else
        echo "Bro, this directory is not a Git repository! 🛑"
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

tomd() {
    if [[ -f "$1" ]]; then
        echo "Converting document '$1' into clean Markdown... 📄➡️📝"
        pandoc "$1" -o "${1%.*}.md"
        echo "Done! File '${1%.*}.md' successfully created. ✨"
    else
        echo "Bro, file '$1' not found! 🛑"
    fi
}

toword() {
    if [[ -f "$1" ]]; then
        echo "Converting Markdown '$1' into an official Word document... 📝➡️📄"
        pandoc "$1" -o "${1%.*}.docx"
        echo "Done! File '${1%.*}.docx' successfully created. ✅"
    else
        echo "Bro, file '$1' not found! 🛑"
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
alias gg="git-graph"
alias dd="dockerydo"
alias dclean="docker system prune -a --volumes"
alias tcc="temperature-converter-cli"
alias myos="fastfetch"
alias k8s-start="sudo systemctl start k3s && echo 'Cloud infrastructure initialized! Node Ready 🚀🐳'"
alias k8s-stop="sudo systemctl stop k3s && echo 'Cloud infrastructure stopped. RAM released! 🧹✨'"
alias k8s-status="sudo systemctl status k3s"
