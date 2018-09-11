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

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 22:03:11'!
- unNumeroDePeano

	self error: 'No se puede restar un numero menor a un numero mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 09:50:29'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self].
	
	^self error: 'Divisi�n no entera'! !

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 14:29:56'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	^true! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 14:24:38'!
* unNumeroDePeano

	^self prev * unNumeroDePeano + unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:47:13'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 22:01:57'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 09:54:04'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: 'Divisi�n no entera'].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 14:30:47'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^(self prev) < (unNumeroDePeano prev)! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/11/2018 09:56:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:10'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:49:14'!
prev

	^prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:32'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

II initializeAfterFileIn!