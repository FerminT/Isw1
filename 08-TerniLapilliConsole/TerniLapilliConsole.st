!classDefinition: #TerniLapilliConsoleTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: 'game console lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:35:58'!
test01CreateEmptyGameAndConsole

	game _ TerniLapilli new.
	console _ Console on: game.
	
	self assert: console linesStream atEnd
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:38:21'!
test02FirstPlayIsLogged
	game _ TerniLapilli new.
	console _ Console on: game.
	
	game putXAt: 2@2.
	
	lines _ console linesStream.
	
	self assertNextLineXMarkedMessageOn: 2@2.
	self assertNextLinePlayingOStateMessage.
	self assert: lines atEnd.
	
! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:39:01'!
test03SecondPlayIsLogged
	game _ TerniLapilli new.
	console _ Console on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	lines _ console linesStream.
	
	self assertNextLineXMarkedMessageOn: 2@2.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 1@1.
	self assertNextLinePlayingXStateMessage.
	self assert: lines atEnd.! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:42:38'!
test04aXWonStateIsLogged
	game _ TerniLapilli new.
	console _ Console on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 1@2.
	game putXAt: 3@1.
	
	lines _ console linesStream.
	
	self assertNextLineXMarkedMessageOn: 2@2.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 1@1.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 1@3.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 1@2.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 3@1.
	self assertNextLineXWonStateMessage.
	self assert: lines atEnd.! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:50:19'!
test04bOWonStateIsLogged
	game _ TerniLapilli new.
	console _ Console on: game.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 1@2.
	game putOAt: 1@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	lines _ console linesStream.
	
	self assertNextLineXMarkedMessageOn: 1@1.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 2@2.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 1@2.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 1@3.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 3@3.
	self assertNextLinePlayingOStateMessage.	
	self assertNextLineOMarkedMessageOn: 3@1.
	self assertNextLineOWonStateMessage.
	self assert: lines atEnd! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:48:41'!
test05SlidingXIsLogged
	game _ TerniLapilli new.
	console _ Console on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game slideXFrom: 1@3 to: 1@2.
	
	lines _ console linesStream.
	
	self assertNextLineXMarkedMessageOn: 2@2.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 1@1.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 1@3.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 3@1.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 2@1.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 2@3.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXSlidMessageOn: 1@3 to: 1@2.
	self assertNextLinePlayingOStateMessage.
	self assert: lines atEnd.! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:49:43'!
test06SlidingOIsLogged
	game _ TerniLapilli new.
	console _ Console on: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game slideXFrom: 1@3 to: 1@2.
	game slideOFrom: 3@1 to: 3@2.
	
	lines _ console linesStream.
	
	self assertNextLineXMarkedMessageOn: 2@2.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 1@1.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 1@3.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 3@1.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXMarkedMessageOn: 2@1.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOMarkedMessageOn: 2@3.
	self assertNextLinePlayingXStateMessage.
	self assertNextLineXSlidMessageOn: 1@3 to: 1@2.
	self assertNextLinePlayingOStateMessage.
	self assertNextLineOSlidMessageOn: 3@1 to: 3@2.
	self assertNextLinePlayingXStateMessage.
	self assert: lines atEnd.! !


!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:39:24'!
assertNextLineOMarkedMessageOn: aPosition

	self assert: lines nextLine equals: 'O marcó en ', aPosition asString! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:44:59'!
assertNextLineOSlidMessageOn: aPosition to: anotherPosition

	self assert: lines nextLine equals: 'O deslizó hasta ', anotherPosition asString, ' desde ', aPosition asString! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:40:59'!
assertNextLineOWonStateMessage

	self assert: lines nextLine equals: 'Estado: Juego terminado - ¡Ganó O!!'! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:37:48'!
assertNextLinePlayingOStateMessage

	self assert: lines nextLine equals: 'Estado: Jugando O'! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:40:15'!
assertNextLinePlayingXStateMessage

	self assert: lines nextLine equals: 'Estado: Jugando X'! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:37:27'!
assertNextLineXMarkedMessageOn: aPosition

	self assert: lines nextLine equals: 'X marcó en ', aPosition asString! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:45:05'!
assertNextLineXSlidMessageOn: aPosition to: anotherPosition

	self assert: lines nextLine equals: 'X deslizó hasta ', anotherPosition asString, ' desde ', aPosition asString! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'ft 11/11/2018 17:41:04'!
assertNextLineXWonStateMessage

	self assert: lines nextLine equals: 'Estado: Juego terminado - ¡Ganó X!!'! !


