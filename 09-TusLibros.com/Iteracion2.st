!classDefinition: #CartAndCashierTest category: #Iteracion2!
TestCase subclass: #CartAndCashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!
!CartAndCashierTest commentStamp: '<historical>' prior: 0!
(Comment)!


!CartAndCashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:49'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:49'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSoldByTheStore.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 14:17:13'!
test09CashierCantCheckoutEmptyCart

	| cart cashier creditCard merchantProcessor |
	
	cart := self createCart.
	merchantProcessor := self createMerchantProcessor.
	cashier := self createCashierWith: merchantProcessor.
	creditCard := self createCreditCard.
	
	self
		should: [cashier checkout: cart with: creditCard]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage.
			self assert: cashier totalSales equals: 0.
			self assert: cashier totalRequestsToMerchantProcessor equals: 0]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 14:17:13'!
test10CashierCanCheckoutCartWithOneItem

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	cashier _ self createCashierWith: merchantProcessor.
	creditCard _ self createCreditCard.
	
	cart add: self itemSoldByTheStore.
	
	self assert: (cashier checkout: cart with: creditCard) equals: 10.
	self assert: cashier totalSales equals: 10.
	self assert: cashier totalRequestsToMerchantProcessor equals: 1! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 14:17:33'!
test11CashierCanCheckoutCartWithTwoDifferentItemsAndReturnsItsTotal

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	cashier _ self createCashierWith: merchantProcessor.
	creditCard _ self createCreditCard.
	
	cart add: self itemSoldByTheStore.
	cart add: self anotherItemSoldByTheStore.
	
	self assert: (cashier checkout: cart with: creditCard) equals: 13.
	self assert: cashier totalSales equals: 13.
	self assert: cashier totalRequestsToMerchantProcessor equals: 1! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 14:17:42'!
test12CashierDoesntCheckoutCartWithExpiredCreditCard

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	cashier _ self createCashierWith: merchantProcessor.
	creditCard _ self createExpiredCreditCard.
	
	cart add: self itemSoldByTheStore.
	cart add: self anotherItemSoldByTheStore.
	
	self 
		should: [cashier checkout: cart with: creditCard]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Cashier expiredCreditCardErrorMessage = anError messageText.
			self assert: cashier totalSales equals: 0.
			self assert: cashier totalRequestsToMerchantProcessor equals: 0]
	! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 14:17:52'!
test13CashierRegistersDifferentSalesFromSameCreditCard

	| cart1 cart2 cashier creditCard merchantProcessor |
	
	cart1 _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	cashier _ self createCashierWith: merchantProcessor.
	creditCard _ self createCreditCard.
	
	cart1 add: self itemSoldByTheStore.
	
	cashier checkout: cart1 with: creditCard.
	
	cart2 _ self createCart.
	cart2 add: self anotherItemSoldByTheStore.
	
	cashier checkout: cart2 with: creditCard.
	
	self assert: cashier totalSales equals: 13.
	self assert: cashier totalRequestsToMerchantProcessor equals: 2! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 14:18:11'!
test14CashierCantSellToCreditCardWithLongName

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	creditCard _ self createCreditCardWithLongName.
	cashier _ self createCashierWith: merchantProcessor.
	
	cart add: self itemSoldByTheStore.
	
	self
		should: [cashier checkout: cart with: creditCard]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: MerchantProcessorInterface creditCardNameIsTooLongErrorMessage = anError messageText.
			self assert: cashier totalSales equals: 0.
			self assert: cashier totalRequestsToMerchantProcessor equals: 1]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 14:18:23'!
test15CashierCantSellToCreditCardThatIsNotInMerchantProcessorDatabase

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	creditCard _ CreditCard name: 'Humberto Velez' number: 1234567890123452 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11).
	cashier _ self createCashierWith: merchantProcessor.
	
	cart add: self itemSoldByTheStore.
	
	self
		should: [cashier checkout: cart with: creditCard]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: MerchantProcessorInterface creditCardIsNotInTheDatabaseErrorMessage = anError messageText.
			self assert: cashier totalSales equals: 0.
			self assert: cashier totalRequestsToMerchantProcessor equals: 1]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 09:35:04'!
test16CanNotCreateCreditCardWithInvalidNumber

	self
		should: [CreditCard name: 'Humberto Velez' number: 123456789 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CreditCard wrongAmountOfDigitsErrorMessage = anError messageText]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 09:35:46'!
test17CanNotCreateCreditCardWithEmptyName

	self
		should: [CreditCard name: '' number: 1234567890123456 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CreditCard invalidNameErrorMessage = anError messageText]! !

!CartAndCashierTest methodsFor: 'tests' stamp: 'ft 11/22/2018 13:58:30'!
test18CanNotCreateCreditCardWithInvalidDate

	self
		should: [CreditCard name: 'Humberto Velez' number: 1234567890123456 expirationDate: (GregorianMonth november)]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CreditCard invalidDateErrorMessage = anError messageText]! !


!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/18/2018 16:52:40'!
anotherItemSoldByTheStore
	
	^ '12345'! !

!CartAndCashierTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/19/2018 15:57:11'!
createCashierWith: aMerchantProcessor
	
	^Cashier with: aMerchantProcessor! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/19/2018 22:19:04'!
createCreditCard
	
	^CreditCard name: 'Diego Maradona' number: 1234567890123456 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/19/2018 22:19:16'!
createCreditCardWithLongName
	
	^CreditCard name: 'Humberto Ottovordemgentschenfelde' number: 1234567890123454 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/19/2018 22:19:25'!
createExpiredCreditCard
	
	^CreditCard name: 'Diego Maradona' number: 1234567890123455 expirationDate: (GregorianMonthOfYear yearNumber: 2017 monthNumber: 11)! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/19/2018 15:57:50'!
createMerchantProcessor
	
	^MerchantProcessorMock with: self defaultCreditCards! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/18/2018 17:26:58'!
defaultCatalog
	
	^Dictionary newFromPairs: (Array with: self itemSoldByTheStore with: 10 with: self anotherItemSoldByTheStore with: 3)! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/22/2018 09:39:38'!
defaultCreditCards
	
	^Array with: self createCreditCard with: self createExpiredCreditCard! !

!CartAndCashierTest methodsFor: 'support' stamp: 'LTO 11/15/2018 19:34:49'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CartAndCashierTest methodsFor: 'support' stamp: 'ft 11/18/2018 16:30:36'!
itemSoldByTheStore
	
	^'1234567'! !


!classDefinition: #Cart category: #Iteracion2!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'ft 11/18/2018 16:33:25'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'LTO 11/15/2018 19:13:33'!
amountOfItems
	^ items size.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'ft 11/18/2018 16:40:27'!
totalPrice

	^items 
		inject: 0
		into: [ :sum :anItem | sum + (catalog at: anItem)]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'operations' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'operations' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

!Cart methodsFor: 'operations' stamp: 'LTO 11/15/2018 19:18:02'!
removeAnItem
	self isEmpty ifTrue: [^ self error: self class emptyCartErrorMessage].
	
	^ items removeFirst! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #Iteracion2!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LTO 11/15/2018 19:16:55'!
emptyCartErrorMessage
	^ 'Cannot remove item from empty cart'! !


!classDefinition: #Cashier category: #Iteracion2!
Object subclass: #Cashier
	instanceVariableNames: 'salesRegister merchantProcessor transactionsSent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!Cashier methodsFor: 'operations' stamp: 'ft 11/22/2018 14:14:13'!
checkout: aCart with: aCreditCard

	| total |

	aCart isEmpty ifTrue: [ ^ self error: self class emptyCartErrorMessage ].
	(aCreditCard hasExpired: GregorianMonthOfYear current) ifTrue: [ ^self error: self class expiredCreditCardErrorMessage].
		
	total := aCart totalPrice.
	
	self addTransactionSent: aCreditCard value: total.
	merchantProcessor debit: total from: aCreditCard.
	
	self addSale: aCreditCard value: total.
	
	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'ft 11/22/2018 14:13:43'!
initializeWith: aMerchantProcessor

	salesRegister := Dictionary new.
	merchantProcessor := aMerchantProcessor.
	transactionsSent := OrderedCollection new.! !


!Cashier methodsFor: 'accessing' stamp: 'ft 11/22/2018 14:17:12'!
totalRequestsToMerchantProcessor

	^transactionsSent size! !

!Cashier methodsFor: 'accessing' stamp: 'ft 11/18/2018 17:08:23'!
totalSales

	^salesRegister values
		inject: 0
		into: [ :total :aSale | total + aSale]! !


!Cashier methodsFor: 'operations - private' stamp: 'ft 11/18/2018 18:04:41'!
addSale: aCreditCard value: aNumber

	salesRegister at: aCreditCard 
		ifPresent: [ :value | salesRegister at: aCreditCard put: (value + aNumber)]
		ifAbsent: [ salesRegister at: aCreditCard put: aNumber].! !

!Cashier methodsFor: 'operations - private' stamp: 'ft 11/22/2018 14:14:43'!
addTransactionSent: aCreditCard value: aValue

	transactionsSent add: (Association key: aCreditCard value: aValue)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #Iteracion2!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'LTO 11/15/2018 18:48:28'!
emptyCartErrorMessage
	^ 'Cannot checkout empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'ft 11/18/2018 17:50:57'!
expiredCreditCardErrorMessage

	^'The supplied credit card has expired'! !


!Cashier class methodsFor: 'class initialization' stamp: 'ft 11/19/2018 15:59:50'!
with: aMerchantProcessor

	^self new initializeWith: aMerchantProcessor ! !


!classDefinition: #CreditCard category: #Iteracion2!
Object subclass: #CreditCard
	instanceVariableNames: 'number name expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!CreditCard methodsFor: 'initialization' stamp: 'ft 11/19/2018 22:17:49'!
initializeName: aName number: aNumber expirationDate: aMonthOfYear

	name := aName.
	number := aNumber.
	expirationDate := aMonthOfYear! !


