#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\klikerra_logo.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>  ; Include GUI constants

HotKeySet("{esc}", "_exit")	; If "ESC" is pressed --> Closes app

; If "ESC" is pressed --> Saves data --> Exits
Func _exit()
	_saveData()
	Exit
EndFunc

; Colors
$green = "0x00FF00"
$yellow = "0xFFFF00"

#Region ; Load stored data from.ini file
$iniFile = @ScriptDir & "\save_data.ini"	; File to store data

$clicks = IniRead($iniFile, "Currencies", "clicks", 0)
$guesses = IniRead($iniFile, "Currencies", "guesses", 0)
$shifts = IniRead($iniFile, "Currencies", "shifts", 0)

$clicksPerClick = IniRead($iniFile, "ValuesPerAction", "clicksPerClick", 1)
$guessesPerGuess = IniRead($iniFile, "ValuesPerAction", "guessesPerGuess", 1)
$shiftsPerShift = IniRead($iniFile, "ValuesPerAction", "shiftsPerShift", 1)

$upperGuess = IniRead($iniFile, "GuessingLimits", "upperGuess", 1)
$lowerGuess = IniRead($iniFile, "GuessingLimits", "lowerGuess", 9)

$upgradeLevel_id1 = IniRead($iniFile, "UpgradeLevels", "upgradeLevel_id1", 1)
$upgradeLevel_id2 = IniRead($iniFile, "UpgradeLevels", "upgradeLevel_id2", 1)
$upgradeLevel_id3 = IniRead($iniFile, "UpgradeLevels", "upgradeLevel_id3", 1)

$Upgrade_id1_currentCost = IniRead($iniFile, "Upgrade_id1", "upgrade_id1_currentCost", 0)
$upgrade_id1_currentValue = IniRead($iniFile, "Upgrade_id1", "upgrade_id1_currentValue", 0)
$clicksPerClickNext = IniRead($iniFile, "Upgrade_id1", "clicksPerClickNext", 2)

$Upgrade_id2_currentCost = IniRead($iniFile, "Upgrade_id2", "upgrade_id2_currentCost", 0)
$upgrade_id2_currentValue = IniRead($iniFile, "Upgrade_id2", "upgrade_id2_currentValue", 0)
$guessesPerGuessNext = IniRead($iniFile, "Upgrade_id2", "guessesPerGuessNext", 2)

$Upgrade_id3_currentCost = IniRead($iniFile, "Upgrade_id3", "upgrade_id3_currentCost", 0)
$upgrade_id3_currentValue = IniRead($iniFile, "Upgrade_id3", "upgrade_id3_currentValue", 0)
$shiftsPerShiftNext = IniRead($iniFile, "Upgrade_id3", "shiftsPerShiftNext", 2)

$manualClicks = IniRead($iniFile, "Statistics", "manualClicks", 0)
$manualGuesses = IniRead($iniFile, "Statistics", "manualGuesses", 0)
$manualShifts = IniRead($iniFile, "Statistics", "manualShifts", 0)
#EndRegion

