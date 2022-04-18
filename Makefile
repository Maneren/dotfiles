test_desktop:
	docker build -t dotfiles -f Dockerfile .
	docker run -w /home/test_user/Downloads/dotfiles -v "$(shell pwd):/home/test_user/Downloads/dotfiles" dotfiles ./install.sh

test_arm64:
	docker build -t dotfiles_arm64 -f Dockerfile.arm64 .
	docker run -it \
		-w /home/test_user/Downloads/dotfiles \
		-v "$(shell pwd):/home/test_user/Downloads/dotfiles" \
		dotfiles_arm64 \
		# ./install.sh
		bash

test_net:
	docker build -t dotfiles Dockerfile .
	docker run -w /home/test_user dotfiles curl -fsSL rebrand.ly/maneren-install | sh -

test_all: test_desktop test_arm64 test_net