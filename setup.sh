rm ~/.bashrc
if [$? -eq 0]; then
    ln -s ./shells/bash/.bashrc ~/.bashrc
fi

rm ~/.zshrc
if [$? -eq 0]; then
    ln -s ./shells/zsh/.zshrc ~/.zshrc
fi

rm ~/.vimrc
if [$? -eq 0]; then
    ln -s ./vim/.vimrc ~/.vimrc
fi

rm -rf ~/.vim
if [$? -eq 0]; then
    ln -s ./vim/.vim ~/.vim
fi

rm -rf ~/.config/i3
if [$? -eq 0]; then
    ln -s ./i3 ~/.config/i3
fi

