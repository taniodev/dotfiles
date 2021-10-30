
install:
	cp ./.bashrc ~
	cp ./.bash_aliases ~
	cp ./.gitignore_global ~

clean:
	rm -f ~/.bashrc
	rm -f ~/.bash_aliases
	rm -f ~/.gitignore_global
