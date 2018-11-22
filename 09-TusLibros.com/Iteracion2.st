!classDefinition: #CartTest category: #Iteracion2!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!
!CartTest commentStamp: '<historical>' prior: 0!
- Hacer que catalogo sea la lista de precios (LISTO)
- Cuando el cashier hace checkout, le dice al carrito sumalizate y te devuelve el total (LISTO)
-- Cashier tiene un registro de ventas
- Hacer la parte de tarjeta de credito de alguna manera (LISTO)
-- Armar clase de interfaz que haga implementaciones simples de todo para responder. 
	--- Al hacerlo, asegurar que, por ejemplo, en el test con la tarjeta expirada NO se habló con el merchant processor (pensar cómo)!


!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:49'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:49'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSoldByTheStore.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/21/2018 20:59:14'!
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
			self assert: merchantProcessor totalRequests equals: 0]! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/21/2018 21:00:02'!
test10CashierCanCheckoutCartWithOneItem

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	cashier _ self createCashierWith: merchantProcessor.
	creditCard _ self createCreditCard.
	
	cart add: self itemSoldByTheStore.
	
	self assert: (cashier checkout: cart with: creditCard) equals: 10.
	self assert: cashier totalSales equals: 10.
	self assert: merchantProcessor totalRequests equals: 1! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/21/2018 21:00:15'!
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
	self assert: merchantProcessor totalRequests equals: 1! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/21/2018 21:00:29'!
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
			self assert: merchantProcessor totalRequests equals: 0]
	! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/21/2018 21:00:38'!
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
	self assert: merchantProcessor totalRequests equals: 2! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/22/2018 09:33:38'!
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
			self assert: merchantProcessor totalRequests equals: 0]! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/21/2018 21:00:50'!
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
			self assert: merchantProcessor totalRequests equals: 0]! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/22/2018 09:35:04'!
test16CanNotCreateCreditCardWithInvalidNumber

	self
		should: [CreditCard name: 'Humberto Velez' number: 123456789 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CreditCard wrongAmountOfDigitsErrorMessage = anError messageText]! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/22/2018 09:35:46'!
test17CanNotCreateCreditCardWithEmptyName

	self
		should: [CreditCard name: '' number: 1234567890123456 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: CreditCard invalidNameErrorMessage = anError messageText]! !


!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 16:52:40'!
anotherItemSoldByTheStore
	
	^ '12345'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 15:57:11'!
createCashierWith: aMerchantProcessor
	
	^Cashier with: aMerchantProcessor! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 22:19:04'!
createCreditCard
	
	^CreditCard name: 'Diego Maradona' number: 1234567890123456 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 22:19:16'!
createCreditCardWithLongName
	
	^CreditCard name: 'Humberto Ottovordemgentschenfelde' number: 1234567890123454 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 22:19:25'!
createExpiredCreditCard
	
	^CreditCard name: 'Diego Maradona' number: 1234567890123455 expirationDate: (GregorianMonthOfYear yearNumber: 2017 monthNumber: 11)! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 15:57:50'!
createMerchantProcessor
	
	^MerchantProcessorMock with: self defaultCreditCards! !

!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 17:26:58'!
defaultCatalog
	
	^Dictionary newFromPairs: (Array with: self itemSoldByTheStore with: 10 with: self anotherItemSoldByTheStore with: 3)! !

!CartTest methodsFor: 'support' stamp: 'ft 11/22/2018 09:39:38'!
defaultCreditCards
	
	^Array with: self createCreditCard with: self createExpiredCreditCard! !

!CartTest methodsFor: 'support' stamp: 'LTO 11/15/2018 19:34:49'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 16:30:36'!
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
	instanceVariableNames: 'salesRegister merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!Cashier methodsFor: 'operations' stamp: 'LTO 11/21/2018 20:57:31'!
checkout: aCart with: aCreditCard

	| total |

	aCart isEmpty ifTrue: [ ^ self error: self class emptyCartErrorMessage ].
	(aCreditCard hasExpired: GregorianMonthOfYear current) ifTrue: [ ^self error: self class expiredCreditCardErrorMessage].
		
	total := aCart totalPrice.
	
	merchantProcessor debit: total from: aCreditCard.
	
	self addSale: aCreditCard value: total.
	
	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'ft 11/18/2018 17:02:58'!
initialize

	salesRegister := Dictionary new! !

!Cashier methodsFor: 'initialization' stamp: 'LTO 11/21/2018 20:57:37'!
initializeWith: aMerchantProcessor

	salesRegister := Dictionary new.
	merchantProcessor := aMerchantProcessor! !


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

!CreditCard class methodsFor: 'class initialization' stamp: 'ft 11/22/2018 09:38:27'!
name: aName number: aNumber expirationDate: aMonthOfYear

	self assertValidNumber: aNumber.
	self assertValidName: aName.
	
	^self new initializeName: aName number: aNumber expirationDate: aMonthOfYear! !


!CreditCard class methodsFor: 'error messages' stamp: 'ft 11/22/2018 09:36:23'!
invalidNameErrorMessage

	^'The name can not be empty'! !

!CreditCard class methodsFor: 'error messages' stamp: 'ft 11/18/2018 17:24:37'!
wrongAmountOfDigitsErrorMessage

	^'There must be 16 digits for a credit card number to be valid'! !


!CreditCard class methodsFor: 'assertions' stamp: 'ft 11/22/2018 09:38:08'!
assertValidName: aName

	aName isEmpty ifTrue: [^self error: self invalidNameErrorMessage].
! !

!CreditCard class methodsFor: 'assertions' stamp: 'ft 11/22/2018 09:37:55'!
assertValidNumber: aNumber

	aNumber printString size ~= 16 ifTrue: [^self error: self wrongAmountOfDigitsErrorMessage]! !


!classDefinition: #MerchantProcessorInterface category: #Iteracion2!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: 'creditCardsDatabase mpRequestsCount'
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


!MerchantProcessorMock methodsFor: 'operations' stamp: 'ft 11/22/2018 09:42:34'!
debit: anAmount from: aCreditCard

	self assertValidName: aCreditCard name.
	self assertCreditCardIsInDatabase: aCreditCard.

	mpRequestsCount := mpRequestsCount + 1! !

!MerchantProcessorMock methodsFor: 'operations' stamp: 'LTO 11/21/2018 20:59:37'!
totalRequests

	^ mpRequestsCount! !


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