; Save stored data in .ini file
Func _saveData()
    IniWrite($iniFile, "Currencies", "clicks", $clicks)
	IniWrite($iniFile, "Currencies", "guesses", $guesses)
	IniWrite($iniFile, "Currencies", "shifts", $shifts)

    IniWrite($iniFile, "ValuesPerAction", "clicksPerClick", $clicksPerClick)
	IniWrite($iniFile, "ValuesPerAction", "guessesPerGuess", $guessesPerGuess)
	IniWrite($iniFile, "ValuesPerAction", "shiftsPerShift", $shiftsPerShift)

	IniWrite($iniFile, "GuessingLimits", "upperGuess", $upperGuess)
	IniWrite($iniFile, "GuessingLimits", "lowerGuess", $lowerGuess)

	IniWrite($iniFile, "UpgradeLevels", "upgradeLevel_id1", $upgradeLevel_id1)
	IniWrite($iniFile, "UpgradeLevels", "upgradeLevel_id2", $upgradeLevel_id2)
	IniWrite($iniFile, "UpgradeLevels", "upgradeLevel_id3", $upgradeLevel_id3)

	IniWrite($iniFile, "Upgrade_id1", "upgrade_id1_currentCost", $upgrade_id1_currentCost)
	IniWrite($iniFile, "Upgrade_id1", "upgrade_id1_currentValue", $upgrade_id1_currentValue)
	IniWrite($iniFile, "Upgrade_id1", "clicksPerClickNext", $clicksPerClickNext)

	IniWrite($iniFile, "Upgrade_id2", "upgrade_id2_currentCost", $upgrade_id2_currentCost)
	IniWrite($iniFile, "Upgrade_id2", "upgrade_id2_currentValue", $upgrade_id2_currentValue)
	IniWrite($iniFile, "Upgrade_id2", "guessesPerGuessNext", $guessesPerGuessNext)

	IniWrite($iniFile, "Upgrade_id3", "upgrade_id3_currentCost", $upgrade_id3_currentCost)
	IniWrite($iniFile, "Upgrade_id3", "upgrade_id3_currentValue", $upgrade_id3_currentValue)
	IniWrite($iniFile, "Upgrade_id3", "shiftsPerShiftNext", $shiftsPerShiftNext)

    IniWrite($iniFile, "Statistics", "manualClicks", $manualClicks)
    IniWrite($iniFile, "Statistics", "manualGuesses", $manualGuesses)
    IniWrite($iniFile, "Statistics", "manualShifts", $manualShifts)
EndFunc

#Region ; Declaring empty variables
$upgradeButton_id1 = -1
$upgradeButton_id2 = -1
$upgradeButton_id3 = -1
#EndRegion

; Window
$width = 500	; Window size
$height = 500
$posX = (@DesktopWidth - $width) / 2	; Centering window
$posY = (@DesktopHeight - $height) / 2	; Centering window
GUICreate("Klikerra", $width, $height, $posX, $posY)	; Initialize window
GUISetState(@SW_SHOW)	; Make window visible

#Region ; Currencies
GUICtrlCreateGroup("Currencies", 325, 40, 115, 73)	; Creates GroupBox as a container
GUICtrlCreateGroup("", -99, -99, 1, 1)	; Ends GroupBox

GUICtrlCreatePic(@ScriptDir & "\icons\clicks_icon.jpg", 334, 60, 10, 10) ; Clicks icon
$clicksLabel = GUICtrlCreateLabel("Clicks: " & $clicks, 349, 58, 90, 15)

GUICtrlCreatePic(@ScriptDir & "\icons\guesses_icon.jpg", 334, 75, 10, 10) ; Guesses icon
$guessesLabel = GUICtrlCreateLabel("Guesses: " & $guesses, 349, 73, 90, 15)

GUICtrlCreatePic(@ScriptDir & "\icons\shifts_icon.jpg", 334, 90, 10, 10) ; Shifts icon
$shiftsLabel = GUICtrlCreateLabel("Shifts: " & $shifts, 349, 88, 90, 15)
#EndRegion

; Clicker button
$clickerButton = GUICtrlCreateButton("+" & $clicksPerClick & " Clicks", 325, 155, 120, 50)

; Guess field
$randomNumber = Random($upperGuess, $lowerGuess, 1)	; Create Random number
$guessLowerLabelText = "Guess a number from:" & @CRLF & $upperGuess & " to " & $lowerGuess
$guessUpperLabel = GUICtrlCreateLabel("Press 'Enter' to guess", 325, 260, 120, 50)
$guessInputField = GUICtrlCreateInput("", 325, 275, 120, 50)
$guessLowerLabel = GUICtrlCreateLabel($guessLowerLabelText, 325, 325, 130, 50)

; Shifts "button"
$BS_MULTILINE = 0x00002000	; Enables mulitline (@CRLF) inside of button
$BS_CENTER = 0x00000300		; Centers text horizontally and vertically
$shiftsButton = GUICtrlCreateButton("Press 'SHIFT'" & @CRLF & "for " & $shiftsPerShift & " Shifts", 325, 395, 120, 50, BitOR($BS_MULTILINE, $BS_CENTER))

