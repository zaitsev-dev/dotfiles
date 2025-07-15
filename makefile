# Makefile for dotfiles deployment using GNU Stow

STOW = stow
DOTFILES = zsh git

.PHONY: all init clean help

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

# Помощь
help:
	@echo "📘 Makefile commands:"
	@echo "  make         — run init as default"
	@echo "  make init    — create symlinks for dotfiles at new machine (using Stow)"
	@echo "  make clean   — delete all symlinks (de-stow)"
	@echo "  make help    — show this message"

