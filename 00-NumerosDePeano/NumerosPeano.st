!classDefinition: #I category: #'Quinta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta Actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 14:24:09'!
* unNumeroDePeano

	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:55:33'!
- unNumeroDePeano

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:53:58'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self].
	
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 14:29:56'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	^true! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:53:44'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:55:51'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede restar por un número mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:34:57'!
siUno: unClosure
	unClosure value.! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'prev next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:58:52'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:58:59'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:59:12'!
- unNumeroDePeano

	unNumeroDePeano siUno: [^self previous].	

	^self previous - unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:52:04'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:59:51'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^self previous < unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:53:19'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:04:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	prev := nil.
	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:00:43'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:57:47'!
previous

	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:58:35'!
previous: unNumeroDePeano

	previous _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 15:35:19'!
siUno: unClosure! !


!classDefinition: #III category: #'Quinta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta Actividad'!
III class
	instanceVariableNames: 'prev next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:35'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:35'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:35'!
- unNumeroDePeano

	unNumeroDePeano siUno: [^self previous].	

	^self previous - unNumeroDePeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:35'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:35'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^self previous < unNumeroDePeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:35'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:04:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	prev := nil.
	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:35'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:36'!
previous

	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:36'!
previous: unNumeroDePeano

	previous _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:01:36'!
siUno: unClosure! !


!classDefinition: #IIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta Actividad'!
IIII class
	instanceVariableNames: 'prev next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:37'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:37'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:37'!
- unNumeroDePeano

	unNumeroDePeano siUno: [^self previous].	

	^self previous - unNumeroDePeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:37'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:38'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^self previous < unNumeroDePeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:04:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	prev := nil.
	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:38'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:38'!
previous

	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:38'!
previous: unNumeroDePeano

	previous _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 16:02:38'!
siUno: unClosure! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!