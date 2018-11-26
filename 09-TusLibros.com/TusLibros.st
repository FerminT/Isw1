!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
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


!classDefinition: #StoreRestInterfaceTest category: #TusLibros!
TestCase subclass: #StoreRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/25/2018 18:17:15'!
test01CartIsNotCreatedForInvalidClientAndPassword

	"RestInterface solo responde a esos 5 mensajes. No puedo acceder al modelo, por lo que solamente puedo interactuar a través de esos 5 mensajes."
	
	| storeRestInterface |
	
	storeRestInterface := testObjectsFactory createInterface.
	
	self
		should: [storeRestInterface
							createCartForClient: testObjectsFactory invalidClient
							withPassword: testObjectsFactory invalidPassword]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = StoreRestInterface invalidClientErrorMessage]! !

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/25/2018 18:17:23'!
test02CartIsCreatedCorrectlyForValidClientAndPassword
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createInterface.
	cartID := testObjectsFactory createCartForInterface: storeRestInterface.
	
	self assert: (storeRestInterface listCart: cartID) isEmpty
	! !

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/25/2018 18:32:05'!
test03CanAddItemToCart
	
	| storeRestInterface cartID items itemSoldByTheStore |
	
	storeRestInterface := testObjectsFactory createInterface.
	cartID := testObjectsFactory createCartForInterface: storeRestInterface.
	itemSoldByTheStore := testObjectsFactory itemSellByTheStore.
	
	storeRestInterface addToCart: cartID item: itemSoldByTheStore amount: 1.
	items := storeRestInterface listCart: cartID.
	
	self assert: (items includesKey: itemSoldByTheStore).
	self assert: (items at: itemSoldByTheStore) equals: 1.
	! !

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/25/2018 18:31:19'!
test04DifferentItemsOnCartAreListedCorrectly
	
	| storeRestInterface cartID items itemSoldByTheStore anotherItemSoldByTheStore |
	
	storeRestInterface := testObjectsFactory createInterface.
	cartID := testObjectsFactory createCartForInterface: storeRestInterface.
	itemSoldByTheStore := testObjectsFactory itemSellByTheStore.
	anotherItemSoldByTheStore := testObjectsFactory anotherItemSellByTheStore.
	
	storeRestInterface addToCart: cartID item: itemSoldByTheStore amount: 1.
	storeRestInterface addToCart: cartID item: anotherItemSoldByTheStore amount: 2.
	items := storeRestInterface listCart: cartID.
	
	self assert: (items includesKey: itemSoldByTheStore).
	self assert: (items at: itemSoldByTheStore) equals: 1.
	self assert: (items includesKey: anotherItemSoldByTheStore).
	self assert: (items at: anotherItemSoldByTheStore) equals: 2.
! !

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/25/2018 19:42:48'!
test05ItemNotInStoreCanNotBeAddedToCart
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createInterface.
	cartID := testObjectsFactory createCartForInterface: storeRestInterface.
	
	self 
		should: [storeRestInterface addToCart: cartID item: testObjectsFactory itemNotSellByTheStore amount: 1]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = StoreRestInterface itemNotSoldByTheStoreErrorMessage.
			self assert: (storeRestInterface listCart: cartID) isEmpty]! !

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/25/2018 19:55:17'!
test06CanNotAddInvalidQuantityOfItemToCart
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createInterface.
	cartID := testObjectsFactory createCartForInterface: storeRestInterface.
	
	self 
		should: [storeRestInterface addToCart: cartID item: testObjectsFactory itemSellByTheStore amount: -1]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = StoreRestInterface invalidQuantityErrorMessage.
			self assert: (storeRestInterface listCart: cartID) isEmpty]! !

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/26/2018 14:21:00'!
test07CanNotCheckoutToExpiredCreditCard
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createInterface.
	cartID := testObjectsFactory createCartForInterface: storeRestInterface.
	storeRestInterface addToCart: cartID item: testObjectsFactory itemSellByTheStore amount: 1.
	
	
	self 
		should: [storeRestInterface 
					checkoutCart: cartID 
					withCreditCardNumber: 1234567890123456 
					whichExpirationDateIs: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber - 1)
					andItsNameIs: 'Diego Maradona']
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = StoreRestInterface expiredCreditCardErrorMessage.
			"asertar que no se hizo la compra para el cliente"]! !

!StoreRestInterfaceTest methodsFor: 'testing' stamp: 'ft 11/26/2018 14:28:31'!
test08CartCheckoutRegistersSaleForClient
	
	| storeRestInterface cartID |
	
	storeRestInterface := testObjectsFactory createInterface.
	cartID := testObjectsFactory createCartForInterface: storeRestInterface.
	storeRestInterface addToCart: cartID item: testObjectsFactory itemSellByTheStore amount: 1.
	
	storeRestInterface 
					checkoutCart: cartID 
					withCreditCardNumber: 1234567890123456 
					whichExpirationDateIs: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber - 1)
					andItsNameIs: 'Diego Maradona'.
	
	self assert: (storeRestInterface listCart: cartID) isEmpty.
	"asertar que se hizo la compra para el cliente"! !


!StoreRestInterfaceTest methodsFor: 'setup' stamp: 'ft 11/25/2018 15:48:43'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
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


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreRestInterface category: #TusLibros!
Object subclass: #StoreRestInterface
	instanceVariableNames: 'clients carts catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!StoreRestInterface commentStamp: '<historical>' prior: 0!
