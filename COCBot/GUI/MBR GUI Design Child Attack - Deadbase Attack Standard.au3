; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Standard Attack" tab under the "Attack" tab under the "DeadBase" tab under the "Search & Attack" tab under the "Attack Plan" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_DEADBASE_ATTACK_STANDARD = 0
Global $g_hCmbStandardDropOrderDB = 0, $g_hCmbStandardDropSidesDB = 0, $g_hCmbStandardUnitDelayDB = 0, $g_hCmbStandardWaveDelayDB = 0, $g_hChkRandomSpeedAtkDB = 0, _
	   $g_hChkSmartAttackRedAreaDB = 0, $g_hCmbSmartDeployDB = 0, $g_hChkAttackNearGoldMineDB = 0, $g_hChkAttackNearElixirCollectorDB = 0, $g_hChkAttackNearDarkElixirDrillDB = 0

Global $g_hLblSmartDeployDB = 0, $g_hPicAttackNearDarkElixirDrillDB = 0, $g_BtnCustomDropOrderDB = 0

; Unit/Wave Factor
Global $g_hGrpSettings = 0
Global $ChkGiantSlot = 0, $CmbGiantSlot = 0

Global $ChkUnitFactor = 0, $TxtUnitFactor = 0
Global $ChkWaveFactor = 0, $TxtWaveFactor = 0

