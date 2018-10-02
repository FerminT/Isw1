!classDefinition: #QueueTest category: #'Queue-Exercise'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'CGCM 9/27/2018 16:34:58'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #Queue category: #'Queue-Exercise'!
Object subclass: #Queue
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!Queue methodsFor: 'operations' stamp: 'ft 10/2/2018 10:28:45'!
dequeue

	(SizeEvaluator sizeToEvaluate: self size) evaluate.
	^ contents removeFirst ! !

!Queue methodsFor: 'operations' stamp: 'lto 10/1/2018 20:37:29'!
enqueue: anObject 
	contents addLast: anObject.! !

!Queue methodsFor: 'operations' stamp: 'ft 10/2/2018 10:29:09'!
next

	(SizeEvaluator sizeToEvaluate: self size) evaluate.
	^ contents at: 1! !


!Queue methodsFor: 'testing' stamp: 'ft 10/2/2018 10:29:01'!
isEmpty
	^ (SizeEvaluator sizeToEvaluate: self size) isEmpty! !

!Queue methodsFor: 'testing' stamp: 'lto 10/1/2018 20:43:31'!
size
	^ contents size! !


!Queue methodsFor: 'initialization' stamp: 'lto 10/1/2018 20:59:35'!
initialize
	contents _ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !


!classDefinition: #SizeEvaluator category: #'Queue-Exercise'!
Object subclass: #SizeEvaluator
	instanceVariableNames: 'size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!SizeEvaluator methodsFor: 'initialization' stamp: 'ft 10/2/2018 10:13:25'!
initializeWith: aSizeNumber

	size _ aSizeNumber ! !


!SizeEvaluator methodsFor: 'evaluation' stamp: 'ft 10/2/2018 10:16:18'!
evaluate

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SizeEvaluator class' category: #'Queue-Exercise'!
SizeEvaluator class
	instanceVariableNames: ''!

!SizeEvaluator class methodsFor: 'instance creation' stamp: 'ft 10/2/2018 10:10:31'!
for: aSizeNumber

	^self new initializeWith: aSizeNumber! !


!SizeEvaluator class methodsFor: 'sizeEvaluator search' stamp: 'ft 10/2/2018 09:59:32'!
size: aSizeNumber

	self subclassResponsibility ! !

!SizeEvaluator class methodsFor: 'sizeEvaluator search' stamp: 'ft 10/2/2018 10:10:09'!
sizeToEvaluate: aSizeNumber

	| sizeEvaluatorClass |

	sizeEvaluatorClass _ self subclasses detect: [ :aSizeEvaluatorClass | aSizeEvaluatorClass size: aSizeNumber ].
	
	^ sizeEvaluatorClass for: aSizeNumber.! !


!classDefinition: #EmptySize category: #'Queue-Exercise'!
SizeEvaluator subclass: #EmptySize
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!EmptySize methodsFor: 'evaluation' stamp: 'ft 10/2/2018 10:17:36'!
evaluate

	^self error: Queue queueEmptyErrorDescription! !


!EmptySize methodsFor: 'testing' stamp: 'ft 10/2/2018 10:24:07'!
isEmpty

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptySize class' category: #'Queue-Exercise'!
EmptySize class
	instanceVariableNames: ''!

!EmptySize class methodsFor: 'sizeEvaluator search' stamp: 'ft 10/2/2018 10:11:26'!
size: aSizeNumber

	^aSizeNumber = 0! !


!classDefinition: #NonEmptySize category: #'Queue-Exercise'!
SizeEvaluator subclass: #NonEmptySize
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!NonEmptySize methodsFor: 'evaluation' stamp: 'ft 10/2/2018 10:18:11'!
evaluate! !


!NonEmptySize methodsFor: 'testing' stamp: 'ft 10/2/2018 10:24:24'!
isEmpty

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptySize class' category: #'Queue-Exercise'!
NonEmptySize class
	instanceVariableNames: ''!

!NonEmptySize class methodsFor: 'sizeEvaluator search' stamp: 'ft 10/2/2018 10:12:02'!
size: aSizeNumber

	^aSizeNumber > 0! !
