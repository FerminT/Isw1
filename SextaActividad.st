!classDefinition: #BooleanTest category: #'Sexta Actividad'!
DenotativeObject subclass: #BooleanTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sexta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooleanTest class' category: #'Sexta Actividad'!
BooleanTest class
	instanceVariableNames: ''!

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:28:44'!
test01LaNegacionDeVerdaderoEsFalso

	Assert that: Verdadero no isEqualTo: Falso! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:31:34'!
test02LaNegacionDeFalsoEsVerdadero

	Assert that: Falso no isEqualTo: Verdadero! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:45:55'!
test03VerdaderoYVerdaderoEsVerdadero

	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:46:31'!
test04VerdaderoYFalsoEsFalso

	Assert that: (Verdadero y: Falso) isEqualTo: Falso! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:48:11'!
test05FalsoYUnBooleanoEsFalso

	Assert that: (Falso y: Falso) isEqualTo: Falso.
	Assert that: (Falso y: Verdadero) isEqualTo: Falso! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:52:19'!
test06VerdaderoOUnBooleanoEsVerdadero

	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:55:34'!
test07FalsoOUnBooleanoEsEseBooleano

	Assert that: (Falso o: Falso) isEqualTo: Falso.
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:13:34'!
test08VerdaderoSiVerdaderoEvaluaElClosure

	| seEvaluoElClosure |
	
	seEvaluoElClosure _ Falso.

	Verdadero siVerdadero: [seEvaluoElClosure _ Verdadero].

	Assert that: seEvaluoElClosure isEqualTo: Verdadero.! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:17:49'!
test09FalsoSiVerdaderoNoEvaluaElClosure

	| seEvaluoElClosure |
	
	seEvaluoElClosure _ Falso.

	Falso siVerdadero: [seEvaluoElClosure _ Verdadero].

	Assert that: seEvaluoElClosure isEqualTo: Falso.! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:20:01'!
test10FalsoSiFalsoEvaluaElClosure

	| seEvaluoElClosure |
	
	seEvaluoElClosure _ Falso.

	Falso siFalso: [seEvaluoElClosure _ Verdadero].

	Assert that: seEvaluoElClosure isEqualTo: Verdadero.! !

!BooleanTest class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:22:36'!
test11VerdaderoSiFalsoNoEvaluaElClosure

	| seEvaluoElClosure |
	
	seEvaluoElClosure _ Falso.

	Verdadero siFalso: [seEvaluoElClosure _ Verdadero].

	Assert that: seEvaluoElClosure isEqualTo: Falso.! !


!classDefinition: #Falso category: #'Sexta Actividad'!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sexta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #'Sexta Actividad'!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:32:21'!
no
	^Verdadero! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:55:54'!
o: unBooleano 
	^unBooleano! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:20:28'!
siFalso: unClosure 
	unClosure value.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:19:11'!
siVerdadero: unClosure ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:48:40'!
y: unBooleano 
	^self! !


!classDefinition: #Verdadero category: #'Sexta Actividad'!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sexta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #'Sexta Actividad'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:30:07'!
no
	^Falso! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:52:52'!
o: unBooleano 
	^self! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:22:54'!
siFalso: unClosure ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 21:15:14'!
siVerdadero: unClosure 
	unClosure value! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'fermin 9/10/2018 20:45:36'!
y: unBoooleano
	^unBoooleano! !
