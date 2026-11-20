if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

export LIBVA_DRIVER_NAME=nvidia

export PATH=/usr/local/cuda-13.4/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-13.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export JAVA_HOME=/usr/lib64/jvm/java-25-openjdk-25
export PATH="$JAVA_HOME/bin:/opt/gradle/gradle-9.9.1/bin:$PATH"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source "$ZSH/oh-my-zsh.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


yt() {
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
            printf "\033[33m[ 💡 INFO ] Usage: yt [best|1080|mp3] \"<url>\"\033[0m\n"
            ;;
    esac
}

tomov() {
    if [ -z "$1" ]; then
        printf "\033[31m[ ❌ ERROR ] Please specify a file! Example: tomov input.mp4\033[0m\n"
        return 1
    fi
    local start_time=$(date +%s)
    printf "\033[34m[ 🚀 PROCESS ] Transcoding '$1' to DNxHR HQX (.mov)... Hardware rendering enabled.\033[0m\n"

    ffmpeg -i "$1" -c:v dnxhd -profile:v dnxhr_hqx -pix_fmt yuv422p10le -c:a pcm_s24le -ar 48000 "${1%.*}.mov"

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    printf "\033[32m[ 🎉 DONE ] Successfully encoded in %s seconds!\033[0m\n" "$duration"
}

tomp4() {
    if [ -z "$1" ]; then
        printf "\033[31m[ ❌ ERROR ] Please specify a file! Example: tomp4 master.mov\033[0m\n"
        return 1
    fi
    local start_time=$(date +%s)
    printf "\033[34m[ 🚀 PROCESS ] Compressing '$1' to H.264 MP4 (CRF 20)... High efficiency.\033[0m\n"

    ffmpeg -i "$1" -vcodec libx264 -pix_fmt yuv420p -crf 20 -acodec aac "${1%.*}.mp4"

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    printf "\033[32m[ 🎉 DONE ] Compression completed in %s seconds!\033[0m\n" "$duration"
}

extsound() {
    if [ -z "$1" ]; then printf "\033[31m[ ❌ ERROR ] Specify a file!\033[0m\n"; return 1; fi
    printf "\033[34m[ 🚀 PROCESS ] Extracting audio to WAV 16-bit...\033[0m\n"
    ffmpeg -i "$1" -vn -c:a pcm_s16le -ar 48000 "${1%.*}.wav"
    printf "\033[32m[ 🎉 DONE ] Audio track saved!\033[0m\n"
}

towav() {
    if [ -z "$1" ]; then printf "\033[31m[ ❌ ERROR ] Specify a file!\033[0m\n"; return 1; fi
    printf "\033[34m[ 🚀 PROCESS ] Upconverting audio to WAV 24-bit PCM...\033[0m\n"
    ffmpeg -i "$1" -ar 48000 -c:a pcm_s24le "${1%.*}.wav"
    printf "\033[32m[ 🎉 DONE ] Audio upconverted successfully!\033[0m\n"
}

splitaudio() {
    if [ -z "$1" ]; then
        printf "\033[31m[ ❌ ERROR ] Specify an audio file!\033[0m\n"
        return 1
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
    if [[ -z "$1" ]]; then
        printf "\033[31m[ ❌ ERROR ] Please specify an audio/video file! Example: createsub movie.wav\033[0m\n"
        return 1
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
    if [[ -n "$1" ]]; then
        if [[ -f "$1" ]]; then
            printf "\033[34m[ 🔍 ANALYZING ] Fetching technical metadata for '$1'... 🎥📊\033[0m\n"
            mediainfo "$1"
        else
            printf "\033[31m[ ❌ ERROR ] Media file '$1' not found!\033[0m\n"
        fi
    else
        printf "\033[33m[ 💡 INFO ] Specify a file! Example: checkmedia movie.mp4\033[0m\n"
    fi
}

checkdocker() {
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
    fi
}

checkcpp() {
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
    fi
}

checkshell() {
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
    fi
}

venv() {
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
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
    else
        printf "\033[31m[ ❌ ERROR ] Local active target '.venv' not found! Build it via 'venv' first.\033[0m\n"
    fi
}

runpy() {
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

runjava() {
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

runjavafx() {
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

runc() {
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

workwithmd() {
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
    local len="${1:-20}"
    pwgen -sy "$len" 1 | tee >(wl-copy 2>/dev/null || xclip -selection clipboard 2>/dev/null)
    printf "\033[32m[ 🔐 COPIED ] Strong %s-char password generated & copied to clipboard!\033[0m\n" "$len"
}


extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.zip)     ripunzip unzip-file "$1" ;;
            *.tar.*)   tar -xf "$1" ;;
            *.tgz)     tar -xzf "$1" ;;
            *.txz)     tar -xJf "$1" ;;
            *.7z)      7z x "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.xz)      unxz "$1" ;;
            *.zst)     unzstd "$1" ;;
            *)         echo "❌ Unknown archive format: '$1'" ;;
        esac
    else
        echo "❌ File '$1' not found"
    fi
}

update-all() {
    printf "\033[34m=== 1. Upgrading openSUSE Leap Repos & Core System ===\033[0m\n"
    sudo zypper ref && sudo zypper up -y

    printf "\033[34m=== 2. Upgrading Isolated Pipx Applications ===\033[0m\n"
    if command -v pipx &>/dev/null; then
        pipx upgrade-all
    else
        printf "\033[33m[ 💡 INFO ] 'pipx' not installed, skipping Python CLI tools.\033[0m\n"
    fi

    printf "\033[34m=== 3. Upgrading Isolated Flatpak Applications ===\033[0m\n"
    if command -v flatpak &>/dev/null; then
        flatpak update -y
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
            printf "\033[33m[ 💡 INFO ] Usage: apache [start|stop|status|restart]\033[0m\n"
            ;;
    esac
}

dimages() {
    docker images "$@"
    printf "\033[34m[ 💿 ] Local images indexed.\033[0m\n"
}

dps() {
    docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' "$@"
    printf "\033[32m[ 🐋 ] Active containers logged successfully.\033[0m\n"
}

dclean() {
    printf "\033[33m[ ⚠️ WARNING ] Hard purging unused Docker infrastructure... Are you sure, bro? [y/N]: \033[0m"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        docker system prune -a --volumes -f
        printf "\033[31m[ 🔥 CLEAN ] Every unused container, image and network has been hard purged!\033[0m\n"
    else
        printf "\033[34m[ 🧊 CANCELED ] Purge context skipped.\033[0m\n"
    fi
}


alias cleanpip="pip cache purge"
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
alias netmonitoring="netwatch"
alias codestatics="tokei"
alias changeconfzsh="p10k configure"
alias workwithgit="lazygit"
alias workwithdocker="lazydocker"
alias workwithapi="posting"
alias workwithfiles="yazi"
alias workwithsql="sqlit"
alias davinci="prime-run /opt/resolve/bin/resolve"
