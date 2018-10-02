'From Cuis 5.0 of 7 November 2016 [latest update: #3446] on 1 October 2018 at 9:00:49 pm'!
!classDefinition: #Queue category: #'Queue-Exercise'!
Object subclass: #Queue
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!Queue methodsFor: 'as yet unclassified' stamp: 'lto 10/1/2018 20:48:12'!
dequeue
	contents isEmpty ifTrue: [^ self error: self class queueEmptyErrorDescription].
	^ contents removeFirst ! !

!Queue methodsFor: 'as yet unclassified' stamp: 'lto 10/1/2018 20:37:29'!
enqueue: anObject 
	contents addLast: anObject.! !

!Queue methodsFor: 'as yet unclassified' stamp: 'lto 10/1/2018 20:59:35'!
initialize
	contents _ OrderedCollection new.! !

!Queue methodsFor: 'as yet unclassified' stamp: 'lto 10/1/2018 20:17:20'!
isEmpty
	^ contents size = 0.! !

!Queue methodsFor: 'as yet unclassified' stamp: 'lto 10/1/2018 20:49:38'!
next
	contents isEmpty ifTrue: [^ self error: self class queueEmptyErrorDescription].
	^ contents at: 1! !

!Queue methodsFor: 'as yet unclassified' stamp: 'lto 10/1/2018 20:43:31'!
size
	^ contents size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !

