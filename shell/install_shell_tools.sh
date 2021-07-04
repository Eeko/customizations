#install_shell_tools.sh


if [[ $(uname) == "Linux" ]]
then
  echo "Linux Detected"
  if [[ $(which apt) != "" ]]
  then
    echo "APT Package manager in use. This makes it easy..."
    UBUNTUPACKAGES=(man wget curl zsh build-essential git libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev make)
    if [[ $(whoami) != "root" ]]
    then
      sudo apt update
      sudo apt install -y $UBUNTUPACKAGES
    else
      apt update
      apt install -y $UBUNTUPACKAGES
    fi
  else
    echo "APT not detected. No other Package Managers are yet supported."
  fi
elif [[ $(uname) == "Darwin" ]]
then
  echo "Mac (Darwin) Detected. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install gpg
else
  echo "Where am I? You might need to install dependencies manually :("
fi


echo "set shell to zsh"
chsh -s $(which zsh)

#instructions from https://ohmyz.sh/#install
echo "install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "set theme to \"candy\" in oh-my-zsh"
echo "ZSH_THEME=\"candy\"" >> $HOME/.zshrc
echo "install asdf plugin for oh-my-zsh"
sed -i 's/plugins=(/plugins=(asdf /g' $HOME/.zshrc

echo "install asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd $HOME/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
cd
echo ". $HOME/.asdf/asdf.sh" >> $HOME/.zshrc


echo "add aliases"
echo "alias weather=\"curl wttr.in/dublin\"" >> $HOME/.zshrc
echo "alias lakka=\"ssh -t eeko@lakka.kapsi.fi 'screen -dr'\"" >> $HOME/.zshrc
echo "export PATH=$PATH:$HOME/bin" >> $HOME/.zshrc
mkdir $HOME/bin

echo "sourcing .zshrc"
source $HOME/.zshrc
echo "add asdf plugins python, golang and ruby"
asdf plugin add ruby
asdf plugin add python
asdf plugin add golang
asdf plugin add nodejs
echo "asdf install latest versions of python, golang and ruby"
asdf install ruby latest
asdf install python latest
asdf install golang latest
asdf install nodejs latest
echo "setting the freshly installed latests as the current version"
asdf global ruby $(asdf list ruby)
asdf global python $(asdf list python)
asdf global golang $(asdf list golang)
asdf global nodejs $(asdf list nodejs)

echo "installing cool tools"
npm install -g tldr

echo "reshim needed to add aliases to cool tools"
asdf reshim nodejs
asdf reshim ruby
asdf reshim python
asdf reshim golang
