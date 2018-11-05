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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:33:04'!
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
			self assert: TerniLapilli ponerSinMasFichas = tableroInvalido messageText ].
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/3/2018 14:55:46'!
test10NoSePuedePonerFichaFueraDelTablero

	| tablero |

	tablero := TerniLapilli new.
	
	self
		should: [tablero ponerCruzEn: 4@2]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorPosicionInvalida = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/4/2018 17:18:31'!
test11MoverFichaMueveALaPosicionIndicada

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 1@2.
	tablero ponerCruzEn: 3@2.
	tablero ponerCirculoEn: 1@1.
	tablero ponerCruzEn: 1@3.
	tablero ponerCirculoEn: 3@1.
	
	tablero moverCruzEn: 2@2 a: 3@3.
	self assert: (tablero fichaCruzEn: 3@3).
	self assert: (tablero fichaVaciaEn: 2@2)
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/4/2018 16:29:01'!
test12NoSePuedeMoverFichaSiNoEstanTodas

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 1@2.
	tablero ponerCruzEn: 3@2.
	tablero ponerCirculoEn: 1@1.
	
	self 
		should: [tablero moverCruzEn: 2@2 a: 2@3]
		raise: Error
		withExceptionDo: [ :tableroInvalido | 
			self assert: TerniLapilli errorFaltanFichas = tableroInvalido messageText]
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/4/2018 16:50:45'!
test13NoSePuedeMoverFichaAPosicionNoConsecutiva

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 1@2.
	tablero ponerCruzEn: 3@2.
	tablero ponerCirculoEn: 1@1.
	tablero ponerCruzEn: 1@3.
	tablero ponerCirculoEn: 3@1.
	
	self 
		should: [tablero moverCruzEn: 1@3 a: 3@3]
		raise: Error
		withExceptionDo: [ :tableroInvalido | 
			self assert: TerniLapilli errorMovimientoInvalido = tableroInvalido messageText]
	! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'matriz turno'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'operations' stamp: 'LTO 11/5/2018 19:20:54'!
moverCirculoEn: origen a: destino

	turno puedeJugarCirculo.
	self validarMoverFichaEn: origen a: destino.
	self state moverCirculoEn: origen a: destino! !

!TerniLapilli methodsFor: 'operations' stamp: 'LTO 11/5/2018 19:20:47'!
moverCruzEn: origen a: destino

	turno puedeJugarCruz.
	self validarMoverFichaEn: origen a: destino.
	self state moverCruzEn: origen a: destino! !

!TerniLapilli methodsFor: 'operations' stamp: 'LTO 11/5/2018 19:16:56'!
ponerCirculoEn: posicion

	turno puedeJugarCirculo.
	self validarPonerFichaEn: posicion.
	self state ponerCirculoEn: posicion! !

!TerniLapilli methodsFor: 'operations' stamp: 'LTO 11/5/2018 19:17:15'!
ponerCruzEn: posicion
	
	turno puedeJugarCruz.
	self validarPonerFichaEn: posicion.
	self state ponerCruzEn: posicion! !


!TerniLapilli methodsFor: 'initialization' stamp: 'LTO 11/5/2018 19:12:32'!
initialize
	matriz := Array2D height: 3 width: 3.
	1 to: 3 do: [:x | 
		1 to: 3 do: [:y | 
			matriz i: x j: y put: 0]].
	
	turno := TurnoCruz new.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'LTO 11/1/2018 19:56:39'!
fichaCirculoEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 2! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LTO 11/1/2018 19:56:33'!
fichaCruzEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 1! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LTO 11/1/2018 19:56:26'!
fichaVaciaEn: posicion
	
	^ (matriz i: posicion x j: posicion y) = 0! !


!TerniLapilli methodsFor: 'testing' stamp: 'LTO 11/5/2018 17:26:44'!
cantidadFichasEnTablero
	| fichas |
	
	fichas := 0.
	
	1 to: 3 do: [:x | 
		1 to: 3 do: [:y | 
			(self fichaVaciaEn: x@y) ifFalse: [fichas := fichas + 1]]].
	
	^fichas! !

!TerniLapilli methodsFor: 'testing' stamp: 'LTO 11/5/2018 18:10:08'!
juegoTerminado
	^ (self validarJuegoTerminado: [:unaPosicionATestear | self fichaCruzEn: unaPosicionATestear]) or: 
		[self validarJuegoTerminado: [:unaPosicionATestear | self fichaCirculoEn: unaPosicionATestear]]! !

