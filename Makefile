TARGETDIR?=/
STARTUPSYS?=sysVinit

all:
	@echo "Makefile usage"
	@echo ""
	@echo " Configuration is done using environment variable"
	@echo ""
	@echo " TARGETDIR defines where to install RPi-Monitor"
	@echo " STARTUPSYS defines the startup system to install. Possible values are:"
	@echo "  - sysVinit"
	@echo "  - upstart"
	@echo "  - systemd"
	@echo ""
	@echo " The current values are:"
	@echo "  TARGETDIR=${TARGETDIR}"
	@echo "  STARTUPSYS=${STARTUPSYS}"
	@echo ""
	@echo " Once environment variable are set, execute: make install"
	@echo ""

install:
	@echo "Installing RPi-Monitor in ${TARGETDIR}"
	@mkdir -p ${TARGETDIR}var/lib/rpimonitor
	@cp -r src/var/lib/rpimonitor/* ${TARGETDIR}var/lib/rpimonitor/
	@mkdir -p ${TARGETDIR}etc/rpimonitor
	@cp -r src/etc/rpimonitor/* ${TARGETDIR}etc/rpimonitor/
	@mkdir -p ${TARGETDIR}etc/sudoers.d
	@cp -r src/etc/sudoers.d/* ${TARGETDIR}etc/sudoers.d/
	@mkdir -p ${TARGETDIR}usr/bin
	@cp -r src/usr/bin/* ${TARGETDIR}usr/bin/
	@mkdir -p ${TARGETDIR}usr/share/rpimonitor
	@cp -r src/usr/share/rpimonitor/* ${TARGETDIR}usr/share/rpimonitor/
	@echo "Startup system is ${STARTUPSYS}"
ifeq (${STARTUPSYS},sysVinit)
	@mkdir -p ${TARGETDIR}etc/init.d
	@cp -r src/etc/init.d/* ${TARGETDIR}etc/init.d/
endif
ifeq (${STARTUPSYS},upstart)
	@mkdir -p ${TARGETDIR}etc/init
	@cp -r src/etc/init/* ${TARGETDIR}etc/init/
endif
ifeq (${STARTUPSYS},systemd)
	@mkdir -p ${TARGETDIR}usr/lib/systemd/system
	@cp -r src/usr/lib/systemd/system/* ${TARGETDIR}etc/systemd/system/
endif
	@echo "Installation completed"

clean:
	@echo
