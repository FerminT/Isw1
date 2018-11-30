!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/26/2018 19:53:17'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/26/2018 19:53:23'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ft 11/26/2018 19:53:32'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreTest category: #TusLibros!
TestCase subclass: #StoreTest
	instanceVariableNames: 'testObjectsFactory itemSoldByTheStore anotherItemSoldByTheStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:04:59'!
test01CartIsNotCreatedForInvalidClient

	| store |
	
	store := testObjectsFactory createStore.
	
	self
		should: [store
					createCartForClient: testObjectsFactory invalidClient
					withPassword: testObjectsFactory invalidPassword]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidClientErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:05:12'!
test02CartIsCreatedCorrectlyForValidClientAndValidPassword
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: storeRestInterface.
	
	self assert: (storeRestInterface listCart: cartID) isEmpty
	! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:15:32'!
test03CanAddItemToCart
	
	| storeRestInterface cartID items |
	
	storeRestInterface := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: storeRestInterface.
	storeRestInterface addToCart: cartID item: itemSoldByTheStore amount: 1.
	items := storeRestInterface listCart: cartID.
	
	self assert: (items includesKey: itemSoldByTheStore).
	self assert: (items at: itemSoldByTheStore) equals: 1.
	! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:15:47'!
test04DifferentItemsOnCartAreListedCorrectly
	
	| storeRestInterface cartID items |
	
	storeRestInterface := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: storeRestInterface.
	
	storeRestInterface addToCart: cartID item: itemSoldByTheStore amount: 1.
	storeRestInterface addToCart: cartID item: anotherItemSoldByTheStore amount: 2.
	items := storeRestInterface listCart: cartID.
	
	self assert: (items includesKey: itemSoldByTheStore).
	self assert: (items at: itemSoldByTheStore) equals: 1.
	self assert: (items includesKey: anotherItemSoldByTheStore).
	self assert: (items at: anotherItemSoldByTheStore) equals: 2.
! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/26/2018 19:57:31'!
test05ItemNotInStoreCanNotBeAddedToCart
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: storeRestInterface.
	
	self 
		should: [storeRestInterface addToCart: cartID item: testObjectsFactory itemNotSellByTheStore amount: 1]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidItemErrorMessage.
			self assert: (storeRestInterface listCart: cartID) isEmpty]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:16:07'!
test06CanNotAddInvalidQuantityOfItemToCart
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: storeRestInterface.
	
	self 
		should: [storeRestInterface addToCart: cartID item: itemSoldByTheStore amount: -1]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidQuantityErrorMessage.
			self assert: (storeRestInterface listCart: cartID) isEmpty]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/30/2018 10:17:01'!
test07CanNotCheckoutToExpiredCreditCard
	
	| store cartID |
	
	store := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: store.
	store addToCart: cartID item: itemSoldByTheStore amount: 1.
	
	self 
		should: [store 
					checkoutCart: cartID 
					withCreditCardNumber: 1234567890123456 
					expiringOn: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber - 1)
					ownedBy: 'Diego Maradona']
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (store listPurchasesForClient: testObjectsFactory validClient withPassword: testObjectsFactory validPassword) total equals: 0.
			self deny: (store listCart: cartID) isEmpty]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:16:49'!
test08CartCheckoutRegistersSaleForClient
	
	| store cartID itemsSold |
	
	store := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: store.
	store addToCart: cartID item: itemSoldByTheStore amount: 1.
	
	testObjectsFactory checkout: cartID for: store.
	
	itemsSold := store listPurchasesForClient: testObjectsFactory validClient withPassword: testObjectsFactory validPassword.	
	
	self assert: (itemsSold includes: itemSoldByTheStore).
	self assert: (itemsSold occurrencesOf: itemSoldByTheStore) equals: 1.
	self assert: itemsSold total equals: 10.
	
	self should: [ store listCart: cartID ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidCartErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:17:29'!
test09DifferentPurchasesFromSameClientAreRegistered
	
	| store cartID itemsSold |
	
	store := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: store.
	store addToCart: cartID item: itemSoldByTheStore amount: 1.
	
	testObjectsFactory checkout: cartID for: store.
	
	cartID := testObjectsFactory createCartForStore: store.
	store addToCart: cartID item: anotherItemSoldByTheStore amount: 2.
	store addToCart: cartID item: itemSoldByTheStore amount: 1.
	
	testObjectsFactory checkout: cartID for: store.		
		
	itemsSold := store listPurchasesForClient: testObjectsFactory validClient withPassword: testObjectsFactory validPassword.	
	
	self assert: (itemsSold includes: itemSoldByTheStore).
	self assert: (itemsSold includes: anotherItemSoldByTheStore).
	self assert: (itemsSold occurrencesOf: itemSoldByTheStore) equals: 2.
	self assert: (itemsSold occurrencesOf: anotherItemSoldByTheStore) equals: 2.
	self assert: itemsSold total equals: 60.! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:17:49'!
test10CanNotAddItemToNotCreatedCart
	
	| storeRestInterface  |
	
	storeRestInterface := testObjectsFactory createStore.
	
	self should: [ storeRestInterface addToCart: testObjectsFactory invalidCartID item: itemSoldByTheStore amount: 1]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidCartErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 12:55:48'!
test11CanNotListNotCreatedCart
	
	| storeRestInterface  |
	
	storeRestInterface := testObjectsFactory createStore.
	
	self should: [ storeRestInterface listCart: testObjectsFactory invalidCartID]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidCartErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:11:39'!
test12CanNotCheckoutNotCreatedCart
	
	| store |
	
	store := testObjectsFactory createStore.
	
	self 
		should: [testObjectsFactory checkout: testObjectsFactory invalidCartID for: store]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidCartErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:11:59'!
test13CanNotCheckoutEmptyCart
	
	| store cartID |
	
	store := testObjectsFactory createStore.
	cartID := testObjectsFactory createCartForStore: store.
	
	self should: [ testObjectsFactory checkout: cartID for: store ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store canNotCheckoutAnEmptyCartErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:03:43'!
test14CanNotListPurchasesOfInvalidCustomer

	| store |
	
	store := testObjectsFactory createStore.
	
	self should: [ store listPurchasesForClient: testObjectsFactory invalidClient withPassword: testObjectsFactory invalidPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidClientErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:04:33'!
test15CanNotListPurchasesOfValidCustomerWithInvalidPassword

	| store |
	
	store := testObjectsFactory createStore.
	
	self should: [ store listPurchasesForClient: testObjectsFactory validClient withPassword: testObjectsFactory invalidPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidClientErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:05:32'!
test16CanNotCreateCartForValidCustomerWithInvalidPassword

	| store |
	
	store := testObjectsFactory createStore.
	
	self
		should: [store
					createCartForClient: testObjectsFactory validClient
					withPassword: testObjectsFactory invalidPassword]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidClientErrorMessage]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:18:05'!
test17CanNotAddItemToExpiredCart

	| store cartID clock |
	
	clock := ManualClock new.
	store := testObjectsFactory createStoreWithClock: clock.
	cartID := testObjectsFactory createCartForStore: store.
	
	clock setTime: 31*minute.
		
	self 
		should: [store addToCart: cartID item: itemSoldByTheStore amount: 1]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store expiredCartErrorMessage.
			clock setTime: 0*minute.
			self assert: (store listCart: cartID) isEmpty]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:18:16'!
test18CanNotCheckoutExpiredCart

	| store cartID clock |
	
	clock := ManualClock new.
	store := testObjectsFactory createStoreWithClock: clock.
	cartID := testObjectsFactory createCartForStore: store.
	store addToCart: cartID item: itemSoldByTheStore amount: 1.
	
	clock setTime: 31*minute.
		
	self 
		should: [ testObjectsFactory checkout: cartID for: store ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store expiredCartErrorMessage.
			clock setTime: 0*minute.
			self assert: ((store listCart: cartID) at: itemSoldByTheStore) equals: 1]! !

!StoreTest methodsFor: 'testing' stamp: 'ft 11/29/2018 13:18:25'!
test19CanNotListItemsOfExpiredCart

	| store cartID clock |
	
	clock := ManualClock new.
	store := testObjectsFactory createStoreWithClock: clock.
	cartID := testObjectsFactory createCartForStore: store.
	store addToCart: cartID item: itemSoldByTheStore amount: 1.
	
	clock setTime: 31*minute.
		
	self 
		should: [store listCart: cartID]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store expiredCartErrorMessage]! !


!StoreTest methodsFor: 'setup' stamp: 'ft 11/29/2018 13:15:03'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	itemSoldByTheStore := testObjectsFactory itemSellByTheStore.
	anotherItemSoldByTheStore := testObjectsFactory anotherItemSellByTheStore! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'ft 11/26/2018 19:55:08'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'ft 11/26/2018 19:56:47'!
assertIsValidQuantity: aQuantity

	(aQuantity strictlyPositive) ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'ft 11/25/2018 17:44:50'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Dictionary new.! !


!Cart methodsFor: 'queries' stamp: 'ft 11/25/2018 17:59:54'!
occurrencesOf: anItem

	^ items at: anItem ifAbsent: [^0]! !


!Cart methodsFor: 'testing' stamp: 'ft 11/25/2018 17:46:20'!
includes: anItem

	^items includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'ft 11/25/2018 17:52:59'!
total

	^ items keys sum: [ :anItem | (catalog at: anItem) * (items at: anItem)]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'ft 11/25/2018 17:55:35'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items at: anItem 
		ifPresent: [ :currentAmount | items at: anItem put: (currentAmount + aQuantity)]
		ifAbsent: [items at: anItem put: aQuantity]! !


!Cart methodsFor: 'enumerating' stamp: 'ft 11/25/2018 18:05:44'!
itemsDo: aBlock

	items keysDo: aBlock! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'ft 11/26/2018 19:52:50'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'ft 11/26/2018 19:52:59'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'cart owner time clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'ft 11/29/2018 11:54:18'!
initializeFor: aCart ownedBy: aClientID withClock: aClock

	cart := aCart.
	owner := aClientID.
	clock := aClock.
	time := clock time.! !


!CartSession methodsFor: 'operations' stamp: 'ft 11/29/2018 12:07:09'!
executeIfNotExpired: aBlock

	self assertCartHasNotExpired.
	
	aBlock value: cart.
	
	self updateCurrentTime.! !


!CartSession methodsFor: 'assertions' stamp: 'ft 11/29/2018 12:08:29'!
assertCartHasNotExpired

	clock time > (time + 30*minute) ifTrue: [^self error: self class expiredCartErrorMessage]! !


!CartSession methodsFor: 'operations - private' stamp: 'ft 11/29/2018 12:09:38'!
updateCurrentTime

	time := clock time! !


!CartSession methodsFor: 'accessing' stamp: 'ft 11/29/2018 12:26:42'!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'class initialization' stamp: 'ft 11/29/2018 11:53:50'!
for: aCart ownedBy: aClientID withClock: aClock

	^self new initializeFor: aCart ownedBy: aClientID withClock: aClock! !


!CartSession class methodsFor: 'error messages' stamp: 'ft 11/29/2018 12:08:51'!
expiredCartErrorMessage

	^'The cart session has expired'! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ft 11/29/2018 11:37:34'!
createSale

	| items |

	items := Dictionary new.
	cart itemsDo: [ :anItem | items at: anItem put: (cart occurrencesOf: anItem)].
	
	^ Sale of: items value: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration name number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'ft 11/25/2018 19:30:46'!
initializeFor: aName withNumber: aNumber expiringOn: aMonth

	name := aName.
	number := aNumber.
	expiration := aMonth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ft 11/25/2018 19:36:07'!
for: aName withNumber: aNumber expiringOn: aMonth 
	
	^self new initializeFor: aName withNumber: aNumber expiringOn: aMonth! !


!classDefinition: #ManualClock category: #TusLibros!
Object subclass: #ManualClock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'time' stamp: 'ft 11/29/2018 10:53:33'!
setTime: aUnitOfTime

	time := aUnitOfTime! !

!ManualClock methodsFor: 'time' stamp: 'ft 11/29/2018 10:53:59'!
time

	^ time! !


!ManualClock methodsFor: 'initialization' stamp: 'ft 11/29/2018 11:12:36'!
initialize

	time := 0*minute! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'ft 11/29/2018 11:35:48'!
initializeOf: aListOfItems value: aValue

	items := aListOfItems.
	total := aValue.! !


!Sale methodsFor: 'items' stamp: 'ft 11/29/2018 11:39:26'!
includes: anItem

	^ items includesKey: anItem! !

!Sale methodsFor: 'items' stamp: 'ft 11/29/2018 11:39:17'!
itemsDo: aBlock

	items keysDo: aBlock! !

!Sale methodsFor: 'items' stamp: 'ft 11/29/2018 11:46:57'!
occurrencesOf: anItem

	^ items at: anItem ifAbsent: [^0]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'ft 11/29/2018 11:35:04'!
of: aListOfItems value: aValue

	^self new initializeOf: aListOfItems value: aValue! !


!classDefinition: #Store category: #TusLibros!
Object subclass: #Store
	instanceVariableNames: 'lastID validClients cartsSessions clientsSales catalog merchantProcessor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!Store commentStamp: '<historical>' prior: 0!
ManualClock para la implementacion del clock.
Implementar reverseTime para que, luego de haber probado addToCart sobre un carrito que expiró, ver que efectivamente no agregó nada.
Hacer que todas las fechas sean relativas al reloj del Store (!!!!!!)
withCartSession: aCartSession do: aBlock -> el mensaje se forwardea a la cartSession (addToCart, etc.). Ver que no expiró la sesión dentro de ese mensaje.!


!Store methodsFor: 'operations' stamp: 'ft 11/29/2018 12:50:14'!
addToCart: aCartID item: anItem amount: anAmount
	
	self assertIsValidCart: aCartID.
	
	(cartsSessions at: aCartID) executeIfNotExpired: [ :aCart | aCart add: anAmount of: anItem ]! !

!Store methodsFor: 'operations' stamp: 'ft 11/30/2018 10:13:59'!
checkoutCart: aCartID withCreditCardNumber: aCreditCardNumber expiringOn: anExpirationDate ownedBy: aName

	| creditCard cartSession salesBook |
	
	self assertIsValidCart: aCartID.
	
	cartSession := cartsSessions at: aCartID.
	salesBook := self retrieveSalesMadeTo: cartSession owner.
	
	cartSession executeIfNotExpired: [ :aCart |
						creditCard := CreditCard for: aName withNumber: aCreditCardNumber expiringOn: anExpirationDate.
	
						(Cashier toCheckout: aCart
									charging: creditCard
									throught: merchantProcessor
									on: DateAndTime now
									registeringOn: salesBook) checkOut].
	
	self removeSession: aCartID.! !

!Store methodsFor: 'operations' stamp: 'ft 11/29/2018 11:57:22'!
createCartForClient: aClientID withPassword: aPassword 

	self assertIsValidClient: aClientID withPassword: aPassword.
	
	^ self createNewCartFor: aClientID.! !

!Store methodsFor: 'operations' stamp: 'ft 11/29/2018 12:29:55'!
listCart: aCartID

	| items |
	
	self assertIsValidCart: aCartID.

	items := Dictionary new.
		
	(cartsSessions at: aCartID) executeIfNotExpired: [ :aCart | aCart itemsDo: [ :anItem | items at: anItem put: (aCart occurrencesOf: anItem)]].
	
	^ items! !

!Store methodsFor: 'operations' stamp: 'ft 11/29/2018 11:47:29'!
listPurchasesForClient: aClientID withPassword: aPassword

	| sales soldItems total |
	
	self assertIsValidClient: aClientID withPassword: aPassword.
	
	soldItems := Dictionary new.
	total := 0.
	sales := clientsSales at: aClientID ifAbsent: [^OrderedCollection new].
	sales do: [ :aSale |
					 total := total + aSale total.
					 aSale itemsDo: [ :anItem | soldItems at: anItem 
														ifPresent: [ :amount | soldItems at: anItem put: (amount + (aSale occurrencesOf: anItem))] 
														ifAbsent: [soldItems at: anItem put: (aSale occurrencesOf: anItem)]]].
	
	^Sale of: soldItems value: total! !


!Store methodsFor: 'initialization' stamp: 'ft 11/29/2018 12:33:43'!
initializeWithClients: aListOfClients withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withClock: aClock

	validClients := aListOfClients.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	clientsSales := Dictionary new.
	cartsSessions := Dictionary new.
	lastID := 0.
	clock := aClock! !


!Store methodsFor: 'assertions' stamp: 'ft 11/29/2018 12:28:47'!
assertIsValidCart: aCartID

	(cartsSessions includesKey: aCartID) ifFalse: [^self error: self class invalidCartErrorMessage]! !

!Store methodsFor: 'assertions' stamp: 'ft 11/26/2018 17:32:18'!
assertIsValidClient: aClientID withPassword: aPassword

	((validClients includesKey: aClientID) and: [(validClients at: aClientID) = aPassword]) ifFalse: [^self error: self class invalidClientErrorMessage]! !


!Store methodsFor: 'operations - private' stamp: 'ft 11/29/2018 13:01:25'!
createNewCartFor: aClientID

	lastID := lastID + 1.	
	cartsSessions at: lastID put: (CartSession for: (Cart acceptingItemsOf: catalog) ownedBy: aClientID withClock: clock).
	
	^ lastID! !

!Store methodsFor: 'operations - private' stamp: 'ft 11/29/2018 13:28:00'!
removeSession: aCartID

	cartsSessions removeKey: aCartID! !

!Store methodsFor: 'operations - private' stamp: 'ft 11/30/2018 10:15:22'!
retrieveSalesMadeTo: aClientID

	(clientsSales includesKey: aClientID) ifFalse: [clientsSales at: aClientID put: OrderedCollection new].
	
	^ clientsSales at: aClientID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #TusLibros!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'error messages' stamp: 'ft 11/29/2018 12:17:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage! !

!Store class methodsFor: 'error messages' stamp: 'ft 11/29/2018 12:59:35'!
canNotCheckoutAnEmptyCartErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage! !

!Store class methodsFor: 'error messages' stamp: 'ft 11/29/2018 12:09:03'!
expiredCartErrorMessage

	^CartSession expiredCartErrorMessage ! !

!Store class methodsFor: 'error messages' stamp: 'ft 11/26/2018 18:59:56'!
invalidCartErrorMessage

	^'The cart required is not valid'! !

!Store class methodsFor: 'error messages' stamp: 'ft 11/25/2018 16:17:10'!
invalidClientErrorMessage

	^'The client ID or password is invalid'! !

!Store class methodsFor: 'error messages' stamp: 'ft 11/26/2018 19:58:25'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage! !

!Store class methodsFor: 'error messages' stamp: 'ft 11/26/2018 19:58:37'!
invalidQuantityErrorMessage

	^Cart invalidQuantityErrorMessage! !


!Store class methodsFor: 'class initialization' stamp: 'ft 11/29/2018 10:48:17'!
withClients: aListOfClients withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withClock: aClock

	^ self new initializeWithClients: aListOfClients withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withClock: aClock! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today debitBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ft 11/25/2018 18:29:09'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ft 11/25/2018 18:29:17'!
anotherItemSellByTheStorePrice
	
	^ 20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ft 11/29/2018 09:37:19'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ft 11/29/2018 09:37:11'!
itemSellByTheStorePrice
	
	^ 10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ft 11/25/2018 18:29:48'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ft 11/29/2018 12:51:32'!
invalidCartID

	^nil! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ft 11/25/2018 20:07:34'!
expiredCreditCard
	
	^CreditCard for: 'Diego Maradona' withNumber: 1234567890123456 expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ft 11/25/2018 20:07:46'!
notExpiredCreditCard
	
	^CreditCard for: 'Diego Maradona' withNumber: 1234567890123455 expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'ft 11/26/2018 17:45:45'!
initialize

	today := DateAndTime now.
	debitBehaviour := [ :anAmount :aCreditCard | ]! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'store' stamp: 'ft 11/29/2018 13:19:31'!
checkout: aCartID for: aStore

	aStore
		checkoutCart: aCartID 
		withCreditCardNumber: 1234567890123456 
		expiringOn: (Month month: self today monthIndex year: self today yearNumber + 1)
		ownedBy: 'Diego Maradona'! !

!StoreTestObjectsFactory methodsFor: 'store' stamp: 'ft 11/26/2018 17:40:47'!
createCartForStore: aStore

	^aStore createCartForClient: self validClient withPassword: self validPassword! !

!StoreTestObjectsFactory methodsFor: 'store' stamp: 'ft 11/29/2018 10:47:06'!
createStore

	^Store withClients: self defaultClients withCatalog: self defaultCatalog withMerchantProcessor: self defaultMerchantProcessor withClock: self defaultClock! !

!StoreTestObjectsFactory methodsFor: 'store' stamp: 'ft 11/29/2018 10:49:51'!
createStoreWithClock: aClock

	^Store withClients: self defaultClients withCatalog: self defaultCatalog withMerchantProcessor: self defaultMerchantProcessor withClock: aClock! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'ft 11/25/2018 16:37:58'!
defaultClients

	^Dictionary new
		at: self validClient put: self validPassword;
		yourself! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'ft 11/25/2018 16:02:46'!
invalidClient

	^-1! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'ft 11/25/2018 16:26:24'!
invalidPassword

	^'anInvalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'ft 11/25/2018 16:26:05'!
validClient

	^1! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'ft 11/25/2018 16:26:28'!
validPassword

	^'aValidPassword'! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'ft 11/26/2018 17:45:13'!
debit: anAmount from: aCreditCard

	^debitBehaviour value: anAmount value: aCreditCard! !

!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'ft 11/26/2018 17:43:26'!
defaultMerchantProcessor

	^self! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'ft 11/29/2018 10:47:23'!
defaultClock

	^ManualClock new! !
