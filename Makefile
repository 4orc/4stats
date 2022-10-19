-include ../etc/Makefile

README.md: ../4readme/readme.lua 4stats.lua ## update readme
	lua  $^ 4stats.lua  >> $@	