!classDefinition: #TerniLapilliTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliTest methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:51:39'!
assertCanNotMarkAt: aPosition
	self assertCanNotMarkUsing: [ game putXAt: aPosition ].
	self assertCanNotMarkUsing: [ game putOAt: aPosition ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 20:12:53'!
assertCanNotMarkUsing: aMarkingClosure
	self
		should: aMarkingClosure 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionOutsideBoardErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{}
				andOOn:
					{} ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:53:12'!
assertGameIsNotOver
	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:20:23'!
assertGameIsOver
	self assert: game isOver.
	self deny: game isPlayingX.
	self deny: game isPlayingO.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:59:35'!
assertIsPlayingO
	self assert: game isPlayingO.
	self deny: game isPlayingX.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:52:33'!
assertIsPlayingX
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:56:00'!
assertOIsMarkedOn: oPositions
	self
		assert: oPositions size
		equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:38:50'!
assertOWon
	self assertGameIsOver.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:50:53'!
assertXIsMarkedOn: xPositions
	self
		assert: xPositions size
		equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:48:39'!
assertXIsMarkedOn: xPositions andOOn: oPositions
	self assertXIsMarkedOn: xPositions .
	self assertOIsMarkedOn: oPositions .! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:20:00'!
assertXWon
	self assertGameIsOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !


!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 07:25:01'!
functionalException
	^ Error - MessageNotUnderstood.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:31:31'!
test01aGameStartsWithAnEmptyBoardAndPlayingX

	game _ TerniLapilli new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:33:14'!
test01bGameStartsWithAnEmptyBoardButOCanNotPlayFirst
	
	| oPosition |
	
	game _ TerniLapilli new.
	oPosition _ 2@2.
	
	self should: [ game putOAt: oPosition]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage 
				equals: anError messageText.
			self deny: (game isTaken: oPosition) ].			
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:54:38'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{}.
	self assertIsPlayingO.
	
	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:04:28'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{2 @ 2}.
	self assertIsPlayingX.	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:07:30'!
test04CanNotMarkWithXWhenLastMarkWasX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notXTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:09:21'!
test05CanNotMarkWithOWhenLastMarkWasO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putOAt: 3 @ 3 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:11:07'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 1 @ 1. ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:13:58'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:16:06'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putOAt: 1 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:18:11'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 3 @ 3.
	self
		should: [ game putOAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1. 3 @ 3}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/8/2018 13:11:55'!
test10AssertThereIsNotWinner
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 2.
	
	self assertGameIsNotOver ! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:22:01'!
test11XWinsWhenCompletesRowNumber1
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self assertXWon.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:30:21'!
test12XWinsWhenCompletesRowNumber2
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.
	self assertXWon.

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:31:38'!
test13XWinsWhenCompletesRowNumber3
	
	game _ TerniLapilli new.

	game putXAt: 3 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 3 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:35:10'!
test14XWinsWhenCompletesAColumn
	
	game _ TerniLapilli new.

	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 3.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:36:18'!
test15XWinsWhenCompletesDiagonalGoingDown
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 3.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:37:09'!
test16XWinsWhenCompletesDiagonalGoingUp
	game _ TerniLapilli new.

	game putXAt: 1 @ 3.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:38:20'!
test17OWinsWhenCompletesARow
	
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 1 @ 3.
	self assertOWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 09:24:09'!
test18OCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self
		should: [ game putOAt: 3 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self assertOIsMarkedOn:
				{2 @ 1. 3 @ 1} ].
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:18'!
test19XCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.

	self 
		should: [ game  putXAt: 2 @ 3 ] 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 1. 2 @ 2. 2@3}
			 ]
		! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:30'!