!CreditCard methodsFor: 'testing' stamp: 'ft 11/18/2018 17:34:25'!
hasExpired: fromMonthOfYear

	^expirationDate < fromMonthOfYear! !


!CreditCard methodsFor: 'comparing' stamp: 'ft 11/19/2018 22:20:43'!
= anObject

	^self class = anObject class
		and: [number = anObject number 
		and: [name = anObject name
		and: [expirationDate = anObject expirationDate]]]! !


!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 16:34:24'!
expirationDate

	^expirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 23:35:18'!
hash

	^number hash! !

!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 22:17:22'!
name

	^name! !

!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 16:34:32'!
number

	^number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #Iteracion2!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'class initialization' stamp: 'ft 11/22/2018 14:00:05'!
name: aName number: aNumber expirationDate: aMonthOfYear

	self assertValidNumber: aNumber.
	self assertValidName: aName.
	self assertValidDate: aMonthOfYear.
	
	^self new initializeName: aName number: aNumber expirationDate: aMonthOfYear! !


!CreditCard class methodsFor: 'error messages' stamp: 'ft 11/22/2018 14:01:30'!
invalidDateErrorMessage

	^'The expiration date supplied is not valid'! !

!CreditCard class methodsFor: 'error messages' stamp: 'ft 11/22/2018 09:36:23'!
invalidNameErrorMessage

	^'The name can not be empty'! !

!CreditCard class methodsFor: 'error messages' stamp: 'ft 11/18/2018 17:24:37'!
wrongAmountOfDigitsErrorMessage

	^'There must be 16 digits for a credit card number to be valid'! !


!CreditCard class methodsFor: 'assertions' stamp: 'ft 11/22/2018 14:09:16'!
assertValidDate: aMonthOfYear

	[aMonthOfYear monthNumber > 0 and: [aMonthOfYear year number > 0]]
	on: Error
	do: [^self error: self invalidDateErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'ft 11/22/2018 09:38:08'!
assertValidName: aName

	aName isEmpty ifTrue: [^self error: self invalidNameErrorMessage].
! !

!CreditCard class methodsFor: 'assertions' stamp: 'ft 11/22/2018 09:37:55'!
assertValidNumber: aNumber

	aNumber printString size ~= 16 ifTrue: [^self error: self wrongAmountOfDigitsErrorMessage]! !


!classDefinition: #MerchantProcessorInterface category: #Iteracion2!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: 'creditCardsDatabase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!MerchantProcessorInterface methodsFor: 'operations' stamp: 'ft 11/19/2018 16:04:08'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !

!MerchantProcessorInterface methodsFor: 'operations' stamp: 'LTO 11/21/2018 20:59:37'!
totalRequests

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInterface class' category: #Iteracion2!
MerchantProcessorInterface class
	instanceVariableNames: ''!

!MerchantProcessorInterface class methodsFor: 'error messages' stamp: 'ft 11/19/2018 23:40:38'!
creditCardIsNotInTheDatabaseErrorMessage

	^'The provided credit card was not found in the database'! !

!MerchantProcessorInterface class methodsFor: 'error messages' stamp: 'ft 11/19/2018 22:16:05'!
creditCardNameIsTooLongErrorMessage

	^'The name in the credit card is too long'! !


!classDefinition: #MerchantProcessor category: #Iteracion2!
MerchantProcessorInterface subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!


!classDefinition: #MerchantProcessorMock category: #Iteracion2!
MerchantProcessorInterface subclass: #MerchantProcessorMock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!MerchantProcessorMock methodsFor: 'initialization' stamp: 'ft 11/22/2018 09:39:11'!
initializeWith: aCollectionOfCreditCards

	creditCardsDatabase := aCollectionOfCreditCards.
	mpRequestsCount := 0! !


!MerchantProcessorMock methodsFor: 'operations' stamp: 'ft 11/22/2018 14:18:48'!
debit: anAmount from: aCreditCard

	self assertValidName: aCreditCard name.
	self assertCreditCardIsInDatabase: aCreditCard.
! !


!MerchantProcessorMock methodsFor: 'assertions' stamp: 'ft 11/22/2018 09:42:04'!
assertCreditCardIsInDatabase: aCreditCard

	(creditCardsDatabase includes: aCreditCard) ifFalse: [^self error: MerchantProcessorInterface creditCardIsNotInTheDatabaseErrorMessage].! !

!MerchantProcessorMock methodsFor: 'assertions' stamp: 'ft 11/22/2018 09:41:34'!
assertValidName: aName

	aName size > 30 ifTrue: [^self error: MerchantProcessorInterface creditCardNameIsTooLongErrorMessage]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorMock class' category: #Iteracion2!
MerchantProcessorMock class
	instanceVariableNames: ''!

!MerchantProcessorMock class methodsFor: 'class initialization' stamp: 'ft 11/22/2018 09:38:55'!
with: aCollectionOfCreditCards

	^self new initializeWith: aCollectionOfCreditCards 

! !
