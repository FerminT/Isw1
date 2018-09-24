!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/24/2018 10:15:46'!
assertThatOn: aCustomerBook
numberOfActiveCustomersIsEqualTo: aNumberOfActiveCustomers
numberOfSuspendedCustomersIsEqualTo: aNumberOfSuspendedCustomers
numberOfCustomersIsEqualTo: aNumberOfCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/21/2018 10:50:32'!
on: aCustomerBook addAndSuspend: aName

aCustomerBook addCustomerNamed: aName.
aCustomerBook suspendCustomerNamed: aName.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/21/2018 11:59:21'!
should: aCustomerBook failToSuspend: aName andStillIncludeCustomer: customerName

[ aCustomerBook suspendCustomerNamed: aName. self fail]
	on: CantSuspend
	do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: customerName) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/20/2018 21:25:38'!
should: aBlock takeLessThanMilliseconds: maxAmount

| millisecondsBeforeRunning millisecondsAfterRunning |

millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
aBlock value.
millisecondsAfterRunning := Time millisecondClockValue * millisecond.

^self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < maxAmount! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/20/2018 21:25:50'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	^self should: [customerBook addCustomerNamed: 'John Lennon'] takeLessThanMilliseconds: 50 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/20/2018 21:25:54'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	^self should: [customerBook removeCustomerNamed: paulMcCartney] takeLessThanMilliseconds: 100 * millisecond
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/24/2018 10:18:07'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self whenFails: [customerBook addCustomerNamed: '']
		 withThisError: Error 
		 do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/24/2018 10:18:22'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
			
	self whenFails: [customerBook  removeCustomerNamed:  'Paul McCartney']
		 withThisError: NotFound
		 do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/24/2018 10:19:02'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	self on: customerBook addAndSuspend: paulMcCartney.
	
	self assertThatOn: customerBook
		numberOfActiveCustomersIsEqualTo: 0
		numberOfSuspendedCustomersIsEqualTo: 1
		numberOfCustomersIsEqualTo: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/24/2018 10:19:37'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.

	self on: customerBook addAndSuspend: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatOn: customerBook
		numberOfActiveCustomersIsEqualTo: 0
		numberOfSuspendedCustomersIsEqualTo: 0
		numberOfCustomersIsEqualTo: 0.
				
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/24/2018 10:19:47'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: customerBook failToSuspend: 'Paul McCartney' andStillIncludeCustomer: johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/24/2018 10:20:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self should: customerBook failToSuspend: johnLennon  andStillIncludeCustomer: johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ft 9/21/2018 10:32:41'!
whenFails: aBlock withThisError: anError do: anotherBlock

[ aBlock value. self fail]
	on: anError
	do: anotherBlock! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers suspended'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:28'!
includesCustomerNamed: aName

	^(customers includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:38'!
isEmpty
	
	^customers isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NicolasRinaldi 9/16/2018 21:55:33'!
initialize

	super initialize.
	customers := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'HAW 9/19/2018 08:41:11'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((customers includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:57'!
numberOfActiveCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NicolasRinaldi 9/16/2018 22:01:43'!
numberOfCustomers
	
	^customers size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ft 9/24/2018 10:16:19'!
removeCustomerNamed: aName 

	customers remove: aName ifAbsent:
	[
		suspended remove: aName ifAbsent: [^NotFound signal].
	].
	^ aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:27:55'!
suspendCustomerNamed: aName 
	
	(customers includes: aName) ifFalse: [^CantSuspend signal].
	
	customers remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
