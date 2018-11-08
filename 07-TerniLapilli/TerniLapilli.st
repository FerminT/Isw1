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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 09:58:59'!
test02PrimeraJugadaPoneCruzEnPosicionYDejaVaciaLasDemas

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@1.
	
	self assert: (tablero fichaCruzEn: 1@1).
	self assert: (tablero fichaVaciaEn: 1@2).
	self assert: (tablero fichaVaciaEn: 1@3).
	2 to: 3 do: [:x | 1 to: 3 do: [:y | self assert: (tablero fichaVaciaEn: x@y)]]
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 09:59:07'!
test03NoPuedeJugarPrimeroCirculo

	| tablero |

	tablero := TerniLapilli new.
	
	self
		should: [tablero ponerCirculoEn: 1@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJugadaSinTurno = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 09:59:15'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 09:59:21'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:44:20'!
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
			self assert: TerniLapilli errorPonerSinMasFichas = tableroInvalido messageText ].
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:02:23'!
test09PonerTresFichasEnLineaDiagonalTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@1.
	tablero ponerCirculoEn: 1@2.
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 2@3.
	tablero ponerCruzEn: 3@3.
	
	self
		should: [tablero ponerCirculoEn: 1@3]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:01:31'!
test10PonerTresFichasEnLineaDiagonalInversaTerminaElJuego

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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:01:08'!
test11NoSePuedePonerFichaFueraDelTablero

	| tablero |

	tablero := TerniLapilli new.
	
	self
		should: [tablero ponerCruzEn: 4@2]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorPosicionInvalida = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:00:51'!
test12MoverFichaMueveALaPosicionIndicada

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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:00:43'!
test13NoSePuedeMoverFichaSiNoEstanTodas

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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:00:32'!
test14NoSePuedeMoverFichaAPosicionNoConsecutiva

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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:00:26'!
test15MoverTresFichasEnLineaHorizontalTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@1.
	tablero ponerCirculoEn: 2@1.
	tablero ponerCruzEn: 1@2.
	tablero ponerCirculoEn: 3@2.
	tablero ponerCruzEn: 2@3.
	tablero ponerCirculoEn: 3@1.
	tablero moverCruzEn: 2@3 a: 1@3.
	
	self
		should: [tablero moverCirculoEn: 2@1 a: 2@2.]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:00:18'!
test16MoverTresFichasEnLineaVerticalTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@2.
	tablero ponerCirculoEn: 1@1.
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 1@3.
	tablero ponerCruzEn: 3@3.
	tablero ponerCirculoEn: 3@1.
	tablero moverCruzEn: 3@3 a: 3@2.
	
	self
		should: [tablero moverCirculoEn: 3@1 a: 2@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:00:11'!
test17MoverTresFichasEnLineaDiagonalTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 1@3.
	tablero ponerCirculoEn: 2@1.
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 2@3.
	tablero ponerCruzEn: 3@2.
	tablero ponerCirculoEn: 1@2.
	tablero moverCruzEn: 3@2 a: 3@1.
	
	self
		should: [tablero moverCirculoEn: 2@1 a: 1@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'ft 11/6/2018 10:00:04'!
test18MoverTresFichasEnLineaDiagonalInversaTerminaElJuego

	| tablero |

	tablero := TerniLapilli new.
	
	tablero ponerCruzEn: 3@1.
	tablero ponerCirculoEn: 1@2.
	tablero ponerCruzEn: 2@2.
	tablero ponerCirculoEn: 3@2.
	tablero ponerCruzEn: 2@3.
	tablero ponerCirculoEn: 2@1.
	tablero moverCruzEn: 2@3 a: 1@3.
	
	self
		should: [tablero moverCirculoEn: 1@2 a: 1@1]
		raise: Error
		withExceptionDo: [ :tableroInvalido |
			self assert: TerniLapilli errorJuegoTerminado = tableroInvalido messageText ].
	! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'tablero turno'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:06:13'!
moverCirculoEn: origen a: destino

	turno puedeJugarCirculo.
	self validarMoverFichaEn: origen a: destino.
	
	self estado moverCirculoEn: origen a: destino! !

!TerniLapilli methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:06:17'!
moverCruzEn: origen a: destino

	turno puedeJugarCruz.
	self validarMoverFichaEn: origen a: destino.
	
	self estado moverCruzEn: origen a: destino! !

!TerniLapilli methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:06:21'!
ponerCirculoEn: posicion

	turno puedeJugarCirculo.
	self validarPonerFichaEn: posicion.
	
	self estado ponerCirculoEn: posicion! !

!TerniLapilli methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:06:24'!
ponerCruzEn: posicion
	
	turno puedeJugarCruz.
	self validarPonerFichaEn: posicion.
	
	self estado ponerCruzEn: posicion! !


!TerniLapilli methodsFor: 'inicializacion' stamp: 'LTO 11/8/2018 16:39:24'!
initialize
	tablero := Array2D height: 3 width: 3.
	1 to: 3 do: [:x | 
		1 to: 3 do: [:y | 
			tablero i: x j: y put: 0]].
	
	turno := TurnoCruz new! !


!TerniLapilli methodsFor: 'acceso' stamp: 'LTO 11/5/2018 17:26:44'!
cantidadFichasEnTablero
	| fichas |
	
	fichas := 0.
	
	1 to: 3 do: [:x | 
		1 to: 3 do: [:y | 
			(self fichaVaciaEn: x@y) ifFalse: [fichas := fichas + 1]]].
	
	^fichas! !

!TerniLapilli methodsFor: 'acceso' stamp: 'LTO 11/8/2018 16:38:59'!
fichaCirculoEn: posicion
	
	^ (tablero i: posicion x j: posicion y) = 2! !

!TerniLapilli methodsFor: 'acceso' stamp: 'LTO 11/8/2018 16:39:07'!
fichaCruzEn: posicion
	
	^ (tablero i: posicion x j: posicion y) = 1! !

!TerniLapilli methodsFor: 'acceso' stamp: 'LTO 11/8/2018 16:39:13'!
fichaVaciaEn: posicion
	
	^ (tablero i: posicion x j: posicion y) = 0! !


!TerniLapilli methodsFor: 'testing' stamp: 'LTO 11/5/2018 18:10:08'!
juegoTerminado
	^ (self validarJuegoTerminado: [:unaPosicionATestear | self fichaCruzEn: unaPosicionATestear]) or: 
		[self validarJuegoTerminado: [:unaPosicionATestear | self fichaCirculoEn: unaPosicionATestear]]! !


!TerniLapilli methodsFor: 'validaciones - privado' stamp: 'ft 11/4/2018 16:55:19'!
posicionValida: posicion

	^(posicion x between: 1 and: 3) and: [posicion y between: 1 and: 3]! !

!TerniLapilli methodsFor: 'validaciones - privado' stamp: 'ft 11/4/2018 17:10:56'!
posicionesConsecutivas: posicionIzquierda con: posicionDerecha

	^(posicionDerecha x between: posicionIzquierda x - 1 and: posicionIzquierda x + 1) and: [posicionDerecha y between: posicionIzquierda y - 1 and: posicionIzquierda y + 1]! !

!TerniLapilli methodsFor: 'validaciones - privado' stamp: 'LTO 11/5/2018 19:19:18'!
validarMoverFichaEn: origen a: destino
	self validarPonerFichaEn: destino.
	(self posicionValida: origen) ifFalse: [^self error: self class errorPosicionInvalida].
	(self posicionesConsecutivas: origen con: destino) ifFalse: [^self error: self class errorMovimientoInvalido]! !

!TerniLapilli methodsFor: 'validaciones - privado' stamp: 'LTO 11/5/2018 19:16:32'!
validarPonerFichaEn: posicion
	(self posicionValida: posicion) ifFalse: [^self error: self class errorPosicionInvalida].
	(self fichaVaciaEn: posicion) ifFalse: [^self error: self class errorPosicionOcupada].! !


!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'LTO 11/5/2018 19:14:08'!
cambiarTurno
	turno := turno siguienteTurno ! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'LTO 11/5/2018 18:43:05'!
moverCirculoValidoEn: origen a: destino

	self ponerVaciaEn: origen.
	self ponerCirculoValidoEn: destino.! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'LTO 11/5/2018 18:44:01'!
moverCruzValidaEn: origen a: destino

	self ponerVaciaEn: origen.
	self ponerCruzValidaEn: destino.! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'ft 11/6/2018 10:25:37'!
moverCuandoTieneQuePoner
	^self error: self class errorFaltanFichas ! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'LTO 11/5/2018 18:40:06'!
operacionCuandoJuegoTerminado
	^self error: self class errorJuegoTerminado! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'LTO 11/8/2018 16:39:37'!
ponerCirculoValidoEn: posicion
	tablero i: posicion x j: posicion y put: 2.
	self cambiarTurno! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'LTO 11/8/2018 16:39:51'!
ponerCruzValidaEn: posicion
	tablero i: posicion x j: posicion y put: 1.
	self cambiarTurno! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'ft 11/6/2018 10:51:57'!
ponerCuandoTieneQueMover
	^ self error: self class errorPonerSinMasFichas ! !

!TerniLapilli methodsFor: 'operaciones - privado' stamp: 'LTO 11/8/2018 16:40:00'!
ponerVaciaEn: posicion
	tablero i: posicion x j: posicion y put: 0.! !


!TerniLapilli methodsFor: 'testing - privado' stamp: 'LTO 11/5/2018 18:08:10'!
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


!TerniLapilli methodsFor: 'estado' stamp: 'ft 11/6/2018 10:34:06'!
estado
	
	^TerniLapilliEstado para: self! !

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

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/6/2018 10:44:20'!
errorPonerSinMasFichas

	^ 'No se pueden poner más fichas en el tablero'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'ft 11/3/2018 15:02:39'!
errorPosicionInvalida

	^'La posicion no representa un punto del tablero'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'LTO 11/1/2018 20:15:23'!
errorPosicionOcupada

	^ 'La posicion en la que queres jugar esta ocupada'! !


!classDefinition: #TerniLapilliEstado category: #TerniLapilli!
Object subclass: #TerniLapilliEstado
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliEstado methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:32:02'!
moverCirculoEn: origen a: destino

	self subclassResponsibility ! !

!TerniLapilliEstado methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:33:38'!
moverCruzEn: origen a: destino

	self subclassResponsibility ! !

!TerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:31:04'!
ponerCirculoEn: posicion

	self subclassResponsibility ! !

!TerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:19:32'!
ponerCruzEn: posicion

	self subclassResponsibility ! !


!TerniLapilliEstado methodsFor: 'inicializacion' stamp: 'LTO 11/5/2018 17:47:32'!
initializeFor: unTerniLapilli 
	
	terniLapilli := unTerniLapilli ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliEstado class' category: #TerniLapilli!
TerniLapilliEstado class
	instanceVariableNames: ''!

!TerniLapilliEstado class methodsFor: 'creacion de instancia' stamp: 'LTO 11/5/2018 17:46:30'!
newFor: unTerniLapilli 
	
	^self new initializeFor: unTerniLapilli ! !


!TerniLapilliEstado class methodsFor: 'busqueda' stamp: 'ft 11/6/2018 10:35:16'!
para: unTerniLapilli 
	
	^ self subclasses 
		detect: [:unaClaseDeEstado | unaClaseDeEstado esPara: unTerniLapilli ]
		ifFound: [:unaClaseDeEstado | unaClaseDeEstado newFor: unTerniLapilli ]
		ifNone: [ self error: 'Estado invalido para TerniLapilli' ]! !


!TerniLapilliEstado class methodsFor: 'testing' stamp: 'ft 11/6/2018 10:34:30'!
esPara: unTerniLapilli

	self subclassResponsibility ! !


!classDefinition: #MoviendoFichasTerniLapilliEstado category: #TerniLapilli!
TerniLapilliEstado subclass: #MoviendoFichasTerniLapilliEstado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!MoviendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:38:07'!
moverCirculoEn: origen a: destino
	^ terniLapilli moverCirculoValidoEn: origen a: destino.! !

!MoviendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:44:38'!
moverCruzEn: origen a: destino
	^ terniLapilli moverCruzValidaEn: origen a: destino.! !

!MoviendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:51:30'!
ponerCirculoEn: posicion
	^ terniLapilli ponerCuandoTieneQueMover! !

!MoviendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:51:37'!
ponerCruzEn: posicion
	^ terniLapilli ponerCuandoTieneQueMover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoviendoFichasTerniLapilliEstado class' category: #TerniLapilli!
MoviendoFichasTerniLapilliEstado class
	instanceVariableNames: ''!

!MoviendoFichasTerniLapilliEstado class methodsFor: 'testing' stamp: 'ft 11/6/2018 10:34:30'!
esPara: unTerniLapilli
	
	^ unTerniLapilli cantidadFichasEnTablero = 6 and: [unTerniLapilli juegoTerminado not]! !


!classDefinition: #PoniendoFichasTerniLapilliEstado category: #TerniLapilli!
TerniLapilliEstado subclass: #PoniendoFichasTerniLapilliEstado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PoniendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:38:48'!
moverCirculoEn: origen a: destino
	^ terniLapilli moverCuandoTieneQuePoner.! !

!PoniendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:38:55'!
moverCruzEn: origen a: destino
	^ terniLapilli moverCuandoTieneQuePoner.! !

!PoniendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:31:48'!
ponerCirculoEn: posicion
	^ terniLapilli ponerCirculoValidoEn: posicion! !

!PoniendoFichasTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:24:56'!
ponerCruzEn: posicion
	^ terniLapilli ponerCruzValidaEn: posicion! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PoniendoFichasTerniLapilliEstado class' category: #TerniLapilli!
PoniendoFichasTerniLapilliEstado class
	instanceVariableNames: ''!

!PoniendoFichasTerniLapilliEstado class methodsFor: 'testing' stamp: 'ft 11/6/2018 10:34:30'!
esPara: unTerniLapilli
	
	^ unTerniLapilli cantidadFichasEnTablero < 6 and: [unTerniLapilli juegoTerminado not]! !


!classDefinition: #TerminadoTerniLapilliEstado category: #TerniLapilli!
TerniLapilliEstado subclass: #TerminadoTerniLapilliEstado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerminadoTerniLapilliEstado methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:32:41'!
moverCirculoEn: origen a: destino
	^ terniLapilli operacionCuandoJuegoTerminado! !

!TerminadoTerniLapilliEstado methodsFor: 'operaciones' stamp: 'ft 11/6/2018 10:32:44'!
moverCruzEn: origen a: destino
	^ terniLapilli operacionCuandoJuegoTerminado! !

!TerminadoTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:40:06'!
ponerCirculoEn: posicion
	^ terniLapilli operacionCuandoJuegoTerminado! !

!TerminadoTerniLapilliEstado methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 18:40:06'!
ponerCruzEn: posicion
	^ terniLapilli operacionCuandoJuegoTerminado! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerminadoTerniLapilliEstado class' category: #TerniLapilli!
TerminadoTerniLapilliEstado class
	instanceVariableNames: ''!

!TerminadoTerniLapilliEstado class methodsFor: 'testing' stamp: 'ft 11/6/2018 10:34:30'!
esPara: unTerniLapilli
	
	^ unTerniLapilli juegoTerminado! !


!classDefinition: #Turno category: #TerniLapilli!
Object subclass: #Turno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Turno methodsFor: 'testing' stamp: 'LTO 11/5/2018 19:09:24'!
puedeJugarCirculo
	self subclassResponsibility ! !

!Turno methodsFor: 'testing' stamp: 'LTO 11/5/2018 19:09:21'!
puedeJugarCruz
	self subclassResponsibility ! !


!Turno methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 19:06:04'!
siguienteTurno
	self subclassResponsibility ! !


!classDefinition: #TurnoCirculo category: #TerniLapilli!
Turno subclass: #TurnoCirculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TurnoCirculo methodsFor: 'testing' stamp: 'LTO 11/5/2018 19:09:48'!
puedeJugarCirculo! !

!TurnoCirculo methodsFor: 'testing' stamp: 'ft 11/6/2018 10:37:06'!
puedeJugarCruz
	^self error: TerniLapilli errorJugadaSinTurno ! !


!TurnoCirculo methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 19:12:01'!
siguienteTurno
	^ TurnoCruz new! !


!classDefinition: #TurnoCruz category: #TerniLapilli!
Turno subclass: #TurnoCruz
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TurnoCruz methodsFor: 'testing' stamp: 'ft 11/6/2018 10:38:44'!
puedeJugarCirculo
	^self error: TerniLapilli errorJugadaSinTurno ! !

!TurnoCruz methodsFor: 'testing' stamp: 'LTO 11/5/2018 19:11:39'!
puedeJugarCruz
! !


!TurnoCruz methodsFor: 'operaciones' stamp: 'LTO 11/5/2018 19:12:05'!
siguienteTurno
	^ TurnoCirculo new! !
