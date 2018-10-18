!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'ft 10/16/2018 15:00:52'!
valueForBalance

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'ft 10/16/2018 15:01:06'!
valueForBalance

	^value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'ft 10/18/2018 13:01:00'!
managesAnyAccountOf: anAccount

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'ft 10/16/2018 10:43:39'!
balance

	^accounts sum: [ :anAccount | anAccount balance]! !


!Portfolio methodsFor: 'testing' stamp: 'ft 10/18/2018 11:51:52'!
doesManage: anAccount

	^anAccount isManagedByPortfolio: self! !

!Portfolio methodsFor: 'testing' stamp: 'ft 10/16/2018 11:21:20'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :account | account hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'testing' stamp: 'ft 10/18/2018 12:26:51'!
managesAnyAccountOf: anAccount

	^anAccount managesAnyAccountOfPortfolio: self! !


!Portfolio methodsFor: 'transactions' stamp: 'ft 10/16/2018 11:00:43'!
transactions 

	| transactions |

	transactions _ OrderedCollection new.
	accounts do: [ :account | transactions addAll: account transactions].
	
	^transactions! !

!Portfolio methodsFor: 'transactions' stamp: 'ft 10/16/2018 13:18:14'!
transactionsOf: anAccount 

	(self doesManage: anAccount) ifTrue: [^anAccount transactions].
	
	^self error: self class accountNotManagedMessageDescription! !


!Portfolio methodsFor: 'initialize' stamp: 'ft 10/18/2018 11:32:53'!
safeWith: aValidCollectionOfAccounts

	accounts _ aValidCollectionOfAccounts copy! !


!Portfolio methodsFor: 'testing - private' stamp: 'ft 10/18/2018 11:43:00'!
doesManageReceptiveAccount: aReceptiveAccount

	^accounts anySatisfy: [ :account | account doesManage: aReceptiveAccount]! !

!Portfolio methodsFor: 'testing - private' stamp: 'ft 10/18/2018 12:53:31'!
isManagedByPortfolio: aPortfolio

	"Un portfolio maneja a otro portfolio sii. contiene a todas sus cuentas"
	^accounts allSatisfy: [ :account | aPortfolio doesManage: account]! !

!Portfolio methodsFor: 'testing - private' stamp: 'ft 10/18/2018 12:29:34'!
managesAnyAccountOfPortfolio: aPortfolio

	^accounts anySatisfy: [ :account | aPortfolio doesManage: account]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'ft 10/16/2018 11:59:56'!
with: leftAccount with: rightAccount
	
	| accounts |

	accounts _ OrderedCollection new.	
	accounts add: leftAccount; add: rightAccount.
	
	^self withAll: accounts! !

!Portfolio class methodsFor: 'instance creation' stamp: 'ft 10/18/2018 12:52:06'!
withAll: aCollectionOfAccounts
	
	| accounts |
	
	"Me aseguro de que se cumpla la precondición de que sean subclases de SummarizingAccount"
	(aCollectionOfAccounts allSatisfy: [ :anAccountToVerify | anAccountToVerify class superclass = SummarizingAccount])
		ifFalse: [^self error: 'Not a valid instance'].
		
	accounts _ OrderedCollection new.
	
	"Como solo debo crear objetos válidos, corresponde hacer la verificación antes de crear una instancia"
	
	"Disclaimer: usamos el mensaje #managesAnyAccountOf en lugar de #doesManage porque interpretamos que
	(Portfolio1 doesManage: Portfolio2) sii. TODAS las cuentas de Portfolio2 están incluidas en Portfolio1.
	Por lo tanto, no corresponde usar el mensaje #doesManage, sino ver si Portfolio1 contiene ALGUNA de las cuentas de Portfolio2."
	
	aCollectionOfAccounts do: [ :anAccountToVerify | (accounts anySatisfy: [ :account | account managesAnyAccountOf: anAccountToVerify])
		ifTrue: [^self error: self accountAlreadyManagedErrorMessage]
		ifFalse: [accounts add: anAccountToVerify]].
	
	^self new safeWith: aCollectionOfAccounts! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ft 10/16/2018 15:04:52'!
balance

	^transactions inject: 0 into: [ :sum :aTransaction | sum + aTransaction valueForBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'ft 10/18/2018 12:54:14'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'ft 10/18/2018 12:17:33'!
managesAnyAccountOf: anAccount

	^self doesManage: anAccount! !


!ReceptiveAccount methodsFor: 'testing - private' stamp: 'ft 10/18/2018 11:41:52'!
isManagedByPortfolio: aPortfolio

	^aPortfolio doesManageReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'testing - private' stamp: 'ft 10/18/2018 12:28:55'!
managesAnyAccountOfPortfolio: aPortfolio

	^self isManagedByPortfolio: aPortfolio! !
