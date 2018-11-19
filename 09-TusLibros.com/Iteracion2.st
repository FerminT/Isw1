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

!CartTest methodsFor: 'tests' stamp: 'ft 11/19/2018 15:38:28'!
test09CashierCantCheckoutEmptyCart

	| cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createCreditCard.
	
	self
		should: [cashier checkout: cart with: creditCard]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage.
			self assert: cashier totalSales equals: 0]! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/19/2018 16:10:33'!
test10CashierCanCheckoutCartWithOneItem

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	cashier _ self createCashierWith: merchantProcessor.
	creditCard _ self createCreditCard.
	
	cart add: self itemSoldByTheStore.
	
	self assert: (cashier checkout: cart with: creditCard) equals: 10.
	self assert: cashier totalSales equals: 10.! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/18/2018 17:29:29'!
test11CashierCanCheckoutCartWithTwoDifferentItemsAndReturnsItsTotal

	| cart cashier creditCard |
	
	cart _ self createCart.
	cashier _ self createCashier.
	creditCard _ self createCreditCard.
	
	cart add: self itemSoldByTheStore.
	cart add: self anotherItemSoldByTheStore.
	
	self assert: (cashier checkout: cart with: creditCard) equals: 13.
	self assert: cashier totalSales equals: 13.
	! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/18/2018 17:49:00'!
test12CashierDoesntCheckoutCartWithExpiredCreditCard

	| cart cashier creditCard |
	
	cart _ self createCart.
	cashier _ self createCashier.
	creditCard _ self createExpiredCreditCard.
	
	cart add: self itemSoldByTheStore.
	cart add: self anotherItemSoldByTheStore.
	
	self 
		should: [cashier checkout: cart with: creditCard]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Cashier expiredCreditCardErrorMessage = anError messageText.
			self assert: cashier totalSales equals: 0.]
	! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/18/2018 18:07:42'!
test13CashierRegistersDifferentSalesFromSameCreditCard

	| cart1 cart2 cashier creditCard |
	
	cart1 _ self createCart.
	cashier _ self createCashier.
	creditCard _ self createCreditCard.
	
	cart1 add: self itemSoldByTheStore.
	
	cashier checkout: cart1 with: creditCard.
	
	cart2 _ self createCart.
	cart2 add: self anotherItemSoldByTheStore.
	
	cashier checkout: cart2 with: creditCard.
	
	self assert: cashier totalSales equals: 13.! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/19/2018 16:18:01'!
test14CashierCantSellToCreditCardWithoutFunds

	| cart cashier creditCard merchantProcessor |
	
	cart _ self createCart.
	merchantProcessor _ self createMerchantProcessor.
	creditCard _ self createCreditCard.
	cashier _ self createCashierWith: merchantProcessor.
	
	cart add: 100 of: self itemSoldByTheStore.
	
	self
		should: [cashier checkout: cart with: creditCard]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: MerchantProcessorInterface creditCardWithoutEnoughFundsErrorMessage = anError messageText.
			self assert: cashier totalSales equals: 0]! !


!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 16:52:40'!
anotherItemSoldByTheStore
	
	^ '12345'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 16:55:19'!
createCashier
	
	^Cashier new! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 15:57:11'!
createCashierWith: aMerchantProcessor
	
	^Cashier with: aMerchantProcessor! !

!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 17:54:10'!
createCreditCard
	
	^CreditCard firstName: 'Diego' lastName: 'Maradona' number: 1234567890123456 expirationDate: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 11)! !

!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 17:54:56'!
createExpiredCreditCard
	
	^CreditCard firstName: 'Diego' lastName: 'Maradona' number: 1234567890123455 expirationDate: (GregorianMonthOfYear yearNumber: 2017 monthNumber: 11)! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 15:57:50'!
createMerchantProcessor
	
	^MerchantProcessorMock with: self defaultCreditCards! !

!CartTest methodsFor: 'support' stamp: 'ft 11/18/2018 17:26:58'!
defaultCatalog
	
	^Dictionary newFromPairs: (Array with: self itemSoldByTheStore with: 10 with: self anotherItemSoldByTheStore with: 3)! !

!CartTest methodsFor: 'support' stamp: 'ft 11/19/2018 16:35:06'!
defaultCreditCards
	
	^Dictionary newFromPairs: (Array with: self createCreditCard with: 100 with: self createExpiredCreditCard with: 100)! !

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

!Cashier methodsFor: 'operations' stamp: 'ft 11/19/2018 16:07:07'!
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

