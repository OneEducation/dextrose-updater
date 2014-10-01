NAME     = dextrose-updater
VERSION  = 5
DISTNAME = $(NAME)-$(VERSION)

REPO     = dextrose dextrose-freeworld
CONFDIR  = /etc/sysconfig
BINDIR   = /usr/sbin
CRONDIR  = /etc/cron.hourly

all:
	@echo Build is not need, use dist or install targets

dist:
	rm -rf $(DISTNAME) $(DISTNAME).tar.gz
	mkdir $(DISTNAME)
	cp -a Makefile AUTHORS COPYING dextrose-updater dextrose-updater.conf HACKING INSTALL NEWS README $(DISTNAME)/
	tar czpvf $(DISTNAME).tar.gz $(DISTNAME)
	rm -rf $(DISTNAME)

install:
	install -D -m 0644 dextrose-updater.conf $(DESTDIR)/$(CONFDIR)/$(NAME)
	sed -i 's/@REPO@/$(REPO)/g' $(DESTDIR)/$(CONFDIR)/$(NAME)
	install -D -m 0755 dextrose-updater $(DESTDIR)/$(BINDIR)/$(NAME)
	sed -i 's/@NAME@/$(NAME)/g; s/@VERSION@/$(VERSION)/g; s/@CONFDIR@/$(subst /,\/,$(CONFDIR))/g' $(DESTDIR)/$(BINDIR)/$(NAME)
	install -d -m 0755 $(DESTDIR)/$(CRONDIR)
	ln -s $(BINDIR)/$(NAME) $(DESTDIR)/$(CRONDIR)