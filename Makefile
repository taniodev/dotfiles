
install:
	cp ./.bashrc ~
	cp ./.bash_aliases ~
	cp ./.gitconfig ~
	cp ./.gitignore_global ~

clean:
	rm -f ~/.bashrc
	rm -f ~/.bash_aliases
	rm -f ~/.gitconfig
	rm -f ~/.gitignore_global