; Menu buttons
$upgradesButton = GUICtrlCreateButton("Upgrades", 10, 10, 95, 30)
$statisticsButton = GUICtrlCreateButton("Statistics", 115, 10, 95, 30)
$achievementsButton = GUICtrlCreateButton("Achievements", 220, 10, 95, 30)

; Clears the main area
Func _clearArea($MainX, $MainY, $MainWidth, $MainHeight)
    ; Step 1: Delete all controls inside the specified area
    Local $iControl = 0
    While $iControl <= 1000 ; Adjust range if needed
        If GUICtrlGetHandle($iControl) <> 0 Then
            Local $aPos = ControlGetPos("", "", $iControl)
            If IsArray($aPos) Then
                If $aPos[0] >= $MainX And $aPos[1] >= $MainY And _
                   $aPos[0] + $aPos[2] <= $MainX + $MainWidth And _
                   $aPos[1] + $aPos[3] <= $MainY + $MainHeight Then
                    GUICtrlDelete($iControl)
                EndIf
            EndIf
        EndIf
        $iControl += 1
    WEnd

	$upgradeButton_id1 = -1
	$upgradeButton_id2 = -1
	$upgradeButton_id3 = -1

EndFunc

; Warning "Insufficient funds"
$SS_CENTER = 0x00000001
$SS_CENTERIMAGE = 0x00000200
Func _warningInsufficientFunds()
    $warningInsufficientFunds = GUICtrlCreateLabel("Insufficient funds", 325, 12, 115, 26, BitOR($SS_CENTER, $SS_CENTERIMAGE))
    GUICtrlSetBkColor($warningInsufficientFunds, $yellow) ; Yellow
    Sleep(700) ; Wait for 700 ms (0,7 sec)
    GUICtrlDelete($warningInsufficientFunds) ; Remove the label
EndFunc

; Value-Cost pairs for upgrades
Global $upgrade_id1_allValues[12] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Max", "Max"]
Global $upgrade_id1_allCosts[12] = [10, 40, 150, 400, 1000, 3000, 7000, 16000, 45000, 100000, "Max"]
Global $upgrade_id2_allValues[12] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Max", "Max"]
Global $upgrade_id2_allCosts[12] = [2, 8, 30, 80, 150, 300, 700, 1600, 4500, 10000, "Max"]
Global $upgrade_id3_allValues[12] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Max", "Max"]
Global $upgrade_id3_allCosts[12] = [10, 40, 150, 400, 1000, 3000, 7000, 16000, 45000, 100000, "Max"]

; "Upgrades" button logic
Func _upgradesButtonClicked()

	; Upgrade #1
	$upgradeButton_id1 = GUICtrlCreateButton($upgradeLevel_id1, 10, 50, 25, 25)
	$upgradeLabel_id1_Description = GUICtrlCreateLabel("Clicks per Click: " & $clicksPerClick & " --> " & $clicksPerClickNext, 45, 56, 175, 25)
	$upgradeLabel_id1_CostLabel = GUICtrlCreateLabel("Cost: " & $upgrade_id1_allCosts[$upgrade_id1_currentCost] & " Clicks", 210, 56, 105, 25)

	If $upgradeLevel_id1 >= 11 Then
		GUICtrlSetState($upgradeButton_id1, $GUI_DISABLE) ; Disable button
		$upgradeLabel_id1_Description = GUICtrlCreateLabel("Clicks per Click: 10 (Max)", 45, 56, 175, 25)
		GUICtrlDelete($upgradeLabel_id1_Description)
		$upgradeLabel_id1_Description = GUICtrlCreateLabel("Clicks per Click: 10 (Max)", 45, 56, 175, 25)
		GUICtrlDelete($clickerButton)
		$clicksPerClick = 10
		$clickerButton = GUICtrlCreateButton("+" & $clicksPerClick & " Clicks", 325, 155, 120, 50)
	EndIf

	; Upgrade #2
	$upgradeButton_id2 = GUICtrlCreateButton($upgradeLevel_id2, 10, 85, 25, 25)
	$upgradeLabel_id2_Description = GUICtrlCreateLabel("Guesses per Guess: " & $guessesPerGuess & " --> " & $guessesPerGuessNext, 45, 91, 175, 25)
	$upgradeLabel_id2_CostLabel = GUICtrlCreateLabel("Cost: " & $upgrade_id2_allCosts[$upgrade_id2_currentCost] & " Guesses", 210, 91, 105, 25)

	If $upgradeLevel_id2 >= 11 Then
		GUICtrlSetState($upgradeButton_id2, $GUI_DISABLE) ; Disable button
		$upgradeLabel_id2_Description = GUICtrlCreateLabel("Guesses per Guess: 10 (Max)", 45, 91, 175, 25)
		GUICtrlDelete($upgradeLabel_id2_Description)
		$upgradeLabel_id2_Description = GUICtrlCreateLabel("Guesses per Guess: 10 (Max)", 45, 91, 175, 25)
		$guessesPerGuess = 10
	EndIf

	; Upgrade #3
	$upgradeButton_id3 = GUICtrlCreateButton($upgradeLevel_id3, 10, 120, 25, 25)
	$upgradeLabel_id3_Description = GUICtrlCreateLabel("Shifts per Shift: " & $shiftsPerShift & " --> " & $shiftsPerShiftNext, 45, 126, 175, 25)
	$upgradeLabel_id3_CostLabel = GUICtrlCreateLabel("Cost: " & $upgrade_id3_allCosts[$upgrade_id3_currentCost] & " Shifts", 210, 126, 105, 25)

	If $upgradeLevel_id3 >= 11 Then
		GUICtrlSetState($upgradeButton_id3, $GUI_DISABLE) ; Disable button
		$upgradeLabel_id3_Description = GUICtrlCreateLabel("Shifts per Shift: 10 (Max)", 45, 126, 175, 25)
		GUICtrlDelete($upgradeLabel_id3_Description)
		$upgradeLabel_id3_Description = GUICtrlCreateLabel("Shifts per Shift: 10 (Max)", 45, 126, 175, 25)
		GUICtrlDelete($shiftsButton)
		$shiftsPerShift = 10
		$shiftsButton = GUICtrlCreateButton("Press 'SHIFT'" & @CRLF & "for " & $shiftsPerShift & " Shifts", 325, 395, 120, 50, BitOR($BS_MULTILINE, $BS_CENTER))
	EndIf
EndFunc

