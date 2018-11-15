!classDefinition: #OnlineLibraryTests category: #OnlineLibrary!
TestCase subclass: #OnlineLibraryTests
	instanceVariableNames: 'cart library'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'OnlineLibrary'!

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/13/2018 13:52:08'!
test01NewShoppingCartIsEmpty

	library := OnlineLibrary new.
	cart := ShoppingCart for: library.
	
	self assert: cart isEmpty! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/13/2018 13:54:55'!
test02CanAddBooksToShoppingCartAndListThem

	| book1 book2 |

	library := OnlineLibrary new.
	cart := ShoppingCart for: library.
	
	book1 := 1234567890123.
	book2 := 1234567890122.
	
	library register: book1.
	library register: book2.
	cart add: book1.
	cart add: book2.
		
	self assert: cart isEmpty not.
	self assert: cart amountOfBooks equals: 2.
	self assert: (cart books includesAllOf: (Array with: book1 with: book2))! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/13/2018 14:16:24'!
test03CanAddMoreThanOneCopyOfBookToShoppingCartAndAskItsAmount

	| book1 book2 |

	library := OnlineLibrary new.
	cart := ShoppingCart for: library.
	
	book1 := 1234567890123.
	book2 := 1234567890000.
	
	library register: book1 amount: 10.
	library register: book2.
	
	cart add: book1 amount: 10.
	cart add: book2.
		
	self assert: cart amountOfBooks equals: 11.
	self assert: (cart bookAmount: book1) equals: 10.
	self assert: (cart bookAmount: book2) equals: 1.! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/15/2018 10:11:02'!
test04CantAddBookToShoppingCartThatIsNotInLibrary

	| book |

	library := OnlineLibrary new.
	cart := ShoppingCart for: library.
	
	book := 1234567890123.
	
	self 
		should: [cart add: book]
		raise: Error
		withExceptionDo: [ :anInvalidShoppingCart |
			self assert: ShoppingCart bookNotInLibraryError = anInvalidShoppingCart messageText].
		
	self assert: cart amountOfBooks equals: 0.
	self assert: (cart bookAmount: book) equals: 0.! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/15/2018 10:11:13'!
test05CantAddMoreBooksToShoppingCartThanAmountThatIsInLibrary

	| book |

	library := OnlineLibrary new.
	cart := ShoppingCart for: library.
	
	book := 1234567890123.
	
	library register: book amount: 5.
	
	self 
		should: [cart add: book amount: 10]
		raise: Error
		withExceptionDo: [ :anInvalidShoppingCart |
			self assert: ShoppingCart notEnoughCopiesOfBookInLibraryError = anInvalidShoppingCart messageText].
		
	self assert: cart amountOfBooks equals: 0.
	self assert: (cart bookAmount: book) equals: 0.! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/15/2018 11:37:24'!
test06ShoppingCartCheckoutRemovesBooksFromLibrary

	| book1 book2 |

	library := OnlineLibrary new.
	cart := ShoppingCart for: library.
	
	book1 := 1234567890123.
	book2 := 1234567890000.
	
	library register: book1 amount: 10.
	library register: book2.
	
	cart add: book1 amount: 10.
	cart add: book2.
	
	cart checkout.
		
	self assert: (library contains: book1 withAmount: 0).
	self assert: (library contains: book2 withAmount: 0).
	self assert: cart amountOfBooks equals: 0! !

!OnlineLibraryTests methodsFor: 'Testing' stamp: 'ft 11/15/2018 11:34:13'!
test07CantBuyMoreBooksThanThereAreAtLibrary

	| book1 |

	library := OnlineLibrary new.

	book1 := 1234567890123.
	
	library register: book1 amount: 5.
	
	self
		should: [library buy: book1 amount: 10]
		raise: Error
		withExceptionDo: [ :anInvalidOnlineLibrary |
			self assert: OnlineLibrary notEnoughCopiesOfBookToSell = anInvalidOnlineLibrary messageText].! !


!classDefinition: #OnlineLibrary category: #OnlineLibrary!
Object subclass: #OnlineLibrary
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'OnlineLibrary'!

!OnlineLibrary methodsFor: 'initialization' stamp: 'ft 11/13/2018 13:42:56'!
initialize

	books := Dictionary new! !


