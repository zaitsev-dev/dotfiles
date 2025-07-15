# Makefile for dotfiles deployment using GNU Stow

STOW = stow
DOTFILES = zsh git

.PHONY: all init clean help

all: init

init:
	@echo "🚀 Copying dotfiles..."
	@for dir in $(DOTFILES); do \
		echo "🔗 copying $$dir..."; \
		$(STOW) $$dir; \
	done
	@echo "✅ Done!"

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

