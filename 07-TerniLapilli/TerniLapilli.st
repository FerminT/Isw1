!classDefinition: #TerniLapilliTests category: #TerniLapilli!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:01:38'!
test01TableroNuevoTieneTodasLasPosicionesVacias

	| tablero |

	tablero := TerniLapilli new.
	
	1 to: 3 do: [:x | 1 to: 3 do: [:y | self assert: (tablero fichaVaciaEn: x@y)]].
	1 to: 3 do: [:x | 1 to: 3 do: [:y | self deny: (tablero fichaCruzEn: x@y)]].
	1 to: 3 do: [:x | 1 to: 3 do: [:y | self deny: (tablero fichaCirculoEn: x@y)]]! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:01:33'!
test02PrimeraJugadaPoneCruzEnPosicionYDejaVaciaLasDemas

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@1.
	self assert: (tablero fichaCruzEn: 1@1).
	self assert: (tablero fichaVaciaEn: 1@2).
	self assert: (tablero fichaVaciaEn: 1@3).
	2 to: 3 do: [:x | 1 to: 3 do: [:y | self assert: (tablero fichaVaciaEn: x@y)]]
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:01:29'!
test03NoPuedeJugarPrimeroCirculo

	| tablero |

	tablero := TerniLapilli new.
	self
		should: [tablero ponerCirculoEn: 1@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJugadaSinTurno = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:01:25'!
test04NoPuedeJugarSegundoCruz

	| tablero |

	tablero := TerniLapilli new.
	tablero ponerCruzEn: 1@1.
	self
		should: [tablero ponerCruzEn: 2@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJugadaSinTurno = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:01:20'!
test05NoPuedePonerFichaEnPosicionOcupada

	| tablero |

	tablero := TerniLapilli new.
	tablero ponerCruzEn: 2@2.
	self
		should: [tablero ponerCirculoEn: 2@2]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorPosicionOcupada = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:01:16'!
test06NoPuedenHaberMasDeTresCruces

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 1@2.
	tablero ponerCruzEn: 3@2.
	tablero ponerCirculoEn: 1@1.
	tablero ponerCruzEn: 1@3.
	tablero ponerCirculoEn: 3@1.
	
	self
		should: [tablero ponerCruzEn: 2@3]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorNoHayMasFichas = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:01:11'!
test07PonerTresFichasEnLineaVerticalTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@2.
	tablero ponerCirculoEn: 1@1.
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 1@3.
	tablero ponerCruzEn: 3@2.
	
	self
		should: [tablero ponerCirculoEn: 3@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:05:32'!
test08PonerTresFichasEnLineaHorizontalTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@1.
	tablero ponerCirculoEn: 2@1.
	tablero ponerCruzEn: 1@2.
	tablero ponerCirculoEn: 2@3.
	tablero ponerCruzEn: 1@3.
	
	self
		should: [tablero ponerCirculoEn: 3@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/2/2018 16:40:58'!
test09PonerTresFichasEnLineaDiagonalTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@3.
	tablero ponerCirculoEn: 2@1.
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 2@3.
	tablero ponerCruzEn: 3@1.
	
	self
		should: [tablero ponerCirculoEn: 1@2]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'matriz turno estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'operations' stamp: 'ft 11/2/2018 10:25:09'!
cambiarTurno
	turno := turno bitXor: 3! !

!TerniLapilli methodsFor: 'operations' stamp: 'ft 11/2/2018 16:42:38'!
ponerCirculoEn: posicion
	
	| circulosHorizontal circulosVertical circulosDiagonal |

	estado = 0 ifFalse: [^self error: self class errorJuegoTerminado].
	turno = 1 ifTrue: [^self error: self class errorJugadaSinTurno].
	(self cantidadFichasEnTablero = 6) ifTrue: [^self error: self class errorNoHayMasFichas].
	(self fichaVaciaEn: posicion) ifFalse: [^self error: self class errorPosicionOcupada].
	
	matriz i: posicion x j: posicion y put: 2.

	circulosHorizontal := 0.
	1 to: 3 do: [ :x |
		(self fichaCirculoEn: x@posicion y) ifTrue: [circulosHorizontal := circulosHorizontal + 1]].
	circulosHorizontal = 3 ifTrue: [estado := 2].
	
	circulosVertical := 0.
	1 to: 3 do: [ :y |
		(self fichaCirculoEn: posicion x@y) ifTrue: [circulosVertical := circulosVertical + 1]].
	circulosVertical = 3 ifTrue: [estado := 2].
	
	circulosDiagonal := 0.
	1 to: 3 do: [:xy |
		(self fichaCruzEn: xy@xy) ifTrue: [circulosDiagonal := circulosDiagonal + 1]].
	circulosDiagonal = 3 ifTrue: [estado := 2] ifFalse: [
		circulosDiagonal := 0.
		1 to: 3 do: [:x |
			(self fichaCruzEn: x@(4 - x)) ifTrue: [circulosDiagonal := circulosDiagonal + 1]].
		circulosDiagonal = 3 ifTrue: [estado := 2]].
			
	self cambiarTurno! !

!TerniLapilli methodsFor: 'operations' stamp: 'ft 11/2/2018 16:39:33'!
ponerCruzEn: posicion

	| crucesHorizontal crucesVertical crucesDiagonal |

	estado = 0 ifFalse: [^self error: self class errorJuegoTerminado].
	turno = 2 ifTrue: [^self error: self class errorJugadaSinTurno].
	(self cantidadFichasEnTablero = 6) ifTrue: [^self error: self class errorNoHayMasFichas].
	(self fichaVaciaEn: posicion) ifFalse: [^self error: self class errorPosicionOcupada].
	
	matriz i: posicion x j: posicion y put: 1.
	
	crucesHorizontal := 0.
	1 to: 3 do: [ :x |
		(self fichaCruzEn: x@posicion y) ifTrue: [crucesHorizontal := crucesHorizontal + 1]].
	crucesHorizontal = 3 ifTrue: [estado := 1].
	
	crucesVertical := 0.
	1 to: 3 do: [ :y |
		(self fichaCruzEn: posicion x@y) ifTrue: [crucesVertical := crucesVertical + 1]].
	crucesVertical = 3 ifTrue: [estado := 1].
	
	crucesDiagonal := 0.
	1 to: 3 do: [:xy |
		(self fichaCruzEn: xy@xy) ifTrue: [crucesDiagonal := crucesDiagonal + 1]].
	crucesDiagonal = 3 ifTrue: [estado := 1] ifFalse: [
		crucesDiagonal := 0.
		1 to: 3 do: [:x |
			(self fichaCruzEn: x@(4 - x)) ifTrue: [crucesDiagonal := crucesDiagonal + 1]].
		crucesDiagonal = 3 ifTrue: [estado := 1]].
		
	self cambiarTurno! !


!TerniLapilli methodsFor: 'initialization' stamp: 'ft 11/2/2018 15:58:38'!
initialize
	matriz := Array2D height: 3 width: 3.
	1 to: 3 do: [:x | 
		1 to: 3 do: [:y | 
			matriz i: x j: y put: 0]].
	
	turno := 1.
	estado := 0! !


!TerniLapilli methodsFor: 'accessing' stamp: 'LTO 11/1/2018 19:56:39'!
fichaCirculoEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 2! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LTO 11/1/2018 19:56:33'!
fichaCruzEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 1! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LTO 11/1/2018 19:56:26'!
fichaVaciaEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 0! !


!TerniLapilli methodsFor: 'testing' stamp: 'ft 11/2/2018 10:51:54'!
cantidadCirculosEnTablero

	| circulos |
	
	circulos := 0.
	
	1 to: 3 do: [:x | 
		1 to: 3 do: [:y | 
			(self fichaCirculoEn: x@y) ifTrue: [circulos := circulos + 1]]].
	
	^circulos! !

!TerniLapilli methodsFor: 'testing' stamp: 'ft 11/2/2018 10:51:35'!
cantidadCrucesEnTablero

	| cruces |
	
	cruces := 0.
	
	1 to: 3 do: [:x | 
		1 to: 3 do: [:y | 
			(self fichaCruzEn: x@y) ifTrue: [cruces := cruces + 1]]].
	
	^cruces! !

!TerniLapilli methodsFor: 'testing' stamp: 'ft 11/2/2018 10:52:13'!
cantidadFichasEnTablero

	^self cantidadCrucesEnTablero + self cantidadCirculosEnTablero! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/2/2018 15:57:50'!
errorJuegoTerminado

	^'El juego ya ha finalizado'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'LTO 11/1/2018 20:04:35'!
errorJugadaSinTurno

	^ 'No es tu turno para jugar'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/2/2018 10:46:22'!
errorNoHayMasFichas

	^ 'No se pueden poner más fichas en el tablero'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'LTO 11/1/2018 20:15:23'!
errorPosicionOcupada

	^ 'La posicion en la que queres jugar esta ocupada'! !