!Cashier methodsFor: 'initialization' stamp: 'ft 11/19/2018 16:00:13'!
initializeWith: aMerchantProcessor

	salesRegister := Dictionary new.
	merchantProcessor := aMerchantProcessor ! !


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

!Cashier class methodsFor: 'error messages' stamp: 'ft 11/18/2018 17:06:30'!
creditCardNotRegisteredErrorMessage

	^'The requested credit card has not made any buys yet'! !

!Cashier class methodsFor: 'error messages' stamp: 'LTO 11/15/2018 18:48:28'!
emptyCartErrorMessage
	^ 'Cannot checkout empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'ft 11/18/2018 17:50:57'!
expiredCreditCardErrorMessage

	^'The supplied credit card has expired'! !

!Cashier class methodsFor: 'error messages' stamp: 'LTO 11/15/2018 19:38:07'!
itemWithoutPriceErrorMessage
	^ 'Cart contains an item thats not in the price list'! !


!Cashier class methodsFor: 'class initialization' stamp: 'ft 11/19/2018 15:59:50'!
with: aMerchantProcessor

	^self new initializeWith: aMerchantProcessor ! !


!classDefinition: #CreditCard category: #Iteracion2!
Object subclass: #CreditCard
	instanceVariableNames: 'number firstName lastName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!CreditCard methodsFor: 'initialization' stamp: 'ft 11/18/2018 17:26:07'!
initializeFirstName: aFirstName lastName: aSurname number: aNumber expirationDate: aMonthOfYear

	firstName := aFirstName.
	lastName := aSurname.
	number := aNumber.
	expirationDate := aMonthOfYear! !


!CreditCard methodsFor: 'testing' stamp: 'ft 11/18/2018 17:34:25'!
hasExpired: fromMonthOfYear

	^expirationDate < fromMonthOfYear! !


!CreditCard methodsFor: 'comparing' stamp: 'ft 11/19/2018 16:46:02'!
= anObject

	^self class = anObject class
		and: [ number = anObject number ].! !


!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 16:34:24'!
expirationDate

	^expirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 16:34:09'!
firstName

	^firstName! !

!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 16:34:16'!
lastName

	^lastName! !

!CreditCard methodsFor: 'accessing' stamp: 'ft 11/19/2018 16:34:32'!
number

	^number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #Iteracion2!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'class initialization' stamp: 'ft 11/18/2018 17:26:15'!
firstName: aName lastName: aSurname number: aNumber expirationDate: aMonthOfYear

	aNumber printString size ~= 16 ifTrue: [^self error: self wrongAmountOfDigitsErrorMessage].
	
	^self new initializeFirstName: aName lastName: aSurname number: aNumber expirationDate: aMonthOfYear! !


!CreditCard class methodsFor: 'error messages' stamp: 'ft 11/18/2018 17:24:37'!
wrongAmountOfDigitsErrorMessage

	^'There must be 16 digits for a credit card number to be valid'! !


!classDefinition: #MerchantProcessorInterface category: #Iteracion2!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: 'creditCardsDatabase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!MerchantProcessorInterface methodsFor: 'operations' stamp: 'ft 11/19/2018 16:04:08'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInterface class' category: #Iteracion2!
MerchantProcessorInterface class
	instanceVariableNames: ''!

!MerchantProcessorInterface class methodsFor: 'error messages' stamp: 'ft 11/19/2018 16:08:05'!
creditCardWithoutEnoughFundsErrorMessage

	^'The credit card doesnt have enough funds'! !


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

!MerchantProcessorMock methodsFor: 'initialization' stamp: 'ft 11/19/2018 15:50:07'!
initializeWith: aDictionaryOfCreditCards

	creditCardsDatabase := aDictionaryOfCreditCards ! !


!MerchantProcessorMock methodsFor: 'operations' stamp: 'ft 11/19/2018 16:15:28'!
debit: anAmount from: aCreditCard

	| funds |

	funds _ creditCardsDatabase at: aCreditCard.

	funds < anAmount ifTrue: [^self error: MerchantProcessorInterface creditCardWithoutEnoughFundsErrorMessage].
	
	^creditCardsDatabase at: aCreditCard put: funds - anAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorMock class' category: #Iteracion2!
MerchantProcessorMock class
	instanceVariableNames: ''!

!MerchantProcessorMock class methodsFor: 'class initialization' stamp: 'ft 11/19/2018 15:49:39'!
with: aDictionaryOfCreditCards

	^self new initializeWith: aDictionaryOfCreditCards 

! !
