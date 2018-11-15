!classDefinition: #CartTest category: #Iteracion2!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!
!CartTest commentStamp: '<historical>' prior: 0!
- Hacer que catalogo sea la lista de precios
- Cuando el cashier hace checkout, le dice al carrito sumalizate y te devuelve el total
- Hacer la parte de tarjeta de credito de alguna manera
-- Armar clase de interfaz que haga implementaciones simples de todo para responder. !


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

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 18:51:14'!
test09CashierCantCheckoutEmptyCar

	| cart cashier priceList |
	
	cart := self createCart.
	priceList := Dictionary new.
	cashier _ Cashier withPriceList: priceList.
	
	self
		should: [cashier checkout: cart]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage. ]! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test10CashierCheckoutWithOneItem

	| cart cashier |
	
	cart _ self createCart.
	cashier _ self createCashier.
	
	cart add: self itemSoldByTheStore.
	
	self assert: (cashier checkout: cart) equals: 10.
	! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:34:28'!
test11CashierCheckoutWithTwoDifferentItems

	| cart cashier |
	
	cart _ self createCart.
	cashier _ self createCashier.
	
	cart add: self itemSoldByTheStore.
	cart add: (self defaultCatalog at: 2).
	
	self assert: (cashier checkout: cart) equals: 13.
	! !

!CartTest methodsFor: 'tests' stamp: 'LTO 11/15/2018 19:37:27'!
test12CashierCantCheckoutAnItemWithoutPrice

	| cart cashier |
	cart _ Cart acceptingItemsOf: (Array with: self itemNotSoldByTheStore).
	cashier _ self createCashier.
	
	cart add: self itemNotSoldByTheStore.
	
	self
		should: [cashier checkout: cart]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier itemWithoutPriceErrorMessage. ]
	! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'LTO 11/15/2018 18:59:43'!
createCashier
	
	^Cashier withPriceList: self defaultPriceList! !

!CartTest methodsFor: 'support' stamp: 'LTO 11/15/2018 19:34:28'!
defaultCatalog
	
	^ Array with: self itemSoldByTheStore with: self moreItemsSoldByTheStore! !

!CartTest methodsFor: 'support' stamp: 'LTO 11/15/2018 19:34:28'!
defaultPriceList
	| priceList |
	priceList _ Dictionary new.
	self defaultCatalog do: [:anItem | priceList add: (Association key: anItem value: 3)].
	priceList add: (Association key:self itemSoldByTheStore value: 10).
	^ priceList
! !

!CartTest methodsFor: 'support' stamp: 'LTO 11/15/2018 19:34:49'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'LTO 11/15/2018 19:34:28'!
itemSoldByTheStore
	
	^ '1234567'! !

!CartTest methodsFor: 'support' stamp: 'LTO 11/15/2018 19:01:40'!
moreItemsSoldByTheStore
	
	^ #('1235', '568')! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Iteracion2'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'LTO 11/15/2018 19:43:20'!
assertAllItemsInPriceList: aCart
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'LTO 11/15/2018 19:40:42'!
checkout: aCart
	| receipt lastItem|
	aCart isEmpty ifTrue: [ ^ self error: self class emptyCartErrorMessage ].
	self assertAllItemsInPriceList: aCart.
	receipt _ 0.
	
	1 to: aCart amountOfItems do: [ :item | 
		lastItem _ aCart removeAnItem.
		receipt _ receipt + (priceList at: lastItem)
	].
	^ receipt! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'LTO 11/15/2018 18:49:50'!
initializeWithPrices: aPriceList
	priceList _ aPriceList ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #Iteracion2!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LTO 11/15/2018 18:48:28'!
emptyCartErrorMessage
	^ 'Cannot checkout empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LTO 11/15/2018 19:38:07'!
itemWithoutPriceErrorMessage
	^ 'Cart contains an item thats not in the price list'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LTO 11/15/2018 18:49:24'!
withPriceList: aPriceList
	^ self new initializeWithPrices: aPriceList ! !