Func CreateAttackSearchDeadBaseStandard()

   $g_hGUI_DEADBASE_ATTACK_STANDARD = _GUICreate("", $_GUI_MAIN_WIDTH - 195, $g_iSizeHGrpTab4, 150, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_DEADBASE)
   ;GUISetBkColor($COLOR_WHITE, $g_hGUI_DEADBASE_ATTACK_STANDARD)

   Local $sTxtTip
   Local $x = 25, $y = 20
	   GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Group_01", "Deploy"), $x - 20, $y - 20, 270, $g_iSizeHGrpTab4)
   ;	$x -= 15
		   GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Label_01", "Troop Drop Order"),$x, $y, 143,18,$SS_LEFT)

		   $y += 15
		   $g_hCmbStandardDropOrderDB = GUICtrlCreateCombo("", $x, $y, 150, Default, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   GUICtrlSetData(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropOrder_Item_01", "Default(All Troops)")&"|Barch/BAM/BAG|GiBarch", GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropOrder_Item_01",  -1))
			   _GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropOrder_Info_01", "Select a preset troop drop order.") & @CRLF & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropOrder_Info_02", "Each option deploys troops in a different order and in different waves") & @CRLF & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropOrder_Info_03", "Only the troops selected in the ""Only drop these troops"" option will be dropped"))

		   $y += 25
		   GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Label_02", "Attack on")&":", $x, $y + 5, -1, -1)
		   $g_hCmbStandardDropSidesDB = GUICtrlCreateCombo("", $x + 55, $y, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   _GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Info_01", "Attack on a single side, penetrates through base") & @CRLF & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Info_02", "Attack on two sides, penetrates through base") & @CRLF & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Info_03", "Attack on three sides, gets outer and some inside of base") & @CRLF & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Info_07", "Attack on Classic Four Fingers") & @CRLF & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Info_04", "Select the No. of sides to attack on."))
			   GUICtrlSetData(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Item_01", "one side") & "|" & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Item_02", "two sides") & "|" & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Item_03", "three sides") & "|" & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Item_04", "all sides equally") & "|" & _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Item_07", "Classic Four Fingers"), _
								  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbStandardDropSides_Item_04", -1))
			   GUICtrlSetOnEvent(-1, "Bridge") ; Uncheck SmartAttack Red Area when enable FourFinger to avoid conflict

		   $y += 25
		   GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Lbl-CmbStandardUnitDelay", "Delay Unit") & ":", $x, $y + 5, -1, -1)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Lbl-CmbStandardUnitDelay_Info_01", "This delays the deployment of troops, 1 (fast) = like a Bot, 10 (slow) = Like a Human.") & @CRLF & _
						  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Lbl-CmbStandardUnitDelay_Info_02", "Random will make bot more varied and closer to a person.")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hCmbStandardUnitDelayDB = GUICtrlCreateCombo("", $x + 55, $y, 36, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "4")
		   GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Lbl-CmbStandardWaveDelay_Info_01", "Wave") & ":", $x + 100, $y + 5, -1, -1)
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hCmbStandardWaveDelayDB = GUICtrlCreateCombo("", $x + 140, $y, 36, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "4")

		  $y += 22
		   $g_hChkRandomSpeedAtkDB = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkRandomSpeedAtk", "Randomize delay for Units && Waves"), $x, $y, -1, -1)
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetOnEvent(-1, "chkRandomSpeedAtkDB")

		   $y +=22
		   $g_hChkSmartAttackRedAreaDB = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkSmartAttackRedArea", "Use Smart Attack: Near Red Line."), $x, $y, -1, -1)
			   _GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkSmartAttackRedArea_Info_01", "Use Smart Attack to detect the outer 'Red Line' of the village to attack. And drop your troops close to it."))
			   GUICtrlSetState(-1, $GUI_CHECKED)
			   GUICtrlSetOnEvent(-1, "chkSmartAttackRedAreaDB")

		   $y += 22
		   $g_hLblSmartDeployDB = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "LblSmartDeploy", "Drop Type") & ":", $x, $y + 5, -1, -1)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "LblSmartDeploy_Info_01", "Select the Deploy Mode for the waves of Troops.") & @CRLF & GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "LblSmartDeploy_Info_02", "Type 1: Drop a single wave of troops on each side then switch troops, OR") & @CRLF & GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "LblSmartDeploy_Info_03", "Type 2: Drop a full wave of all troops (e.g. giants, barbs and archers) on each side then switch sides.")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hCmbSmartDeployDB = GUICtrlCreateCombo("", $x + 55, $y, 120, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   GUICtrlSetData(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbSmartDeploy_Info_01", "Sides, then Troops") & "|" & GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbSmartDeploy_Info_02", "Troops, then Sides") , GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbSmartDeploy_Info_01", -1))
			   _GUICtrlSetTip(-1, $sTxtTip)

		   $y += 26
		   $g_hChkAttackNearGoldMineDB = GUICtrlCreateCheckbox("", $x + 20, $y, 17, 17)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkAttackNearGoldMine_Info_01", "Drop troops near Gold Mines")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   _GUICtrlCreateIcon($g_sLibIconPath, $eIcnMine, $x + 40 , $y - 3 , 24, 24)
			   _GUICtrlSetTip(-1, $sTxtTip)

		   $x += 75
		   $g_hChkAttackNearElixirCollectorDB = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkAttackNearElixirCollector_Info_01", "Drop troops near Elixir Collectors")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   _GUICtrlCreateIcon($g_sLibIconPath, $eIcnCollector, $x + 20 , $y - 3 , 24, 24)
			   _GUICtrlSetTip(-1, $sTxtTip)

		   $x += 55
		   $g_hChkAttackNearDarkElixirDrillDB = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkAttackNearDarkElixirDrill_Info_01", "Drop troops near Dark Elixir Drills")
			   _GUICtrlSetTip(-1, $sTxtTip)
		   $g_hPicAttackNearDarkElixirDrillDB = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDrill, $x + 20 , $y - 3, 24, 24)
			   _GUICtrlSetTip(-1, $sTxtTip)
	   GUICtrlCreateGroup("", -99, -99, 1, 1)

		   ; Unit/Wave Factor
		   $x = 23
		   $y = 110
		   $g_hGrpSettings = GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "Group_02", "Settings"), $x, $y, 180, 105)

		   $y += 5
		   $ChkGiantSlot = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkGiantSlot", "GiantSlot"), $x+10, $y + 10, 89, 25)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkGiantSlot_Info_01", "perimeter (> = 12, recommended)") & @CRLF & _
						  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkGiantSlot_Info_02", "two points on each side (> = 8, recommended)")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetOnEvent(-1, "ChkGiantSlot")
			   GUICtrlSetState(-1, $GUI_UNCHECKED)
		   $CmbGiantSlot = GUICtrlCreateCombo("", $x + 99, $y + 12, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			   GUICtrlSetData(-1,  GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbGiantSlot_Info_01", "Perimeter") & "|" & _
								   GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbGiantSlot_Info_02", "TwoPoints"), GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "CmbGiantSlot_Info_01", -1))
			   GUICtrlSetOnEvent(-1, "CmbGiantSlot")

		   $y += 34
		   $ChkUnitFactor = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkUnitFactor", "Modify Unit Factor"), $x + 10, $y + 4, 130, 25)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkUnitFactor_Info_01", "Unit deploy delay = Unit setting x Unit Factor (millisecond)")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetOnEvent(-1, "chkUnitFactor")
			   GUICtrlSetState(-1, $GUI_UNCHECKED)

		   $TxtUnitFactor = GUICtrlCreateInput("10", $x + 140, $y + 6, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkUnitFactor_Info_02", "Unit deploy delay = Unit setting x Unit Factor (millisecond)")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetState(-1, $GUI_DISABLE)
			   GUICtrlSetData(-1, 10)
			   GUICtrlSetOnEvent(-1, "chkUnitFactor")
		   $y += 30
		   $ChkWaveFactor = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkWaveFactor", "Modify Wave Factor"), $x + 10, $y + 2, 130, 25)
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkWaveFactor_Info_01", "Switch troop delay = Wave setting x Wave Factor (millisecond)")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetOnEvent(-1, "chkWaveFactor")
			   GUICtrlSetState(-1, $GUI_UNCHECKED)

		   $TxtWaveFactor = GUICtrlCreateInput("100", $x + 140, $y + 4, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			   $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "ChkWaveFactor_Info_02", "Switch troop delay = Wave setting x Wave Factor (millisecond)")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetState(-1, $GUI_DISABLE)
			   GUICtrlSetData(-1, 100)
			   GUICtrlSetOnEvent(-1, "chkWaveFactor")

		   For $i = $g_hGrpSettings To $TxtWaveFactor
			   GUICtrlSetState($i, $GUI_HIDE)
		   Next

		   $y += 40
		   $x = 98
		   $g_BtnCustomDropOrderDB = GUICtrlCreateButton(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "BtnCustomDropOrder", "Drop Order"), $x, $y, 85, 25)
			   _GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack Standard", "BtnCustomDropOrder_Info_01", "Select Custom Troops Dropping Order"))
			   GUICtrlSetOnEvent(-1, "CustomDropOrder")
	   GUICtrlCreateGroup("", -99, -99, 1, 1)

   ;GUISetState()
EndFunc
