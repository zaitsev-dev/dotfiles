STOW = stow
DOTFILES = zsh vim git
BREWFILE ?= Brewfile

.PHONY: all init clean help install-macos init-local

all: init init-local

init:
	@echo "🚀 Copying dotfiles..."
	@for dir in $(DOTFILES); do \
		echo "🔗 copying $$dir..."; \
		$(STOW) $$dir; \
	done
	@echo "✅ Done!"

init-local:
	@ZSHRC_LOCAL_PATH="$${HOME}/.zshrc.local"; \
	if [ -f "$$ZSHRC_LOCAL_PATH" ]; then \
		echo "✅ File .zshrc.local already exists: $$ZSHRC_LOCAL_PATH"; \
	else \
		echo "📝 Creating the .zshrc.local at path: $$ZSHRC_LOCAL_PATH"; \
		cp .zshrc.local.example ~/.zshrc.local; \
		echo "✅ .zshrc.local was created!"; \
	fi

clean:
	@echo "🧹 Delete symlinks..."
	@for dir in $(DOTFILES); do \
		echo "⛔ deleting $$dir..."; \
		$(STOW) -D $$dir; \
	done
	@echo "🗑️  Cleaned up!"

install-macos:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "❗ Homebrew is not installed."; \
		read -p "Install Homebrew now? [y/N] " install_brew; \
		if [ "$$install_brew" = "y" ] || [ "$$install_brew" = "Y" ]; then \
			echo "🔧 Installing Homebrew..."; \
			/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
			echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> $$HOME/.zprofile; \
			eval "$$(/opt/homebrew/bin/brew shellenv)"; \
		else \
			echo "⛔ Aborting: Homebrew is required."; \
			exit 1; \
		fi; \
	fi; \
	echo ""; \
	echo "📦 Packages to be installed from $(BREWFILE):"; \
	cat $(BREWFILE); \
	echo ""; \
	read -p "Proceed and install these packages? [y/N] " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		echo "🚀 Installing MacOS dependencies and some soft ;)"; \
		brew bundle --file=$(BREWFILE); \
		echo "✅ Done!"; \
	else \
		echo "Nothing to do: operation was canceled by user."; \
	fi

help:
	@echo "📘 Makefile commands:"
	@echo "  make               — equivalent to init and init-local at the same run"
	@echo "  make init          — create symlinks for dotfiles at new machine (using Stow)"
	@echo "  make init-local    — create .zshrc.local for secrets and envs"
	@echo "  make install-macos - install dependencies and soft via Homebrew"
	@echo "  make clean         — delete all symlinks (de-stow)"
	@echo "  make help          — show this message"