!TerniLapilli methodsFor: 'testing' stamp: 'LTO 11/5/2018 18:08:10'!
validarJuegoTerminado: unBloqueParaValidarPosicion

	| horizontal vertical diagonal diagonalInvertida termino |
	termino := false.

	1 to: 3 do: [ :y |
		horizontal := 0.
		1 to: 3 do: [ :x |
			(unBloqueParaValidarPosicion value: x@y) ifTrue: [horizontal := horizontal + 1]].
		termino := termino or: [horizontal = 3]
	].
	
	1 to: 3 do: [ :x |
		vertical := 0.
		1 to: 3 do: [ :y |
			(unBloqueParaValidarPosicion value: x@y) ifTrue: [vertical := vertical + 1]].
		termino := termino or: [vertical = 3]
	].
	
	diagonal := 0.
	1 to: 3 do: [:xy |
		(unBloqueParaValidarPosicion value: xy@xy) ifTrue: [diagonal := diagonal + 1]].
	termino := termino or: [diagonal = 3].
	
	diagonalInvertida := 0.
	1 to: 3 do: [:xy |
		(unBloqueParaValidarPosicion value: xy@(4 - xy)) ifTrue: [diagonalInvertida := diagonalInvertida + 1]].
	termino := termino or: [diagonalInvertida = 3].
	
	^ termino! !


!TerniLapilli methodsFor: 'validation - private' stamp: 'ft 11/4/2018 16:55:19'!
posicionValida: posicion

	^(posicion x between: 1 and: 3) and: [posicion y between: 1 and: 3]! !

!TerniLapilli methodsFor: 'validation - private' stamp: 'ft 11/4/2018 17:10:56'!
posicionesConsecutivas: posicionIzquierda con: posicionDerecha

	^(posicionDerecha x between: posicionIzquierda x - 1 and: posicionIzquierda x + 1) and: [posicionDerecha y between: posicionIzquierda y - 1 and: posicionIzquierda y + 1]! !

!TerniLapilli methodsFor: 'validation - private' stamp: 'LTO 11/5/2018 19:19:18'!
validarMoverFichaEn: origen a: destino
	self validarPonerFichaEn: destino.
	(self posicionValida: origen) ifFalse: [^self error: self class errorPosicionInvalida].
	(self posicionesConsecutivas: origen con: destino) ifFalse: [^self error: self class errorMovimientoInvalido]! !

!TerniLapilli methodsFor: 'validation - private' stamp: 'LTO 11/5/2018 19:16:32'!
validarPonerFichaEn: posicion
	(self posicionValida: posicion) ifFalse: [^self error: self class errorPosicionInvalida].
	(self fichaVaciaEn: posicion) ifFalse: [^self error: self class errorPosicionOcupada].! !


!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 19:14:08'!
cambiarTurno
	turno := turno siguienteTurno ! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 18:43:05'!
moverCirculoValidoEn: origen a: destino

	self ponerVaciaEn: origen.
	self ponerCirculoValidoEn: destino.! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 18:44:01'!
moverCruzValidaEn: origen a: destino

	self ponerVaciaEn: origen.
	self ponerCruzValidaEn: destino.! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 18:41:18'!
moverCuandoTieneQuePoner
	self error: self class errorFaltanFichas ! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 18:40:06'!
operacionCuandoJuegoTerminado
	^self error: self class errorJuegoTerminado! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 18:34:49'!
ponerCirculoValidoEn: posicion
	matriz i: posicion x j: posicion y put: 2.
	self cambiarTurno! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 18:17:08'!
ponerCruzValidaEn: posicion
	matriz i: posicion x j: posicion y put: 1.
	self cambiarTurno! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'LTO 11/5/2018 18:33:04'!
ponerSinMasFichas
	^ self error: self class ponerSinMasFichas ! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'ft 11/4/2018 16:12:55'!
ponerVaciaEn: posicion

	matriz i: posicion x j: posicion y put: 0.! !


!TerniLapilli methodsFor: 'state' stamp: 'LTO 11/5/2018 18:18:13'!
state
	
	^TerniLapilliEstado for: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/4/2018 16:31:39'!
errorFaltanFichas

	^'No hay suficientes fichas como para realizar un movimiento'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/2/2018 15:57:50'!
errorJuegoTerminado

	^'El juego ya ha finalizado'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'LTO 11/1/2018 20:04:35'!
errorJugadaSinTurno

	^ 'No es tu turno para jugar'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/4/2018 16:49:17'!
errorMovimientoInvalido

	^'No se puede mover la ficha a la posicion indicada'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/3/2018 15:02:39'!
errorPosicionInvalida

	^'La posicion no representa un punto del tablero'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'LTO 11/1/2018 20:15:23'!
errorPosicionOcupada

	^ 'La posicion en la que queres jugar esta ocupada'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'LTO 11/5/2018 18:33:04'!
ponerSinMasFichas

	^ 'No se pueden poner más fichas en el tablero'! !


!classDefinition: #TerniLapilliEstado category: #TerniLapilli!
Object subclass: #TerniLapilliEstado
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 17:47:32'!
initializeFor: unTerniLapilli 
	
	terniLapilli := unTerniLapilli ! !

!TerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:37:17'!
moverCirculoEn: origen a: destino
	self subclassResponsibility ! !

!TerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:31:04'!
ponerCirculoEn: posicion

	self subclassResponsibility ! !

!TerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:19:32'!
ponerCruzEn: posicion

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliEstado class' category: #TerniLapilli!
TerniLapilliEstado class
	instanceVariableNames: ''!

