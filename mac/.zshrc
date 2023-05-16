# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Toggles the 'Last Login prompt'
printf '\33c\e[3J'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# custom commands

# (does not happen on mac) rustc needs to be added to PATH here for rust binaries to work on startup
# export PATH="$HOME/.cargo/bin:$PATH"

zeitfetch
WORK=$HOME'/localdev/fetchly'
JOBSP=$HOME'/localdev/fetchly/jobspeaker'

# echo some reminders
echo "sudo is 2jh + 4"
echo "Current defined variables:"
echo "\$WORK, \$JOBSP"
echo "Current helper functions:"
echo "cherome (unsafe_chrome), ockam_rebase, ockam_test, sweep"

# aliases
alias ls="lsd"
alias cat="bat -P"
alias grep="rg"
alias finder="open"
alias git_diff="git diff -- . ':(exclude)package-lock.json'"

# starship configuration
eval "$(starship init zsh)"

# setup for nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# toggle zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source /Users/nidnogg/.docker/init-zsh.sh || true # Added by Docker Desktop

# Used for autocompletion in Kubernetes
source <(kubectl completion zsh)

# $GOPATH/bin for any `go install` projects
export PATH=$PATH:$(go env GOPATH)/bin

# For rbenv
eval "$(rbenv init - zsh)"

# this function queries wikipedia for a keyword via DNS. base command courtesy of commandlinefu
function wikit() {
  local keyword=$1
  echo "dig +short txt \"$keyword\".wp.dg.cx"
  dig +short txt \"$keyword\".wp.dg.cx
}

# unsafe chrome
function cherome() {
  echo "Booting Google Chrome with `--disable-web-security` flag..."
  $(open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security)
}

# For gh release in jobspeaker format
function create_release() {
  local tag=$1
  local cur_branch=$(git rev-parse --abbrev-ref HEAD)
  echo "Creating release for tag $tag"
  echo "Latest release info:"
  gh release list | grep "Latest"
  read "response?Are you sure? [Y/n] "
  # response=${response:l} # :l is tolower
  response=${response}
  if [[ $response =~ ^(y| ) ]] || [[ -z $response ]]; then
      gh release create $tag --title "$tag" --target $cur_branch
  else
      echo "Aborting"
  fi

  # TO-DO Maybe work on this later
  # echo "If you want to edit your release number, enter it now: "
  # read "override_tag?"
  # if $override_tag then
  #   $tag=${override_tag}
  # fi
}

# Requires cargo-sweep crate to be installed
function sweep() {
  local timeout=30
  cargo sweep -r -t $timeout $HOME/localdev
  echo "...Finished cargo sweep"
}

# ockam development
export PATH="$HOME/localdev/ockam/target/debug:$PATH"

# Usage:
# `ockam_test unit`
# `ockam_test`
function ockam_test() {
  local ockam_dir="$HOME/localdev/ockam"
  local bats_test="$ockam_dir/implementations/rust/ockam/ockam_command/tests/bats/unit.bats"
  local test_name=$1

  # if [$test_name]; then
  #   echo "Running main ockam test suite"
  #   bats "$bats_test"
  # else
    # echo "Selected $test_name test"
    # echo "Running $test_names.bats"
    # local selected_bats_test="$bats_test"
    # bats "$selected_bats_test"
  # fi
  bats "$bats_test"
}

function ockam_rebase() {
  local ockam_dev_dir="$HOME/localdev/ockam"
  if [ "$(pwd)" = $ockam_dev_dir ]; then
    echo "Starting ockam develop rebase. Don't forget to git push origin -f <cur_branch> once the rebase is complete."
    local cur_branch=$(git rev-parse --abbrev-ref HEAD)
    git checkout develop \
    && git fetch upstream develop \
    && git pull upstream develop \
    && git checkout $cur_branch \
    && git rebase -i develop
  else
    echo "Check that your current directory matches your local ockam development directory at $ockam_dev_dir"
  fi
}

eval "$(atuin init zsh --disable-up-arrow)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nidnogg/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nidnogg/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nidnogg/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nidnogg/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
