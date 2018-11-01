!classDefinition: #TerniLapilliTests category: #TerniLapilli!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 19:57:40'!
test01CrearTablero
	| tablero |

	tablero := TerniLapilli new.
	1 to: 3 do: [:x | 1 to: 3 do: [:y | self assert: (tablero fichaVaciaEn: x@y)]].
	1 to: 3 do: [:x | 1 to: 3 do: [:y | self deny: (tablero fichaCruzEn: x@y)]].
	1 to: 3 do: [:x | 1 to: 3 do: [:y | self deny: (tablero fichaCirculoEn: x@y)]]! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:08:56'!
test02PrimeraJugada
	| tablero |

	tablero := TerniLapilli new.
	tablero poneCruzEn: 1@1.
	self assert: (tablero fichaCruzEn: 1@1).
	self assert: (tablero fichaVaciaEn: 1@2).
	self assert: (tablero fichaVaciaEn: 1@3).
	2 to: 3 do: [:x | 1 to: 3 do: [:y | self assert: (tablero fichaVaciaEn: x@y)]]
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:09:05'!
test03QuiereJugarPrimeroCirculo
	| tablero |

	tablero := TerniLapilli new.
	self
		should: [tablero poneCirculoEn: 1@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJugadaSinTurno = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:10:18'!
test04QuiereJugarSegundoCruz
	| tablero |

	tablero := TerniLapilli new.
	tablero poneCruzEn: 1@1.
	self
		should: [tablero poneCruzEn: 2@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJugadaSinTurno = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:15:04'!
test05NoPuedePonerFichaEnPosicionOcupada
	| tablero |

	tablero := TerniLapilli new.
	tablero poneCruzEn: 2@2.
	self
		should: [tablero poneCirculoEn: 2@2]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorPosicionOcupada = tableroInvalido messageText ].
	! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'matriz turno'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 19:56:39'!
fichaCirculoEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 2! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 19:56:33'!
fichaCruzEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 1! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 19:56:26'!
fichaVaciaEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 0! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:05:42'!
initialize
	matriz := Array2D height: 3 width: 3.
	1 to: 3 do: [:x | 1 to: 3 do: [:y | matriz i: x j: y put: 0] ].
	
	turno := 1! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:16:30'!
poneCirculoEn: posicion
	turno = 1 ifTrue: [^ self error: self class errorJugadaSinTurno ].
	(self fichaVaciaEn: posicion) ifFalse: [^ self error: self class errorPosicionOcupada ].
	
	matriz i: posicion x j: posicion y put: 2.
	turno := turno bitXor: 3! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:16:38'!
poneCruzEn: posicion
	turno = 2 ifTrue: [^ self error: self class errorJugadaSinTurno ].
	(self fichaVaciaEn: posicion) ifFalse: [^ self error: self class errorPosicionOcupada ].
	
	matriz i: posicion x j: posicion y put: 1.
	turno := turno bitXor: 3! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:04:35'!
errorJugadaSinTurno

	^ 'No es tu turno para jugar'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'LTO 11/1/2018 20:15:23'!
errorPosicionOcupada

	^ 'La posicion en la que queres jugar esta ocupada'! !
