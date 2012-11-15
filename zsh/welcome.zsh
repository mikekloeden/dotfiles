if [[ -o interactive ]]; then
    # say hello on login
    uptime=$(uptime 2>/dev/null ) 
    echo ""
    echo "\e[1;33mWelcome $USER.\e[0m"
    echo "time: $uptime"
    echo "$HOST: $PWD" 
    echo "zsh version $ZSH_VERSION"
    
    # say good bye on exit
    function _exit() {
        echo "\e[1;33mHasta la vista, baby!\e[0m"
    }
    trap _exit 0
fi