ViridianGym_Script:
	ld hl, Gym8CityName
	ld de, Gym8LeaderName
	call LoadGymLeaderAndCityName
	call EnableAutoTextBoxDrawing
	ld hl, ViridianGymTrainerHeader0
	ld de, ViridianGym_ScriptPointers
	ld a, [wViridianGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wViridianGymCurScript], a
	ret

Gym8CityName:
	db "VIRIDIAN CITY@"
Gym8LeaderName:
	db "GIOVANNI@"

ViridianGymScript_748d6:
	xor a
	ld [wJoyIgnore], a
	ld [wViridianGymCurScript], a
	ld [wCurMapScript], a
	ret

ViridianGym_ScriptPointers:
	dw ViridianGymScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw ViridianGymScript3
	dw ViridianGymScript4

ViridianGymScript0:
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld hl, ViridianGymArrowTilePlayerMovement
	call DecodeArrowMovementRLE
	cp $ff
	jp z, CheckFightingMapTrainers
	call StartSimulatingJoypadStates
	ld hl, wd736
	set 7, [hl]
	ld a, SFX_ARROW_TILES
	call PlaySound
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $4
	ld [wCurMapScript], a
	ret

;format:
;db y,x
;dw pointer to movement
ViridianGymArrowTilePlayerMovement:
	db $b,$13
	dw ViridianGymArrowMovement1
	db $1,$13
	dw ViridianGymArrowMovement2
	db $2,$12
	dw ViridianGymArrowMovement3
	db $2,$b
	dw ViridianGymArrowMovement4
	db $a,$10
	dw ViridianGymArrowMovement5
	db $6,$4
	dw ViridianGymArrowMovement6
	db $d,$5
	dw ViridianGymArrowMovement7
	db $e,$4
	dw ViridianGymArrowMovement8
	db $f,$0
	dw ViridianGymArrowMovement9
	db $f,$1
	dw ViridianGymArrowMovement10
	db $10,$d
	dw ViridianGymArrowMovement11
	db $11,$d
	dw ViridianGymArrowMovement12
	db $FF

;format: direction, count
ViridianGymArrowMovement1:
	db D_UP,$09,$FF

ViridianGymArrowMovement2:
	db D_LEFT,$08,$FF

ViridianGymArrowMovement3:
	db D_DOWN,$09,$FF

ViridianGymArrowMovement4:
	db D_RIGHT,$06,$FF

ViridianGymArrowMovement5:
	db D_DOWN,$02,$FF

ViridianGymArrowMovement6:
	db D_DOWN,$07,$FF

ViridianGymArrowMovement7:
	db D_RIGHT,$08,$FF

ViridianGymArrowMovement8:
	db D_RIGHT,$09,$FF

ViridianGymArrowMovement9:
	db D_UP,$08,$FF

ViridianGymArrowMovement10:
	db D_UP,$06,$FF

ViridianGymArrowMovement11:
	db D_LEFT,$06,$FF

ViridianGymArrowMovement12:
	db D_LEFT,$0C,$FF

ViridianGymScript4:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	jr nz, .asm_74980
	xor a
	ld [wJoyIgnore], a
	ld hl, wd736
	res 7, [hl]
	ld a, $0
	ld [wCurMapScript], a
	ret
.asm_74980
	farjp LoadSpinnerArrowTiles

ViridianGymScript3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ViridianGymScript_748d6
	ld a, $f0
	ld [wJoyIgnore], a
ViridianGymScript3_74995:
	ld a, $c
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	lb bc, TM_FISSURE, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $d
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM27
	jr .gymVictory
.BagFull
	ld a, $e
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_EARTHBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_EARTHBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_VIRIDIAN_GYM_TRAINER_0, EVENT_BEAT_VIRIDIAN_GYM_TRAINER_7

	ld a, HS_ROUTE_22_RIVAL_2
	ld [wMissableObjectIndex], a
	predef ShowObject
	SetEvents EVENT_2ND_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	jp ViridianGymScript_748d6

ViridianGym_TextPointers:
	dw ViridianGymText1
	dw ViridianGymText2
	dw ViridianGymText3
	dw ViridianGymText4
	dw ViridianGymText5
	dw ViridianGymText6
	dw ViridianGymText7
	dw ViridianGymText8
	dw ViridianGymText9
	dw ViridianGymText10
	dw PickUpItemText
	dw ViridianGymText12
	dw ViridianGymText13
	dw ViridianGymText14

ViridianGymTrainerHeader0:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_0, 4, ViridianGymBattleText1, ViridianGymEndBattleText1, ViridianGymAfterBattleText1
ViridianGymTrainerHeader1:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_1, 4, ViridianGymBattleText2, ViridianGymEndBattleText2, ViridianGymAfterBattleText2
ViridianGymTrainerHeader2:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_2, 4, ViridianGymBattleText3, ViridianGymEndBattleText3, ViridianGymAfterBattleText3
ViridianGymTrainerHeader3:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_3, 2, ViridianGymBattleText4, ViridianGymEndBattleText4, ViridianGymAfterBattleText4
ViridianGymTrainerHeader4:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_4, 3, ViridianGymBattleText5, ViridianGymEndBattleText5, ViridianGymAfterBattleText5
ViridianGymTrainerHeader5:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_5, 4, ViridianGymBattleText6, ViridianGymEndBattleText6, ViridianGymAfterBattleText6
ViridianGymTrainerHeader6:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_6, 1, 3, ViridianGymBattleText7, ViridianGymEndBattleText7, ViridianGymAfterBattleText7
ViridianGymTrainerHeader7:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_7, 1, 4, ViridianGymBattleText8, ViridianGymEndBattleText8, ViridianGymAfterBattleText8
	db -1 ; end