test20XCanNotPlaceMoreThanThreePieces
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 2 @ 3.
	self
		should: [ game putXAt: 3 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli playerXHasPlacedThreePieces
				equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 2. 2 @ 1. 3 @ 1} ].
			
			! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test21XCanSlideWhenAllXPiecesWerePlaced
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 2 @ 3.
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	
	self assertXIsMarkedOn: {1 @ 2. 1 @ 3. 2 @ 1}.
	self assertIsPlayingO.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test22OCanSlideWhenAllOPiecesWerePlaced
	
	game _ TerniLapilli new.
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.


	self assertXIsMarkedOn: {1 @ 2. 2 @ 1. 1 @ 3}.
	self assertOIsMarkedOn: {2 @ 2. 3 @ 1. 2 @ 3}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test23CanNotSlideWithXToAnAlreadyMarkedPositionWithX

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 1@2 to: 1@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test24CanNotSlideWithXToAnAlreadyMarkedPositionWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 2@1 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test25CanNotSlideWithOToAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 2@2. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test26CanNotSlideWithOToAnAlreadyMarkedPositionWithX
	
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test27XWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.
	game slideXFrom: 1@2 to: 2@2.
					
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test28OWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self assertOWon.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test29XCanNotSlideWhenOWon
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self 
		should: [ game slideXFrom: 3@1 to: 3@2. ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2.     3@1. 1@3}
				andOOn:
					{2@1. 2@2. 2@3}  ]
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30OCanNotSlideWhenXWon
	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	game slideOFrom: 3 @ 1 to: 2 @ 2.
	game slideXFrom: 2 @ 1 to: 3 @ 1.
	game slideOFrom: 2 @ 2 to: 3 @ 3.
	game slideXFrom: 1 @ 2 to: 2 @ 2.
	
	self should: [game slideOFrom: 1 @ 1 to: 2 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError | self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
		self assertXIsMarkedOn:
					{2@2.     3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test30_01CanNotSlideXToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	self 
		should: [game slideXFrom: 1 @ 3 to: 0 @ 3]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertXIsMarkedOn: { 2@2. 2@1. 1@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30_02CanNotSlideOToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 1 @ 3 to: 1@ 2.
	self 
		should: [ game slideOFrom: 1@1 to: 0@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertOIsMarkedOn: { 1@1. 3@1. 2@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test31DifferenceBetweenPositionsShouldNotBeGreaterThanOneWhenSliding
	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.

	self 
		should: [ game slideXFrom: 3@1 to: 3@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@1}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test32OnlyPermittedXSlidingsBetweenAdjacentsPositions

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.	
					
		self 
		should: [ game slideXFrom: 1@2 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3}   ]
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test33OnlyPermittedOSlidingsBetweenAdjacentsPositions
game _ TerniLapilli new.	

	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.
	
	game slideXFrom: 3@1 to: 3@2.

	self 
		should: [ game slideOFrom: 2@3 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@2}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 20:34:51'!
test34CanNotMarkOutsideBoard
	game _ TerniLapilli new.
	#(0 4 ) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test35CanNotSlideWithXFromAPositionMarkedWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
			
	self 
		should: [ game slideXFrom: 3@1 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test36CanNotSlideWithOFromAPositionMarkedWithX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.

	game slideXFrom: 2@2 to: 1@2.
			
	self 
		should: [ game slideOFrom: 2@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:16'!
test37CanNotSlideXWhenPutingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerXHasPiecesToPlace.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:30'!
test38CanNotSlideOWhenPuttingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerOHasPiecesToPlace.
			self assertOIsMarkedOn: { 1@1 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:49'!
test39CanNotSlideXWhenPlayingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notXTurnErrorMessage.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:50:01'!
test40CanNotSlideOWhenPlayingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notOTurnErrorMessage.
			self assertOIsMarkedOn: { 1@1 } ]
	! !


!classDefinition: #TerniLapilliViewerTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliViewerTest
	instanceVariableNames: 'game viewer view'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliViewerTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:01:06'!
test01NewGameShowsEmptyBoard

	game := TerniLapilli new.
	viewer := Viewer on: game.
	
	view := viewer viewStream.
	
	self assert: view nextLine equals: ' | | '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: ' | | '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: ' | | '.
	self assert: view atEnd! !

!TerniLapilliViewerTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:01:27'!
test02PlacingXShowsOnBoard

	game := TerniLapilli new.
	viewer := Viewer on: game.
	
	game putXAt: 2@2.
	
	view := viewer viewStream.
	
	self assert: view nextLine equals: ' | | '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: ' |X| '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: ' | | '.
	self assert: view nextLine equals: 'Playing O'.
	self assert: view atEnd! !

!TerniLapilliViewerTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:01:36'!
test03PlacingOShowsOnBoard

	game := TerniLapilli new.
	viewer := Viewer on: game.
	
	game putXAt: 2@2.
	game putOAt: 3@1.
	
	view := viewer viewStream.
	
	self assert: view nextLine equals: ' | | '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: ' |X| '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O| | '.
	self assert: view nextLine equals: 'Playing X'.
	self assert: view atEnd! !

!TerniLapilliViewerTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:03:23'!
test04aXWonStateIsDisplayed

	game := TerniLapilli new.
	viewer := Viewer on: game.
	
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	
	view := viewer viewStream.
	
	self assert: view nextLine equals: 'X| | '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O|X| '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O| |X'.
	self assert: view nextLine equals: 'X Won!!'.
	self assert: view atEnd! !

!TerniLapilliViewerTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:04:37'!
test04bOWonStateIsDisplayed

	game := TerniLapilli new.
	viewer := Viewer on: game.
	
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 1@2.
	game putOAt: 2@1.
	game putXAt: 1@3.
	game putOAt: 1@1.
	
	view := viewer viewStream.
	
	self assert: view nextLine equals: 'O|X|X'.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O|X| '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O| | '.
	self assert: view nextLine equals: 'O Won!!'.
	self assert: view atEnd! !

!TerniLapilliViewerTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:09:24'!
test05SlidingXShowsOnBoard

	game := TerniLapilli new.
	viewer := Viewer on: game.
	
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 1@2.
	game putOAt: 2@1.
	game putXAt: 1@3.
	game putOAt: 3@3.
	game slideXFrom: 2@2 to: 3@2.
	
	view := viewer viewStream.
	
	self assert: view nextLine equals: ' |X|X'.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O| | '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O|X|O'.
	self assert: view nextLine equals: 'Playing O'.
	self assert: view atEnd! !

!TerniLapilliViewerTest methodsFor: 'Testing' stamp: 'ft 11/11/2018 17:10:12'!
test06SlidingOShowsOnBoard

	game := TerniLapilli new.
	viewer := Viewer on: game.
	
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 1@2.
	game putOAt: 2@1.
	game putXAt: 1@3.
	game putOAt: 3@3.
	game slideXFrom: 2@2 to: 3@2.
	game slideOFrom: 2@1 to: 1@1.
	
	view := viewer viewStream.
	
	self assert: view nextLine equals: 'O|X|X'.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: ' | | '.
	self assert: view nextLine equals: '-----'.
	self assert: view nextLine equals: 'O|X|O'.
	self assert: view nextLine equals: 'Playing X'.
	self assert: view atEnd! !


!classDefinition: #ActiveVariable category: #TerniLapilliConsole!
Object subclass: #ActiveVariable
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!ActiveVariable methodsFor: 'initialization' stamp: 'ft 11/9/2018 10:54:12'!
initializeOn: aVariable

	observers := OrderedCollection new.
	value := aVariable! !


!ActiveVariable methodsFor: 'observers' stamp: 'ft 11/9/2018 11:02:00'!
addObserver: anObserver

	observers add: anObserver! !


!ActiveVariable methodsFor: 'value' stamp: 'ft 11/10/2018 21:03:31'!
changeTo: newValue

	value := newValue.
	observers do: [ :anObserver | anObserver update: value]! !


!ActiveVariable methodsFor: 'messages' stamp: 'ft 11/9/2018 11:29:18'!
doesNotUnderstand: aMessage

	^aMessage sendTo: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ActiveVariable class' category: #TerniLapilliConsole!
ActiveVariable class
	instanceVariableNames: ''!

!ActiveVariable class methodsFor: 'instance creation' stamp: 'ft 11/9/2018 10:57:10'!
on: aVariable

	^self new initializeOn: aVariable! !


!classDefinition: #TerniLapilli category: #TerniLapilliConsole!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state playerOPositions playerXPositions lastPlay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:39'!
assertAllPiecesOPlaced

	(self playerOPositions size = 3 ) ifFalse: [ self error: self class playerOHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:20'!
assertAllPiecesXPlaced

	(self playerXPositions size = 3 ) ifFalse: [ self error: self class playerXHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 10:47:35'!
assertIsInBoardBounds: aPosition

	(self isInBoardBounds: aPosition) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:55:12'!
assertIsLegalMovementFrom: aPosition to: anotherPosition

	(self moveLegalFrom: aPosition to: anotherPosition) ifFalse: [ self error: self class illegalMovement ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:31:24'!
assertThereIsAnOPieceIn: aPosition

	(self playerOPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:30:17'!
assertThereIsAnXPieceIn: aPosition

	(self playerXPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !


!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:30'!
has: positions threeOf: aPositionComponent

	^positions size >= 3 and: [ (positions collect: aPositionComponent) asBag contents values includes: 3 ]
	! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:20'!
hasCompletedColumn: positions

	^ self has: positions threeOf: [ :aPosition | aPosition y ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:36'!
hasCompletedRow: positions
	
	^ self has: positions threeOf: [ :aPosition | aPosition x ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:47'!
hasDownDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ (4-n) ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:59'!
hasUpDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ n ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:16:26'!
hasWin: positions

	^ (self hasCompletedRow: positions) 
		or: [ (self hasCompletedColumn: positions) 
		or: [ (self hasUpDiagonal: positions) 
		or: [ self hasDownDiagonal: positions ]]].! !


!TerniLapilli methodsFor: 'initialization' stamp: 'ft 11/11/2018 15:10:58'!
initialize

	playerXPositions := OrderedCollection new.
	playerOPositions := OrderedCollection new.
	state := ActiveVariable on: (PlacingX new initializeFor: self).
	lastPlay := String new! !


!TerniLapilli methodsFor: 'marking board' stamp: 'JG 11/6/2018 20:34:26'!
putOAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putOAt: aPosition! !

!TerniLapilli methodsFor: 'marking board' stamp: 'JG 11/6/2018 20:34:12'!
putXAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putXAt: aPosition! !


!TerniLapilli methodsFor: 'marking board - private' stamp: 'ft 11/9/2018 15:29:53'!
changeStateAfterAdding: aPosition to: positions  

	positions add: aPosition.
	state changeTo: (TerniLapilliState for: self).! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'ft 11/11/2018 15:39:39'!
putOWhenPlacingOAt: aPosition

	self playerOHasPiecesToPlace.
	self assertIsFree: aPosition.

	lastPlay := PlacingPlay for: 'O' in: aPosition.
	self changeStateAfterAdding: aPosition to: playerOPositions.
! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:41'!
putOWhenPlacingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:08:31'!
putOWhenSlidingOAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:11'!
putOWhenSlidingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:23'!
putXWhenPlacingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'ft 11/11/2018 15:39:51'!
putXWhenPlacingXAt: aPosition

	self playerXHasPiecesToPlace.
	self assertIsFree: aPosition.
	
	lastPlay := PlacingPlay for: 'X' in: aPosition.
	self changeStateAfterAdding: aPosition to: playerXPositions.
	! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:49'!
putXWhenSlidingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 11:59:44'!
putXWhenSlidingXAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !


!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:58:58'!
playerOHasPiecesToPlace

	 self playerOPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !

!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:59:05'!
playerXHasPiecesToPlace

	 self playerXPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !


!TerniLapilli methodsFor: 'positions' stamp: 'HAW 11/8/2018 10:49:00'!
moveLegalFrom: aPosition to: anotherPosition
	
	^ (self is: aPosition adjacentTo: anotherPosition) and: [ self isInBoardBounds: anotherPosition ]! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TerniLapilli methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:39'!
slideOFrom: aPosition to: anotherPosition

	self assertThereIsAnOPieceIn: aPosition.
	state slideOFrom: aPosition to: anotherPosition! !

!TerniLapilli methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:21'!
slideXFrom: aPosition to: anotherPosition

	self assertThereIsAnXPieceIn: aPosition.
	state slideXFrom: aPosition to: anotherPosition! !


!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:41:03'!
slideOWhenPlacingOFrom: aPosition to: anotherPosition

	self error: self class playerOHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:46:55'!
slideOWhenPlayingXFrom: aPosition to: anotherPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'ft 11/11/2018 15:39:01'!
slideOWhenSlidingOFrom: aPosition to: anotherPosition
	
	self assertIsFree: anotherPosition .
	self assertIsLegalMovementFrom: aPosition to: anotherPosition.
	
	lastPlay := SlidingPlay for: 'O' from: aPosition to: anotherPosition.
	playerOPositions remove: aPosition.
	self changeStateAfterAdding: anotherPosition to: playerOPositions.! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:16:01'!
slideXWhenPlacingXFrom: aPosition to: anotherPosition

	self error: self class playerXHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:44:53'!
slideXWhenPlayingOFrom: aPosition to: anotherPosition

	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'ft 11/11/2018 15:39:18'!
slideXWhenSlidingXFrom: aPosition to: anotherPosition
	
	self assertIsFree: anotherPosition .
	self assertIsLegalMovementFrom: aPosition to: anotherPosition.
	
	lastPlay := SlidingPlay for: 'X' from: aPosition to: anotherPosition.
	playerXPositions remove: aPosition.
	self changeStateAfterAdding: anotherPosition to: playerXPositions.! !


!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
does: aNumber distanceOneTo: anotherNumber

	^ (aNumber - anotherNumber) abs < 2 ! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 11:30:51'!
hasXMorePiecesToPlace
	
	^playerXPositions size < 3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
is: aPosition adjacentTo: anotherPosition

	^ (self does: aPosition x distanceOneTo: anotherPosition x) and: [ self does: aPosition y distanceOneTo: anotherPosition y ]
	! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 10:47:53'!
isInBoardBounds: aPosition

	^aPosition between: 1@1 and: 3@3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 5/31/2018 00:16:45'!
isTaken: aPosition

	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TerniLapilli methodsFor: 'testing game result' stamp: 'ft 11/10/2018 22:06:52'!
hasPlayerOWon

	^self hasWin: playerOPositions! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'ft 11/10/2018 22:07:03'!
hasPlayerXWon
	
	^self hasWin: playerXPositions! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !


!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:19:47'!
isPlacingX
	
	^state isPlacingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:16'!
isSlidingX
	
	^state isSlidingX! !


!TerniLapilli methodsFor: 'observers' stamp: 'ft 11/9/2018 11:31:05'!
addStateObserver: anObserver
	
	state addObserver: anObserver! !


!TerniLapilli methodsFor: 'last play' stamp: 'ft 11/9/2018 15:29:11'!
lastPlay

	^ lastPlay! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilliConsole!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 11:12:02'!
eachPlayerOnlyHasThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 11/8/2018 09:55:12'!
illegalMovement
	
	^'Movement is not legal'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:08'!
playerOHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:02:06'!
playerOHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:16'!
playerXHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:01:23'!
playerXHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:21:33'!
playersCanOnlySlideTheirOwnPieces

	^ 'Players can only slide their own pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 20:07:12'!
positionOutsideBoardErrorMessage
	^ 'Position is outside board'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TerniLapilliPlay category: #TerniLapilliConsole!
Object subclass: #TerniLapilliPlay
	instanceVariableNames: 'player'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliPlay methodsFor: 'accessing' stamp: 'ft 11/11/2018 15:35:24'!
player

	^ player! !


!classDefinition: #PlacingPlay category: #TerniLapilliConsole!
TerniLapilliPlay subclass: #PlacingPlay
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!PlacingPlay methodsFor: 'initialization' stamp: 'ft 11/11/2018 15:29:15'!
initializeFor: aPlayer in: aPosition

	player := aPlayer.
	position := aPosition! !


!PlacingPlay methodsFor: 'accessing' stamp: 'ft 11/11/2018 15:35:37'!
position

	^ position! !


!PlacingPlay methodsFor: 'visitors' stamp: 'ft 11/11/2018 15:37:53'!
accept: aVisitor

	aVisitor visitPlacingPlay: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingPlay class' category: #TerniLapilliConsole!
PlacingPlay class
	instanceVariableNames: ''!

!PlacingPlay class methodsFor: 'class initialization' stamp: 'ft 11/11/2018 15:28:47'!
for: aPlayer in: aPosition

	^self new initializeFor: aPlayer in: aPosition! !


!classDefinition: #SlidingPlay category: #TerniLapilliConsole!
TerniLapilliPlay subclass: #SlidingPlay
	instanceVariableNames: 'origin destiny'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!SlidingPlay methodsFor: 'initialization' stamp: 'ft 11/11/2018 15:34:44'!
initializeFor: aPlayer from: aPosition to: anotherPosition

	player := aPlayer.
	origin := aPosition.
	destiny := anotherPosition! !


!SlidingPlay methodsFor: 'accessing' stamp: 'ft 11/11/2018 15:36:02'!
destiny

	^ destiny! !

!SlidingPlay methodsFor: 'accessing' stamp: 'ft 11/11/2018 15:35:54'!
origin

	^ origin! !


!SlidingPlay methodsFor: 'visitors' stamp: 'ft 11/11/2018 15:37:23'!
accept: aVisitor

	aVisitor visitSlidingPlay: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingPlay class' category: #TerniLapilliConsole!
SlidingPlay class
	instanceVariableNames: ''!

!SlidingPlay class methodsFor: 'class initialization' stamp: 'ft 11/11/2018 15:34:07'!
for: aPlayer from: aPosition to: anotherPosition

	 ^self new initializeFor: aPlayer from: aPosition to: anotherPosition! !


!classDefinition: #TerniLapilliState category: #TerniLapilliConsole!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:16'!
areAllXsOnTheBoard
	
	^false! !

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:10'!
isOver
	
	^false! !


!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:06:17'!
isPlacingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:15:12'!
isPlayingO
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:14:00'!
isPlayingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:36'!
isSlidingX
	
	^false! !


!TerniLapilliState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:03:55'!
putOAt: aPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:04:00'!
putXAt: aPosition
	
	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPosition
	
	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !


!TerniLapilliState methodsFor: 'visitors' stamp: 'ft 11/9/2018 12:20:07'!
accept: aTerniLapilliStateVisitor

	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'last play' stamp: 'ft 11/10/2018 22:17:36'!
lastPlay

	^ game lastPlay! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #TerniLapilliConsole!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'ft 11/10/2018 21:21:58'!
for: aTerniLapilli 

	| stateClass |
	
	stateClass := self allSubclasses detect: [:aStateClass | aStateClass isFor: aTerniLapilli ].	
	^stateClass new initializeFor: aTerniLapilli ! !


!TerniLapilliState class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:21:46'!
isFor: aTerniLapilli 

	^self subclassResponsibility ! !


!classDefinition: #GameOverState category: #TerniLapilliConsole!
TerniLapilliState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!GameOverState methodsFor: 'testing game result' stamp: 'ft 11/10/2018 21:15:12'!
hasPlayerOWon

	self subclassResponsibility ! !

!GameOverState methodsFor: 'testing game result' stamp: 'ft 11/10/2018 21:15:08'!
hasPlayerXWon

	self subclassResponsibility ! !

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:15:43'!
isOver

	^ true.! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:08:57'!
putOAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:09:02'!
putXAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !


!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !


!GameOverState methodsFor: 'visitors' stamp: 'ft 11/10/2018 22:10:34'!
accept: aTerniLapilliStateVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOverState class' category: #TerniLapilliConsole!
GameOverState class
	instanceVariableNames: ''!

!GameOverState class methodsFor: 'state selection' stamp: 'ft 11/10/2018 22:04:57'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #WonO category: #TerniLapilliConsole!
GameOverState subclass: #WonO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!WonO methodsFor: 'visitors' stamp: 'ft 11/10/2018 22:10:52'!
accept: aTerniLapilliStateVisitor

	aTerniLapilliStateVisitor visitWonO: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WonO class' category: #TerniLapilliConsole!
WonO class
	instanceVariableNames: ''!

!WonO class methodsFor: 'state selection' stamp: 'ft 11/10/2018 22:07:27'!
isFor: aTerniLapilli

	^ aTerniLapilli hasPlayerOWon! !


!classDefinition: #WonX category: #TerniLapilliConsole!
GameOverState subclass: #WonX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!WonX methodsFor: 'visitors' stamp: 'ft 11/10/2018 22:10:56'!
accept: aTerniLapilliStateVisitor

	aTerniLapilliStateVisitor visitWonX: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WonX class' category: #TerniLapilliConsole!
WonX class
	instanceVariableNames: ''!

!WonX class methodsFor: 'state selection' stamp: 'ft 11/10/2018 22:07:36'!
isFor: aTerniLapilli

	^ aTerniLapilli hasPlayerXWon! !


!classDefinition: #PlayingO category: #TerniLapilliConsole!
TerniLapilliState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !


!PlayingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlayingOFrom: aPosition to: anotherPostion .! !


!PlayingO methodsFor: 'visitors' stamp: 'ft 11/9/2018 15:21:41'!
accept: aTerniLapilliStateVisitor

	aTerniLapilliStateVisitor visitPlayingO: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingO class' category: #TerniLapilliConsole!
PlayingO class
	instanceVariableNames: ''!

!PlayingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:23:04'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingO category: #TerniLapilliConsole!
PlayingO subclass: #PlacingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:10:45'!
putOAt: aPosition

	game putOWhenPlacingOAt: aPosition ! !

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:05:38'!
putXAt: aPosition

	game putXWhenPlacingOAt: aPosition ! !


!PlacingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game slideOWhenPlacingOFrom: aPosition to: anotherPostion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingO class' category: #TerniLapilliConsole!
PlacingO class
	instanceVariableNames: ''!

!PlacingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 12:07:43'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlacingX and: [ aTerniLapilli hasPlayerXWon not ] ! !


!classDefinition: #SlidingO category: #TerniLapilliConsole!
PlayingO subclass: #SlidingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:11:14'!
putOAt: aPosition

	game putOWhenSlidingOAt: aPosition ! !

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:04:38'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenSlidingOFrom: aPosition to: anotherPostion .! !


!SlidingO methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 12:04:38'!
areAllXsOnTheBoard
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingO class' category: #TerniLapilliConsole!
SlidingO class
	instanceVariableNames: ''!

!SlidingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:57:15'!
isFor: aTerniLapilli 

	^aTerniLapilli isSlidingX and: [ aTerniLapilli hasPlayerXWon not ]! !


!classDefinition: #PlayingX category: #TerniLapilliConsole!
TerniLapilliState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenPlayingXFrom: aPosition to: anotherPostion .! !


!PlayingX methodsFor: 'visitors' stamp: 'ft 11/9/2018 15:21:49'!
accept: aTerniLapilliStateVisitor

	aTerniLapilliStateVisitor visitPlayingX: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingX class' category: #TerniLapilliConsole!
PlayingX class
	instanceVariableNames: ''!

!PlayingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:25:23'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingX category: #TerniLapilliConsole!
PlayingX subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:52:28'!
putOAt: aPosition

	game putOWhenPlacingXAt: aPosition ! !

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 11:58:08'!
putXAt: aPosition

	game putXWhenPlacingXAt: aPosition ! !


!PlacingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlacingXFrom: aPosition to: anotherPostion .! !


!PlacingX methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:06:28'!
isPlacingX

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingX class' category: #TerniLapilliConsole!
PlacingX class
	instanceVariableNames: ''!

!PlacingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:25:47'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace]! !


!classDefinition: #SlidingX category: #TerniLapilliConsole!
PlayingX subclass: #SlidingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 14:51:46'!
putOAt: aPosition

	game putOWhenSlidingXAt: aPosition ! !

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:00:12'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion
 
	game slideXWhenSlidingXFrom: aPosition to: anotherPostion .! !


!SlidingX methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 11:30:43'!
areAllXsOnTheBoard
	
	^true! !


!SlidingX methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:47'!
isSlidingX

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingX class' category: #TerniLapilliConsole!
SlidingX class
	instanceVariableNames: ''!

!SlidingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:57:36'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace not and: [ aTerniLapilli hasPlayerOWon not ]]! !


!classDefinition: #TerniLapilliStateObserver category: #TerniLapilliConsole!
Object subclass: #TerniLapilliStateObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliStateObserver methodsFor: 'update' stamp: 'ft 11/11/2018 14:37:17'!
update: aTerniLapilliState

	self subclassResponsibility ! !


!TerniLapilliStateObserver methodsFor: 'visiting' stamp: 'ft 11/12/2018 09:28:12'!
visitPlacingPlay: aPlacingPlay

	self subclassResponsibility ! !

!TerniLapilliStateObserver methodsFor: 'visiting' stamp: 'ft 11/11/2018 14:40:28'!
visitPlayingO: aPlayingOState

	self subclassResponsibility ! !

!TerniLapilliStateObserver methodsFor: 'visiting' stamp: 'ft 11/11/2018 14:40:44'!
visitPlayingX: aPlayingXState

	self subclassResponsibility ! !

!TerniLapilliStateObserver methodsFor: 'visiting' stamp: 'ft 11/12/2018 09:28:23'!
visitSlidingPlay: aSlidingPlay

	self subclassResponsibility ! !

!TerniLapilliStateObserver methodsFor: 'visiting' stamp: 'ft 11/11/2018 14:41:08'!
visitWonO: aWonOState

	self subclassResponsibility ! !

!TerniLapilliStateObserver methodsFor: 'visiting' stamp: 'ft 11/11/2018 14:40:59'!
visitWonX: aWonXState

	self subclassResponsibility ! !


!classDefinition: #Console category: #TerniLapilliConsole!
TerniLapilliStateObserver subclass: #Console
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!Console methodsFor: 'initialization' stamp: 'ft 11/11/2018 17:33:41'!
initializeOn: aTerniLapilli

	aTerniLapilli addStateObserver: self.
	lines := ReadWriteStream on: String new! !


!Console methodsFor: 'log' stamp: 'ft 11/11/2018 15:41:21'!
update: newTerniLapilliState
	
	newTerniLapilliState lastPlay accept: self.
	newTerniLapilliState accept: self! !


!Console methodsFor: 'accessing' stamp: 'ft 11/11/2018 17:34:01'!
linesStream
	^ lines copy reset! !


!Console methodsFor: 'visiting' stamp: 'ft 11/11/2018 17:34:52'!
visitPlacingPlay: aPlacingPlay

	^lines nextPutAll: aPlacingPlay player, ' marcó en ', aPlacingPlay position printString; newLine.! !

!Console methodsFor: 'visiting' stamp: 'ft 11/11/2018 17:34:42'!
visitPlayingO: aPlayingOState

	^lines nextPutAll: 'Estado: Jugando O'; newLine! !

!Console methodsFor: 'visiting' stamp: 'ft 11/11/2018 17:35:04'!
visitPlayingX: aPlayingXState

	^lines nextPutAll: 'Estado: Jugando X'; newLine! !

!Console methodsFor: 'visiting' stamp: 'ft 11/11/2018 17:35:13'!
visitSlidingPlay: aSlidingPlay

	^lines nextPutAll: aSlidingPlay player, ' deslizó hasta ', aSlidingPlay destiny printString, ' desde ', aSlidingPlay origin printString; newLine! !

!Console methodsFor: 'visiting' stamp: 'ft 11/11/2018 17:35:22'!
visitWonO: aWonOState

	^lines nextPutAll: 'Estado: Juego terminado - ¡Ganó O!!'; newLine! !

!Console methodsFor: 'visiting' stamp: 'ft 11/11/2018 17:35:30'!
visitWonX: aWonXState

	^lines nextPutAll: 'Estado: Juego terminado - ¡Ganó X!!'; newLine! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Console class' category: #TerniLapilliConsole!
Console class
	instanceVariableNames: ''!

!Console class methodsFor: 'instance creation' stamp: 'ft 11/11/2018 15:03:47'!
on: aTerniLapilli
	^ self new initializeOn: aTerniLapilli! !


!classDefinition: #Viewer category: #TerniLapilliConsole!
TerniLapilliStateObserver subclass: #Viewer
	instanceVariableNames: 'board state view'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!Viewer methodsFor: 'initialization' stamp: 'ft 11/11/2018 17:24:30'!
initializeOn: aTerniLapilli

	aTerniLapilli addStateObserver: self.
	board := Array2D height: 3 width: 3.
	1 to: 3 do: [:x |
		1 to: 3 do: [:y |
			board i: x j: y put: ' ']].
	
	view := ReadWriteStream on: String new.	
	state := String new.! !


!Viewer methodsFor: 'update' stamp: 'ft 11/11/2018 15:44:04'!
update: newTerniLapilliState

	newTerniLapilliState lastPlay accept: self.
	newTerniLapilliState accept: self! !


!Viewer methodsFor: 'visiting' stamp: 'ft 11/11/2018 15:52:34'!
visitPlacingPlay: aPlacingPlay

	board i: aPlacingPlay position x j: aPlacingPlay position y put: aPlacingPlay player! !

!Viewer methodsFor: 'visiting' stamp: 'ft 11/11/2018 15:48:34'!
visitPlayingO: aPlayingOState

	state := 'Playing O'! !

!Viewer methodsFor: 'visiting' stamp: 'ft 11/11/2018 15:48:45'!
visitPlayingX: aPlayingXState

	state := 'Playing X'! !

!Viewer methodsFor: 'visiting' stamp: 'ft 11/11/2018 15:52:22'!
visitSlidingPlay: aSlidingPlay

	board i: aSlidingPlay origin x j: aSlidingPlay origin y put: ' '.
	board i: aSlidingPlay destiny x j: aSlidingPlay destiny y put: aSlidingPlay player! !

!Viewer methodsFor: 'visiting' stamp: 'ft 11/11/2018 15:48:56'!
visitWonO: aWonOState

	state := 'O Won!!'! !

!Viewer methodsFor: 'visiting' stamp: 'ft 11/11/2018 15:49:05'!
visitWonX: aWonXState

	state := 'X Won!!'! !


!Viewer methodsFor: 'accessing' stamp: 'ft 11/11/2018 17:30:49'!
viewStream

	self parseRow: 1.
	self addSeparator.
	self parseRow: 2.
	self addSeparator.
	self parseRow: 3.
	
	view nextPutAll: state.
	
	^view reset copy! !


!Viewer methodsFor: 'parsing - private' stamp: 'ft 11/11/2018 17:27:33'!
addSeparator

	view nextPutAll: '-----'; newLine! !

!Viewer methodsFor: 'parsing - private' stamp: 'ft 11/11/2018 17:28:43'!
parseRow: anIndex

	1 to: 3 do: [ :y | 
		view nextPutAll: (board i: anIndex j: y).
		y < 3 ifTrue: [view nextPut: $|]].
	view newLine! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Viewer class' category: #TerniLapilliConsole!
Viewer class
	instanceVariableNames: ''!

!Viewer class methodsFor: 'instance creation' stamp: 'ft 11/11/2018 15:03:36'!
on: aTerniLapilli

	^self new initializeOn: aTerniLapilli! !
