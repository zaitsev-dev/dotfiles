STOW = stow
DOTFILES = zsh vim
MACOS_DEPS = stow fzf zsh neovim ranger bat httpie

.PHONY: all init clean help install-macos-deps init-local

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
	@echo "Deps: $(MACOS_DEPS)";
	@read -p "Proceed and install? [y/N] " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		echo "🚀 Installing MacOS dependencies and some soft ;)"; \
		brew install $(MACOS_DEPS); \
	else \
		echo "Nothing to do: operation was canceled by user"; \
	fi
	@echo "✅ Done!";

# Помощь
help:
	@echo "📘 Makefile commands:"
	@echo "  make               — equivalent to init and init-local at the same run"
	@echo "  make init          — create symlinks for dotfiles at new machine (using Stow)"
	@echo "  make init-local    — create .zshrc.local for secrets and envs"
	@echo "  make install-macos - install dependencies and soft via Homebrew"
	@echo "  make clean         — delete all symlinks (de-stow)"
	@echo "  make help          — show this message"