-¿Qué invariante se puede mantener en el test de crear un carrito para un cliente inválido?
-¿Hay que hacer un chequeo de los parámetros para cada operación? (clientID, cartID)
-¿Cómo hacemos para que el carrito creado por RestInterface tenga el catálogo necesario?
-Si creamos una clase Store que maneje todo,
	--¿hay que remover las aserciones en el carrito con respecto a item del catálogo y cantidad positiva?
	--¿qué ocurren con las aserciones del cashier con respecto a la tarjeta de crédito?
	--¿le corresponde verificar que los clientes estén en su base de datos o es responsabilidad de la interfaz?
-¿Está bien haber implementado el mensaje #itemsDo para los items del carrito?
-¿Qué debería ocurrir con el carrito después del checkout? ¿Se puede seguir usando?!


!StoreRestInterface methodsFor: 'operations' stamp: 'ft 11/25/2018 19:56:25'!
addToCart: aCartID item: anItem amount: anAmount

	| cart |

	cart := carts at: aCartID.
	
	[ cart assertIsValidItem: anItem ]
		on: Error
		do: [ self error: self class itemNotSoldByTheStoreErrorMessage].
	
	[ cart assertIsValidQuantity: anAmount ]
		on: Error
		do: [ self error: self class invalidQuantityErrorMessage].
	
	cart add: anAmount of: anItem.! !

!StoreRestInterface methodsFor: 'operations' stamp: 'ft 11/26/2018 14:12:20'!
checkoutCart: aCartID withCreditCardNumber: aCreditCardNumber whichExpirationDateIs: anExpirationDate andItsNameIs: aName

	| creditCard cart |
	
	creditCard := CreditCard for: aName withNumber: aCreditCardNumber expiringOn: anExpirationDate.
	cart := carts at: aCartID.
	
	
	! !

!StoreRestInterface methodsFor: 'operations' stamp: 'ft 11/25/2018 20:05:32'!
createCartForClient: aClientID withPassword: aPassword 

	| newCartID |

	self assertIsValidClient: aClientID withPassword: aPassword.
	
	newCartID := carts keys size + 1.
	carts at: newCartID put: (Cart acceptingItemsOf: catalog).
	
	^newCartID! !

!StoreRestInterface methodsFor: 'operations' stamp: 'ft 11/25/2018 18:11:19'!
listCart: aCartID

	| items cart |

	items := Dictionary new.
	cart := carts at: aCartID.
	
	cart itemsDo: [ :anItem | items at: anItem put: (cart occurrencesOf: anItem)].
	
	^ items! !

!StoreRestInterface methodsFor: 'operations' stamp: 'ft 11/22/2018 20:02:56'!
listPurchasesForClient: aClientID withPassword: aPassword! !


!StoreRestInterface methodsFor: 'initialization' stamp: 'ft 11/25/2018 20:05:12'!
initializeWithClients: aListOfClients withCatalog: aCatalog.

	clients := aListOfClients.
	catalog := aCatalog.
	carts := Dictionary new.! !


!StoreRestInterface methodsFor: 'assertions' stamp: 'ft 11/25/2018 16:46:32'!
assertIsValidClient: aClientID withPassword: aPassword

	((clients includesKey: aClientID) and: [(clients at: aClientID) = aPassword]) ifFalse: [^self error: self class invalidClientErrorMessage]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreRestInterface class' category: #TusLibros!
StoreRestInterface class
	instanceVariableNames: ''!

!StoreRestInterface class methodsFor: 'error messages' stamp: 'ft 11/25/2018 16:17:10'!
invalidClientErrorMessage

	^'The client ID or password is invalid'! !

!StoreRestInterface class methodsFor: 'error messages' stamp: 'ft 11/25/2018 19:57:04'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !

!StoreRestInterface class methodsFor: 'error messages' stamp: 'ft 11/25/2018 19:42:18'!
itemNotSoldByTheStoreErrorMessage

	^'The item is not sold by the store'! !


!StoreRestInterface class methodsFor: 'class initialization' stamp: 'ft 11/25/2018 20:04:53'!
withClients: aListOfClients withCatalog: aCatalog

	^self new initializeWithClients: aListOfClients withCatalog: aCatalog! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ft 11/25/2018 18:29:09'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ft 11/25/2018 18:29:17'!
anotherItemSellByTheStorePrice
	
	^ 20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ft 11/25/2018 18:29:48'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ft 11/25/2018 20:07:34'!
expiredCreditCard
	
	^CreditCard for: 'Diego Maradona' withNumber: 1234567890123456 expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ft 11/25/2018 20:07:46'!
notExpiredCreditCard
	
	^CreditCard for: 'Diego Maradona' withNumber: 1234567890123455 expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'rest interface' stamp: 'ft 11/25/2018 18:15:11'!
createCartForInterface: aStoreRestInterface

	^aStoreRestInterface createCartForClient: self validClient withPassword: self validPassword! !

!StoreTestObjectsFactory methodsFor: 'rest interface' stamp: 'ft 11/25/2018 20:06:11'!
createInterface

	^StoreRestInterface withClients: self defaultClients withCatalog: self defaultCatalog! !


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