ViridianGymText1:
	text_asm
	CheckEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	jr z, .beginBattle
	CheckEventReuseA EVENT_GOT_TM27
	jr nz, .afterVictory
	call z, ViridianGymScript3_74995
	call DisableWaitingAfterTextDisplay
	jr .done
.afterVictory
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, ViridianGymText_74ad9
	call PrintText
	call GBFadeOutToBlack
	ld a, HS_VIRIDIAN_GYM_GIOVANNI
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jr .done
.beginBattle
	ld hl, ViridianGymText_74ace
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ViridianGymText_74ad3
	ld de, ViridianGymText_74ad3
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $8
	ld [wGymLeaderNo], a
	ld a, $3
	ld [wViridianGymCurScript], a
.done
	jp TextScriptEnd

ViridianGymText_74ace:
	text_far _ViridianGymText_74ace
	text_end

ViridianGymText_74ad3:
	text_far _ViridianGymText_74ad3
	sound_level_up ; probably supposed to play SFX_GET_ITEM_1 but the wrong music bank is loaded
	text_end

ViridianGymText_74ad9:
	text_far _ViridianGymText_74ad9
	text_waitbutton
	text_end

ViridianGymText12:
	text_far _ViridianGymText12
	text_end

ViridianGymText13:
	text_far _ReceivedTM27Text
	sound_get_item_1

TM27ExplanationText:
	text_far _TM27ExplanationText
	text_end

ViridianGymText14:
	text_far _TM27NoRoomText
	text_end

ViridianGymText2:
	text_asm
	ld hl, ViridianGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText1:
	text_far _ViridianGymBattleText1
	text_end

ViridianGymEndBattleText1:
	text_far _ViridianGymEndBattleText1
	text_end

ViridianGymAfterBattleText1:
	text_far _ViridianGymAfterBattleText1
	text_end

ViridianGymText3:
	text_asm
	ld hl, ViridianGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText2:
	text_far _ViridianGymBattleText2
	text_end

ViridianGymEndBattleText2:
	text_far _ViridianGymEndBattleText2
	text_end

ViridianGymAfterBattleText2:
	text_far _ViridianGymAfterBattleText2
	text_end

ViridianGymText4:
	text_asm
	ld hl, ViridianGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText3:
	text_far _ViridianGymBattleText3
	text_end

ViridianGymEndBattleText3:
	text_far _ViridianGymEndBattleText3
	text_end

ViridianGymAfterBattleText3:
	text_far _ViridianGymAfterBattleText3
	text_end

ViridianGymText5:
	text_asm
	ld hl, ViridianGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText4:
	text_far _ViridianGymBattleText4
	text_end

ViridianGymEndBattleText4:
	text_far _ViridianGymEndBattleText4
	text_end

ViridianGymAfterBattleText4:
	text_far _ViridianGymAfterBattleText4
	text_end

ViridianGymText6:
	text_asm
	ld hl, ViridianGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText5:
	text_far _ViridianGymBattleText5
	text_end

ViridianGymEndBattleText5:
	text_far _ViridianGymEndBattleText5
	text_end

ViridianGymAfterBattleText5:
	text_far _ViridianGymAfterBattleText5
	text_end

ViridianGymText7:
	text_asm
	ld hl, ViridianGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText6:
	text_far _ViridianGymBattleText6
	text_end

ViridianGymEndBattleText6:
	text_far _ViridianGymEndBattleText6
	text_end

ViridianGymAfterBattleText6:
	text_far _ViridianGymAfterBattleText6
	text_end

ViridianGymText8:
	text_asm
	ld hl, ViridianGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText7:
	text_far _ViridianGymBattleText7
	text_end

ViridianGymEndBattleText7:
	text_far _ViridianGymEndBattleText7
	text_end

ViridianGymAfterBattleText7:
	text_far _ViridianGymAfterBattleText7
	text_end

ViridianGymText9:
	text_asm
	ld hl, ViridianGymTrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText8:
	text_far _ViridianGymBattleText8
	text_end

ViridianGymEndBattleText8:
	text_far _ViridianGymEndBattleText8
	text_end

ViridianGymAfterBattleText8:
	text_far _ViridianGymAfterBattleText8
	text_end

ViridianGymText10:
	text_asm
	CheckEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	jr nz, .asm_1abd1
	ld hl, ViridianGymText_74bd4
	call PrintText
	jr .asm_6064d
.asm_1abd1
	ld hl, ViridianGymText_74bd9
	call PrintText
.asm_6064d
	jp TextScriptEnd

ViridianGymText_74bd4:
	text_far _ViridianGymText_74bd4
	text_end

ViridianGymText_74bd9:
	text_far _ViridianGymText_74bd9
	text_end