; "Upgrades --> 1st upgrade" button logic
Func _upgradesButtonUpgrade_id1_Clicked()
	If $clicks >= $upgrade_id1_allCosts[$upgrade_id1_currentCost] Then 	; Enough money for upgrade
			$clicks -= $upgrade_id1_allCosts[$upgrade_id1_currentCost]

			$upgradeLevel_id1 += 1	; Add +1 to button lvl
			$upgrade_id1_currentValue += 1 ; Updating current clicks per click value
			$upgrade_id1_currentCost += 1 ; Updating the next cost
			$clicksPerClick = $upgrade_id1_allValues[$upgrade_id1_currentValue]
			$clicksPerClickNext = $upgrade_id1_allValues[$upgrade_id1_currentValue + 1]

			GUICtrlDelete($upgradeButton_id1)
			$upgradeButton_id1 = GUICtrlCreateButton($upgradeLevel_id1, 10, 50, 25, 25) ; New button with +1 lvl

			If $upgradeLevel_id1 >= 11 Then
				GUICtrlSetState($upgradeButton_id1, $GUI_DISABLE) ; Disable button
				$upgradeLabel_id1_Description = GUICtrlCreateLabel("Clicks per Click: 10 (Maxed)", 45, 56, 175, 25)
				GUICtrlDelete($upgradeLabel_id1_Description)
				$upgradeLabel_id1_Description = GUICtrlCreateLabel("Clicks per Click: 10 (Maxed)", 45, 56, 175, 25)
				GUICtrlDelete($clickerButton)
				$clicksPerClick = 10
				$clickerButton = GUICtrlCreateButton("+" & $clicksPerClick & " Clicks", 325, 155, 120, 50)
			EndIf

			GUICtrlDelete($clickerButton)
			$clickerButton = GUICtrlCreateButton("+" & $clicksPerClick & " Clicks", 325, 155, 120, 50)

			$clicksLabel = GUICtrlCreateLabel("Clicks: " & $clicks, 349, 58, 90, 15)
			$upgradeLabel_id1_Description = GUICtrlCreateLabel("Clicks per Click: " & $clicksPerClick & " --> " & $clicksPerClickNext, 45, 56, 175, 25)

			$upgradeLabel_id1_CostLabel = GUICtrlCreateLabel("Cost: " & $upgrade_id1_allCosts[$upgrade_id1_currentCost] & " Clicks", 210, 56, 105, 25) ; Next cost

	ElseIf $clicks < $upgrade_id1_allCosts[$Upgrade_id1_currentCost] Then
		_warningInsufficientFunds() ; NOT enough money for upgrade`
	EndIf
EndFunc

; "Upgrades --> 2nd upgrade" button logic
Func _upgradesButtonUpgrade_id2_Clicked()
	If $guesses >= $upgrade_id2_allCosts[$upgrade_id2_currentCost] Then 	; Enough money for upgrade
			$guesses -= $upgrade_id2_allCosts[$upgrade_id2_currentCost]

			$upgradeLevel_id2 += 1	; Add +1 to button lvl
			$upgrade_id2_currentValue += 1 ; Updating current guesses per guess value
			$upgrade_id2_currentCost += 1 ; Updating the next cost
			$guessesPerGuess = $upgrade_id2_allValues[$upgrade_id2_currentValue]
			$guessesPerGuessNext = $upgrade_id2_allValues[$upgrade_id2_currentValue + 1]

			GUICtrlDelete($upgradeButton_id2)
			$upgradeButton_id2 = GUICtrlCreateButton($upgradeLevel_id2, 10, 85, 25, 25) ; New button with +1 lvl

			If $upgradeLevel_id2 >= 11 Then
				GUICtrlSetState($upgradeButton_id2, $GUI_DISABLE) ; Disable button
				$upgradeLabel_id2_Description = GUICtrlCreateLabel("Guesses per Guess: 10 (Maxed)", 45, 91, 175, 25)
				GUICtrlDelete($upgradeLabel_id2_Description)
				$upgradeLabel_id2_Description = GUICtrlCreateLabel("Guesses per Guess: 10 (Maxed)", 45, 91, 175, 25)
				$guessesPerGuess = 10
			EndIf

			$guessesLabel = GUICtrlCreateLabel("Guesses: " & $guesses, 349, 73, 90, 15)
			$upgradeLabel_id2_Description = GUICtrlCreateLabel("Guesses per Guess: " & $guessesPerGuess & " --> " & $guessesPerGuessNext, 45, 91, 175, 25)

			$upgradeLabel_id2_CostLabel = GUICtrlCreateLabel("Cost: " & $upgrade_id2_allCosts[$upgrade_id2_currentCost] & " Guesses", 210, 91, 105, 25) ; Next cost

	ElseIf $guesses < $upgrade_id2_allCosts[$Upgrade_id2_currentCost] Then
		_warningInsufficientFunds() ; NOT enough money for upgrade`
	EndIf

EndFunc

