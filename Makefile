INSTALL_PATH = ${HOME}/.local/bin/pass-menu
MAN_PATH = ${HOME}/.local/share/man/man1

ifndef VERBOSE
.SILENT:
endif

.ONESHELL:

# ---------------------- #
#        INSTALL         #
# ---------------------- #
help:
	echo "Usage: make [TARGETS]"
	echo
	echo "Targets:"
	echo "  install    install pass-menu on this system"
	echo "  uninstall  uninstall pass-menu from this system"
	echo
	echo "Example:"
	echo "  make install"

install:
	echo :: INSTALLING PASS-MENU
	$(call install, 0755, ./pass-menu,       $(INSTALL_PATH))
	$(call install, 0644, ./man/pass-menu.1, $(MAN_PATH)/pass-menu.1)
	echo :: DONE

uninstall:
	echo :: UNINSTALLING PASS-MENU
	$(call remove, $(INSTALL_PATH))
	$(call remove, $(MAN_PATH)/pass-menu.1)
	echo :: DONE


# ----------------------- #
#          UTILS          #
# ----------------------- #
define success
	echo -e "  \e[1;32m==>\e[0m"
endef

define failure
	echo -e "  \e[1;31m==>\e[0m"
endef

define install
	if install -D -m $(1) $(2) $(3) 2> /tmp/make-err; then
		$(success) $(2)
	else
		$(failure) $(2)
		sed "s:^:  :" /tmp/make-err
		rm /tmp/make-err
	fi
endef

define remove
	if rm $(1) 2> /tmp/make-err; then
		$(success) $(1)
	else
		$(failure) $(1)
		sed "s:^:  :" /tmp/make-err
		rm /tmp/make-err
	fi
endef
