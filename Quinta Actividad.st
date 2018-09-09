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

!I class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:46'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self].
	
	^self! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:16'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [^I].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 14:30:47'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^(self prev) < (unNumeroDePeano prev)! !

!II class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:09:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
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


!classDefinition: #III category: #'Quinta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta Actividad'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:55'!
* unNumeroDePeano

	^self prev * unNumeroDePeano + unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:55'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:55'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:23'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [^I].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:55'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^(self prev) < (unNumeroDePeano prev)! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:09:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:56'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:56'!
prev

	^prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:00:56'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !


!classDefinition: #IIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta Actividad'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
* unNumeroDePeano

	^self prev * unNumeroDePeano + unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:29'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [^I].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^(self prev) < (unNumeroDePeano prev)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:09:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
prev

	^prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !


!classDefinition: #IIIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Quinta Actividad'!
IIIII class
	instanceVariableNames: 'next prev'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
* unNumeroDePeano

	^self prev * unNumeroDePeano + unNumeroDePeano! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:35'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [^I].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^(self prev) < (unNumeroDePeano prev)! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:09:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	prev := IIII.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
prev

	^prev! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !


!classDefinition: #IIIIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #'Quinta Actividad'!
IIIIII class
	instanceVariableNames: 'next prev'!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
* unNumeroDePeano

	^self prev * unNumeroDePeano + unNumeroDePeano! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:41'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [^I].
	self = unNumeroDePeano ifTrue: [^I].
	
	^((self - unNumeroDePeano) / unNumeroDePeano) next! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	
	^(self prev) < (unNumeroDePeano prev)! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:09:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := IIIII.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
prev

	^prev! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ft 9/9/2018 15:01:00'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!