S_goals := $(if $(MAKECMDGOALS),$(MAKECMDGOALS),build)
.PHONY: $(S_goals)
$(S_goals):
	$(MAKE) -C program/gui $(S_goals)
