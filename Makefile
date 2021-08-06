S_goals := $(if $(MAKECMDGOALS),$(patsubst uninstall,uninstall-0,$(MAKECMDGOALS)),build)
.PHONY: $(S_goals) uninstall
$(S_goals) uninstall:
	$(MAKE) -C program/gui $(S_goals)