!TerniLapilliEstado class methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 17:45:32'!
for: unTerniLapilli 
	
	^ self subclasses 
		detect: [:aStateClass | aStateClass isFor: unTerniLapilli ]
		ifFound: [:aStateClass | aStateClass newFor: unTerniLapilli ]
		ifNone: [ self error: 'Estado invalido para TerniLapilli' ]! !

!TerniLapilliEstado class methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 17:46:14'!
isFor: unTerniLapilli

	self subclassResponsibility ! !

!TerniLapilliEstado class methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 17:46:30'!
newFor: unTerniLapilli 
	
	^self new initializeFor: unTerniLapilli ! !


!classDefinition: #MoviendoFichasTerniLapilliEstado category: #TerniLapilli!
TerniLapilliEstado subclass: #MoviendoFichasTerniLapilliEstado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!MoviendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:38:07'!
moverCirculoEn: origen a: destino
	^ terniLapilli moverCirculoValidoEn: origen a: destino.! !

!MoviendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:44:38'!
moverCruzEn: origen a: destino
	^ terniLapilli moverCruzValidaEn: origen a: destino.! !

!MoviendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:31:24'!
ponerCirculoEn: posicion
	^ terniLapilli ponerSinMasFichas! !

!MoviendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:33:04'!
ponerCruzEn: posicion
	^ terniLapilli ponerSinMasFichas! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoviendoFichasTerniLapilliEstado class' category: #TerniLapilli!
MoviendoFichasTerniLapilliEstado class
	instanceVariableNames: ''!

!MoviendoFichasTerniLapilliEstado class methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:12:00'!
isFor: unTerniLapilli
	
	^ unTerniLapilli cantidadFichasEnTablero = 6 and: [unTerniLapilli juegoTerminado not]! !


!classDefinition: #PoniendoFichasTerniLapilliEstado category: #TerniLapilli!
TerniLapilliEstado subclass: #PoniendoFichasTerniLapilliEstado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PoniendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:38:48'!
moverCirculoEn: origen a: destino
	^ terniLapilli moverCuandoTieneQuePoner.! !

!PoniendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:38:55'!
moverCruzEn: origen a: destino
	^ terniLapilli moverCuandoTieneQuePoner.! !

!PoniendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:31:48'!
ponerCirculoEn: posicion
	^ terniLapilli ponerCirculoValidoEn: posicion! !

!PoniendoFichasTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:24:56'!
ponerCruzEn: posicion
	^ terniLapilli ponerCruzValidaEn: posicion! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PoniendoFichasTerniLapilliEstado class' category: #TerniLapilli!
PoniendoFichasTerniLapilliEstado class
	instanceVariableNames: ''!

!PoniendoFichasTerniLapilliEstado class methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:12:10'!
isFor: unTerniLapilli
	
	^ unTerniLapilli cantidadFichasEnTablero < 6 and: [unTerniLapilli juegoTerminado not]! !


!classDefinition: #TerminadoTerniLapilliEstado category: #TerniLapilli!
TerniLapilliEstado subclass: #TerminadoTerniLapilliEstado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerminadoTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:39:27'!
moverCirculoEn: origen a: destino
	^ terniLapilli operacionCuandoJuegoTerminado.! !

!TerminadoTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:39:30'!
moverCruzEn: origen a: destino
	^ terniLapilli operacionCuandoJuegoTerminado.! !

!TerminadoTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:40:06'!
ponerCirculoEn: posicion
	^ terniLapilli operacionCuandoJuegoTerminado! !

!TerminadoTerniLapilliEstado methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:40:06'!
ponerCruzEn: posicion
	^ terniLapilli operacionCuandoJuegoTerminado! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerminadoTerniLapilliEstado class' category: #TerniLapilli!
TerminadoTerniLapilliEstado class
	instanceVariableNames: ''!

!TerminadoTerniLapilliEstado class methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 18:12:28'!
isFor: unTerniLapilli
	
	^ unTerniLapilli juegoTerminado! !


!classDefinition: #Turno category: #TerniLapilli!
Object subclass: #Turno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Turno methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:09:24'!
puedeJugarCirculo
	self subclassResponsibility ! !

!Turno methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:09:21'!
puedeJugarCruz
	self subclassResponsibility ! !

!Turno methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:06:04'!
siguienteTurno
	self subclassResponsibility ! !


!classDefinition: #TurnoCirculo category: #TerniLapilli!
Turno subclass: #TurnoCirculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TurnoCirculo methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:09:48'!
puedeJugarCirculo! !

!TurnoCirculo methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:10:49'!
puedeJugarCruz
	self error: TerniLapilli errorJugadaSinTurno ! !

!TurnoCirculo methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:12:01'!
siguienteTurno
	^ TurnoCruz new! !


!classDefinition: #TurnoCruz category: #TerniLapilli!
Turno subclass: #TurnoCruz
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TurnoCruz methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:11:33'!
puedeJugarCirculo
	self error: TerniLapilli errorJugadaSinTurno ! !

!TurnoCruz methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:11:39'!
puedeJugarCruz
! !

!TurnoCruz methodsFor: 'as yet unclassified' stamp: 'LTO 11/5/2018 19:12:05'!
siguienteTurno
	^ TurnoCirculo new! !