; "Upgrades --> 3rd upgrade" button logic
Func _upgradesButtonUpgrade_id3_Clicked()
	If $shifts >= $upgrade_id3_allCosts[$upgrade_id3_currentCost] Then 	; Enough money for upgrade
			$shifts -= $upgrade_id3_allCosts[$upgrade_id3_currentCost]

			$upgradeLevel_id3 += 1	; Add +1 to button lvl
			$upgrade_id3_currentValue += 1 ; Updating current shifts per shift value
			$upgrade_id3_currentCost += 1 ; Updating the next cost
			$shiftsPerShift = $upgrade_id3_allValues[$upgrade_id3_currentValue]
			$shiftsPerShiftNext = $upgrade_id3_allValues[$upgrade_id3_currentValue + 1]

			GUICtrlDelete($upgradeButton_id3)
			$upgradeButton_id3 = GUICtrlCreateButton($upgradeLevel_id3, 10, 120, 25, 25) ; New button with +1 lvl

			If $upgradeLevel_id3 >= 11 Then
				GUICtrlSetState($upgradeButton_id3, $GUI_DISABLE) ; Disable button
				$upgradeLabel_id3_Description = GUICtrlCreateLabel("Shifts per Shift: 10 (Maxed)", 45, 126, 175, 25)
				GUICtrlDelete($upgradeLabel_id3_Description)
				$upgradeLabel_id3_Description = GUICtrlCreateLabel("Shifts per Shift: 10 (Maxed)", 45, 126, 175, 25)
				GUICtrlDelete($shiftsButton)
				$shiftsPerShift = 10
				$shiftsButton = GUICtrlCreateButton("Press 'SHIFT'" & @CRLF & "for " & $shiftsPerShift & " Shifts", 325, 395, 120, 50, BitOR($BS_MULTILINE, $BS_CENTER))
			EndIf

			GUICtrlDelete($shiftsButton)
			$shiftsButton = GUICtrlCreateButton("Press 'SHIFT'" & @CRLF & "for " & $shiftsPerShift & " Shifts", 325, 395, 120, 50, BitOR($BS_MULTILINE, $BS_CENTER))

			$shiftsLabel = GUICtrlCreateLabel("Shifts: " & $shifts, 349, 88, 90, 15)
			$upgradeLabel_id3_Description = GUICtrlCreateLabel("Shifts per Shift: " & $shiftsPerShift & " --> " & $shiftsPerShiftNext, 45, 126, 175, 25)

			$upgradeLabel_id3_CostLabel = GUICtrlCreateLabel("Cost: " & $upgrade_id3_allCosts[$upgrade_id3_currentCost] & " Shifts", 210, 126, 105, 25)

	ElseIf $shifts < $upgrade_id3_allCosts[$Upgrade_id3_currentCost] Then
		_warningInsufficientFunds() ; NOT enough money for upgrade`
	EndIf
EndFunc

; "Statistics" button logic
Func _statisticsButtonClicked()

	$statisticsManualClicks = GUICtrlCreateLabel("Times Clicked: " & $manualClicks, 10, 56, 300, 20)
	$statisticsManualGuesses = GUICtrlCreateLabel("Correct Guesses: " & $manualGuesses, 10, 91, 300, 20)
	$statisticsManualShifts = GUICtrlCreateLabel("Times Shifted: " & $manualShifts, 10, 126, 300, 20)
EndFunc

; "Achievements" button logic
Func _achievementsButtonClicked()

	; Manual Clicks
	If $manualClicks > 100 Then
		$achievementsManualClicks_100 = GUICtrlCreateLabel("Have 'Times Clicked': 100", 10, 56, 300, 20)
		GUICtrlSetBkColor($achievementsManualClicks_100, $green) ; Green
	Else
		$achievementsManualClicks_100 = GUICtrlCreateLabel("Have 'Times Clicked': 100", 10, 56, 300, 20)
	EndIf

	If $manualClicks > 1000 Then
		$achievementsManualClicks_1000 = GUICtrlCreateLabel("Have 'Times Clicked': 1000", 10, 91, 300, 20)
		GUICtrlSetBkColor($achievementsManualClicks_1000, $green) ; Green
	Else
		$achievementsManualClicks_1000 = GUICtrlCreateLabel("Have 'Times Clicked': 1000", 10, 91, 300, 20)
	EndIf

	If $manualClicks > 10000 Then
		$achievementsManualClicks_10000 = GUICtrlCreateLabel("Have 'Times Clicked': 10'000", 10, 126, 300, 20)
		GUICtrlSetBkColor($achievementsManualClicks_10000, $green) ; Green
	Else
		$achievementsManualClicks_10000 = GUICtrlCreateLabel("Have 'Times Clicked': 10'000", 10, 126, 300, 20)
	EndIf

	; Manual Guesses
	If $manualGuesses > 10 Then
		$achievementsManualGuesses_10 = GUICtrlCreateLabel("Have 'Correct Guesses': 10", 10, 171, 300, 20)
		GUICtrlSetBkColor($achievementsManualGuesses_10, $green) ; Green
	Else
		$achievementsManualGuesses_10 = GUICtrlCreateLabel("Have 'Correct guesses': 10", 10, 171, 300, 20)
	EndIf

	If $manualGuesses > 100 Then
		$achievementsManualGuesses_100 = GUICtrlCreateLabel("Have 'Correct guesses': 100", 10, 206, 300, 20)
		GUICtrlSetBkColor($achievementsManualGuesses_100, $green) ; Green
	Else
		$achievementsManualGuesses_100 = GUICtrlCreateLabel("Have 'Correct guesses': 100", 10, 206, 300, 20)
	EndIf

	If $manualGuesses > 1000 Then
		$achievementsManualGuesses_1000 = GUICtrlCreateLabel("Have 'Correct guesses': 1000", 10, 241, 300, 20)
		GUICtrlSetBkColor($achievementsManualGuesses_1000, $green) ; Green
	Else
		$achievementsManualGuesses_1000 = GUICtrlCreateLabel("Have 'Correct guesses': 1000", 10, 241, 300, 20)
	EndIf

	; Manual Shifts
	If $manualShifts > 100 Then
		$achievementsManualShifts_100 = GUICtrlCreateLabel("Have 'Times Shifted': 100", 10, 286, 300, 20)
		GUICtrlSetBkColor($achievementsManualShifts_100, $green) ; Green
	Else
		$achievementsManualShifts_10000 = GUICtrlCreateLabel("Have 'Times Shifted': 100", 10, 286, 300, 20)
	EndIf

	If $manualShifts > 1000 Then
		$achievementsManualShifts_1000 = GUICtrlCreateLabel("Have 'Times Shifted': 1000", 10, 321, 300, 20)
		GUICtrlSetBkColor($achievementsManualShifts_1000, $green) ; Green
	Else
		$achievementsManualShifts_10000 = GUICtrlCreateLabel("Have 'Times Shifted': 1000", 10, 321, 300, 20)
	EndIf

	If $manualShifts > 10000 Then
		$achievementsManualShifts_10000 = GUICtrlCreateLabel("Have 'Times Shifted': 10'000", 10, 356, 300, 20)
		GUICtrlSetBkColor($achievementsManualShifts_10000, $green) ; Green
	Else
		$achievementsManualShifts_10000 = GUICtrlCreateLabel("Have 'Times Shifted': 10'000", 10, 356, 300, 20)
	EndIf

	; Goal of the game
	If $upgradeLevel_id1 >= 11 and $upgradeLevel_id2 >= 11 and $upgradeLevel_id3 >= 11 Then
		$goalOfTheGame = GUICtrlCreateLabel("Goal of the game: Have all upgrades lvl 11", 10, 421, 300, 20)
		GUICtrlSetBkColor($goalOfTheGame, $green) ; Green
	Else
		$goalOfTheGame = GUICtrlCreateLabel("Goal of the game: Have all upgrades lvl 11", 10, 421, 300, 20)
	EndIf
EndFunc

; Checks if "ENTER" is pressed
Func _IsEnterPressed()
    If _IsPressed("0D") Then Return True ; 0D = ENTER
    Return False
EndFunc

; Checks if "SHIFT" is pressed
Global $shiftWasPressed = False		; Tracks the previous state
Func _isShiftPressed()
    Local $isPressed = _IsPressed("A0") Or _IsPressed("A1")		; Check if any Shift key is pressed

    If $isPressed And Not $shiftWasPressed Then
        $shiftWasPressed = True
        Return True		; Only returns True on the first press
    ElseIf Not $isPressed Then
        $shiftWasPressed = False	; Reset when Shift is released
    EndIf

    Return False
EndFunc

; Clicker button logic
Global $lastClickTime = TimerInit() ; Initialize a timer
Func _clickerButtonLogic()
    Local $currentTime = TimerDiff($lastClickTime) ; Get time since last click

    If $currentTime > 50 Then ; Allow clicks only if at least 75ms have passed
        $clicks += $clicksPerClick
        $manualClicks += 1
        GUICtrlSetData($clicksLabel, "Clicks: " & $clicks)
        $lastClickTime = TimerInit() ; Reset timer
    EndIf
EndFunc

; Guessing field logic
Func _guessingFieldLogic()
	if _IsEnterPressed() Then
		$userGuess = GUICtrlRead($guessInputField)

		If StringIsInt($userGuess) Then
		$userGuess = Number($userGuess)		; Convert to actual number

			If $userGuess > $randomNumber Then
				GUICtrlSetData($guessLowerLabel, "↓ Guess lower️ ↓")
			ElseIf $userGuess < $randomNumber Then
				GUICtrlSetData($guessLowerLabel, "↑ Guess higher ↑")
			ElseIf $userGuess = $randomNumber Then
				if $guessesPerGuess = 1 Then
					GUICtrlSetData($guessLowerLabel, "✅ Correct: " & $randomNumber & @CRLF & "💰 +" & $guessesPerGuess & " Guess")
				Else
					GUICtrlSetData($guessLowerLabel, "✅ Correct: " & $randomNumber & @CRLF & "💰 +" & $guessesPerGuess & " Guesses")
				EndIf

				$guesses += $guessesPerGuess
				$manualGuesses += 1 ; For statistics file
				GUICtrlSetData($guessesLabel, "Guesses: " & $guesses)	; Update label with new Guess count

				; Generate a new random number
				$randomNumber = Random($upperGuess, $lowerGuess, 1)
			EndIf

		Else
			GUICtrlSetData($guessLowerLabel, "⚠️ Guess a number from:" & @CRLF & $upperGuess & " to " & $lowerGuess)
		EndIf
	EndIf
EndFunc

; Shift key logic
Func _shiftKeyLogic()
	$shifts += $shiftsPerShift
	$manualShifts += 1 ; For statistics file
	GUICtrlSetData($shiftsLabel, "Shifts: " & $shifts)		; Update Shift count
EndFunc

While True
    $msg = GUIGetMsg()		; Continuously check for GUI messages

    ; If window is closed with "X"
    If $msg = -3 Then
        _saveData()	; Save data before exiting
        Exit
	EndIf

	; If Clicker button is pressed
	If $msg = $clickerButton Then
	   _clickerButtonLogic()
	EndIf

	; If in Guessing field "Enter" is pressed
	If $msg = $guessInputField Then
		_guessingFieldLogic()
	EndIf

	; If any of the "Shift" keys is pressed
	If _isShiftPressed() Then
		_shiftKeyLogic()
	EndIf

	; If "Upgrades" button is pressed
	If $msg = $upgradesButton Then
		_clearArea(10, 50, 305, 440)
		_upgradesButtonClicked()
	EndIf

	; If "Upgrades --> 1st upgrade" button is pressed
	If $msg = $upgradeButton_id1 Then
		_upgradesButtonUpgrade_id1_Clicked()
	EndIf

	; If "Upgrades --> 2nd upgrade" button is pressed
	If $msg = $upgradeButton_id2 Then
		_upgradesButtonUpgrade_id2_Clicked()
	EndIf

	; If "Upgrades --> 3rd upgrade" button is pressed
	If $msg = $upgradeButton_id3 Then
		_upgradesButtonUpgrade_id3_Clicked()
	EndIf

	; If "Statistics" button is pressed
	If $msg = $statisticsButton Then
		_clearArea(10, 50, 305, 440)
		_statisticsButtonClicked()
	EndIf

	; If "Achievements" button is pressed
	If $msg = $achievementsButton Then
		_clearArea(10, 50, 305, 440)
		_achievementsButtonClicked()
	EndIf

WEnd

; TO-DO
; ✅ 1) Statistics (Button --> Clears part of the screen --> Shows statistics)
; ✅ 2) Achievmements (Button --> Clears part of the screen --> Shows achievements)
; ✅ 3) Upgrades (Button --> Clears part of the screen --> Shows upgrade buttons with labels)
; ✅ 4) End condition --> Achievement "Buy all upgrades"
; ✅ 5) Bugs
