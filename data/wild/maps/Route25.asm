Route25WildMons:
	def_grass_wildmons 15 ; encounter rate
IF DEF(_RED)
	db  9, WEEDLE
	db 10, KAKUNA
	db 15, PIDGEY
	db 13, ODDISH
	db 15, ODDISH
	db 13, ABRA
	db 16, ODDISH
	db 11, ABRA
	db  8, METAPOD
	db  9, CATERPIE
ENDC
IF DEF(_BLUE)
	db  8, CATERPIE
	db  9, METAPOD
	db 13, PIDGEY
	db 12, BELLSPROUT
	db 13, BELLSPROUT
	db 12, ABRA
	db 14, BELLSPROUT
	db 10, ABRA
	db  7, KAKUNA
	db  8, WEEDLE
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
