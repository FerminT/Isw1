!classDefinition: #OnlineLibraryTests category: #OnlineLibrary!
TestCase subclass: #OnlineLibraryTests
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'OnlineLibrary'!

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/12/2018 20:00:31'!
test01NewShoppingCartIsEmpty

	cart := ShoppingCart new.
	
	self assert: cart isEmpty! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/12/2018 20:53:05'!
test02CanAddBooksToShoppingCartAndListThem

	| book1 book2 |

	cart := ShoppingCart new.
	book1 := 1234567890123.
	book2 := 1234567890122.
	
	cart add: book1.
	cart add: book2.
		
	self assert: cart isEmpty not.
	self assert: cart amountOfBooks equals: 2.
	self assert: (cart books includesAllOf: (Array with: book1 with: book2))! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/12/2018 20:53:22'!
test03CanAddMoreThanOneCopyOfBookToShoppingCartAndAskItsAmount

	| book1 book2 |

	cart := ShoppingCart new.
	book1 := 1234567890123.
	book2 := 1234567890000.
	
	cart add: book1 amount: 10.
	cart add: book2.
		
	self assert: cart amountOfBooks equals: 11.
	self assert: (cart bookAmount: book1) equals: 10.
	self assert: (cart bookAmount: book2) equals: 1.! !


!classDefinition: #ShoppingCart category: #OnlineLibrary!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'OnlineLibrary'!

!ShoppingCart methodsFor: 'testing' stamp: 'ft 11/12/2018 20:36:48'!
isEmpty

	^ books isEmpty! !


!ShoppingCart methodsFor: 'initialization' stamp: 'ft 11/12/2018 20:28:53'!
initialize

	books := Dictionary new! !


!ShoppingCart methodsFor: 'adding' stamp: 'ft 11/12/2018 20:29:40'!
add: aBook

	self add: aBook amount: 1! !

!ShoppingCart methodsFor: 'adding' stamp: 'ft 11/12/2018 20:30:19'!
add: aBook amount: aQuantity

	books add: (Association key: aBook value: aQuantity)! !


!ShoppingCart methodsFor: 'accessing' stamp: 'ft 11/12/2018 20:36:03'!
amountOfBooks

	^books values
		inject: 0
		into: [ :amount :aValue | amount + aValue]
	! !

!ShoppingCart methodsFor: 'accessing' stamp: 'ft 11/12/2018 20:51:01'!
bookAmount: aBook

	^books at: aBook! !

!ShoppingCart methodsFor: 'accessing' stamp: 'ft 11/12/2018 20:31:13'!
books

	^books keys! !