!OnlineLibrary methodsFor: 'accessing' stamp: 'ft 11/13/2018 14:47:26'!
contains: aBook

	^ books includesKey: aBook! !

!OnlineLibrary methodsFor: 'accessing' stamp: 'ft 11/15/2018 11:30:16'!
contains: aBook withAmount: anAmount

	^ (self contains: aBook) and: [(books at: aBook) = anAmount]! !

!OnlineLibrary methodsFor: 'accessing' stamp: 'ft 11/15/2018 11:29:59'!
contains: aBook withAtLeast: anAmount

	^ (self contains: aBook) and: [(books at: aBook) >= anAmount]! !


!OnlineLibrary methodsFor: 'operations' stamp: 'ft 11/15/2018 11:31:29'!
buy: aBook amount: anAmount

	| amountInStock |

	(self contains: aBook withAtLeast: anAmount) ifFalse: [^ self error: self class notEnoughCopiesOfBookToSell].
	 
	amountInStock _ (books at: aBook) - anAmount.

	self register: aBook amount: amountInStock.! !

!OnlineLibrary methodsFor: 'operations' stamp: 'ft 11/13/2018 13:55:53'!
register: aBook

	^self register: aBook amount:1! !

!OnlineLibrary methodsFor: 'operations' stamp: 'ft 11/13/2018 13:56:21'!
register: aBook amount: anAmount

	books add: (Association key: aBook value: anAmount).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OnlineLibrary class' category: #OnlineLibrary!
OnlineLibrary class
	instanceVariableNames: ''!

!OnlineLibrary class methodsFor: 'error messages' stamp: 'LTO 11/14/2018 20:12:06'!
notEnoughCopiesOfBookToSell

	^'There are not enough copies of the book to sell'! !


!classDefinition: #ShoppingCart category: #OnlineLibrary!
Object subclass: #ShoppingCart
	instanceVariableNames: 'library books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'OnlineLibrary'!

!ShoppingCart methodsFor: 'testing' stamp: 'ft 11/12/2018 20:36:48'!
isEmpty

	^ books isEmpty! !


!ShoppingCart methodsFor: 'initialization' stamp: 'ft 11/13/2018 13:41:26'!
initializeFor: anOnlineLibrary

	library := anOnlineLibrary.
	books := Dictionary new! !


!ShoppingCart methodsFor: 'operations' stamp: 'ft 11/12/2018 20:29:40'!
add: aBook

	self add: aBook amount: 1! !

!ShoppingCart methodsFor: 'operations' stamp: 'LTO 11/14/2018 19:48:36'!
add: aBook amount: anAmount

	(library contains: aBook) ifFalse: [^self error: self class bookNotInLibraryError].
	(library contains: aBook withAtLeast: anAmount) ifFalse: [^self error: self class notEnoughCopiesOfBookInLibraryError].
	
	books add: (Association key: aBook value: anAmount)! !

!ShoppingCart methodsFor: 'operations' stamp: 'ft 11/15/2018 10:00:30'!
checkout
	
	books keysAndValuesDo: [ :aBook :anAmount | library buy: aBook amount: anAmount].
	books := Dictionary new.! !


!ShoppingCart methodsFor: 'accessing' stamp: 'ft 11/12/2018 20:36:03'!
amountOfBooks

	^books values
		inject: 0
		into: [ :amount :aValue | amount + aValue]
	! !

!ShoppingCart methodsFor: 'accessing' stamp: 'ft 11/13/2018 13:51:34'!
bookAmount: aBook

	(books includesKey: aBook) ifFalse: [^0].

	^ books at: aBook! !

!ShoppingCart methodsFor: 'accessing' stamp: 'ft 11/12/2018 20:31:13'!
books

	^books keys! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #OnlineLibrary!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'class initialization' stamp: 'ft 11/13/2018 13:41:03'!
for: anOnlineLibrary

	^ self new initializeFor: anOnlineLibrary! !


!ShoppingCart class methodsFor: 'error messages' stamp: 'ft 11/13/2018 13:45:24'!
bookNotInLibraryError

	^'The specified book is not in the library'! !

!ShoppingCart class methodsFor: 'error messages' stamp: 'ft 11/13/2018 14:26:17'!
notEnoughCopiesOfBookInLibraryError

	^'The requested amount is not available for that book'! !
