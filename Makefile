# Makefile for mkinitcpio-randommac

VERSION=0.2.0

all:
	@echo "Just run make install..."

.PHONY: install
install:
	install -D -m0644 hook/randommac $(DESTDIR)/usr/lib/initcpio/hooks/randommac
	install -D -m0644 install/randommac $(DESTDIR)/usr/lib/initcpio/install/randommac

release:
	git archive --format=tar.xz --prefix=mkinitcpio-randommac-$(VERSION)/ $(VERSION) > mkinitcpio-randommac-$(VERSION).tar.xz
	gpg -ab mkinitcpio-randommac-$(VERSION).tar.xz
	git notes --ref=refs/notes/signatures/tar add -C $$(git archive --format=tar --prefix=mkinitcpio-randommac-$(VERSION)/ $(VERSION) | gpg --armor --detach-sign | git hash-object -w --stdin) $(VERSION)
