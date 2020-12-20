#install_shell_tools.sh

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

echo "add aliases"
echo "alias weather=\"curl wttr.in/dublin\"" >> $HOME/.zshrc
echo "alias lakka=\"ssh eeko@lakka.kapsi.fi" >> $HOME/.zshrc
echo "export PATH=$PATH:$HOME/bin" >> $HOME/.zshrc
mkdir $HOME/bin

echo "sourcing .zshrc"
source $HOME/.zshrc
echo "add asdf plugins python, golang and ruby"
asdf plugin add ruby
asdf plugin add python
asdf plugin add golang
echo "asdf install latest versions of python, golang and ruby"
asdf install ruby latest
asdf install python latest
asdf install golang latest

