!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: 'accountTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'initialization' stamp: 'ft 10/22/2018 09:34:09'!
initializeFor: anAccountTransactions

	accountTransactions _ anAccountTransactions! !


!AccountSummary methodsFor: 'lines' stamp: 'ft 10/22/2018 09:35:18'!
lines

	^accountTransactions
		inject: OrderedCollection new
		into: [ :lines :transaction | lines add: transaction print. lines]! !


!AccountSummary methodsFor: 'net' stamp: 'ft 10/22/2018 09:39:43'!
investmentNet

	| net |
	
	net _ 0.
	accountTransactions do: [ :transaction | (transaction class = CertificateOfDepositLeg) ifTrue: [net _ net + transaction value]].
	
	^net! !

!AccountSummary methodsFor: 'net' stamp: 'ft 10/22/2018 09:40:25'!
transferNet

	| net |
	
	net _ 0.
	accountTransactions do: [ :transaction | (transaction class superclass = TransferLeg) ifTrue: [net _ transaction affectBalance: net]].
	
	^net! !


!AccountSummary methodsFor: 'earnings' stamp: 'ft 10/22/2018 09:40:56'!
investmentEarnings

	| net |
	
	net _ 0.
	accountTransactions do: [ :transaction | (transaction class = CertificateOfDepositLeg) ifTrue: [net _ net + transaction earnings]].
	
	^net! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'class initialization' stamp: 'ft 10/22/2018 09:34:25'!
for: anAccountTransactions

	^self new initializeFor: anAccountTransactions! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'print' stamp: 'ft 10/20/2018 14:44:55'!
print

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDepositLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDepositLeg
	instanceVariableNames: 'certificateOfDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDepositLeg methodsFor: 'value' stamp: 'ft 10/21/2018 16:42:52'!
affectBalance: currentBalance

	^currentBalance - self value! !

!CertificateOfDepositLeg methodsFor: 'value' stamp: 'ft 10/21/2018 17:03:25'!
earnings

	^certificateOfDeposit earnings! !

!CertificateOfDepositLeg methodsFor: 'value' stamp: 'ft 10/21/2018 17:18:59'!
interestRate

	^certificateOfDeposit interestRate! !

!CertificateOfDepositLeg methodsFor: 'value' stamp: 'ft 10/21/2018 17:19:08'!
timeFrame

	^certificateOfDeposit timeFrame! !

!CertificateOfDepositLeg methodsFor: 'value' stamp: 'ft 10/21/2018 16:42:27'!
value

	^certificateOfDeposit value! !


!CertificateOfDepositLeg methodsFor: 'certificateOfDeposit' stamp: 'ft 10/21/2018 16:43:51'!
certificateOfDeposit

	^ certificateOfDeposit! !


!CertificateOfDepositLeg methodsFor: 'initialization' stamp: 'ft 10/21/2018 16:46:37'!
initializeFor: aCertificateOfDeposit

	certificateOfDeposit _ aCertificateOfDeposit! !


!CertificateOfDepositLeg methodsFor: 'print' stamp: 'ft 10/22/2018 09:22:05'!
print

	^'Plazo fijo por ', self value printString, 
	' durante ', self timeFrame printString, 
	' dias a una tna de ', (self interestRate * 100) printString, '%'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDepositLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDepositLeg class
	instanceVariableNames: ''!

!CertificateOfDepositLeg class methodsFor: 'instance creation' stamp: 'ft 10/21/2018 16:45:59'!
for: aCertificateOfDeposit

	^self new initializeFor: aCertificateOfDeposit! !

!CertificateOfDepositLeg class methodsFor: 'instance creation' stamp: 'ft 10/21/2018 16:45:23'!
register: aCertificateOfDeposit on: account

	| certificateOfDepositLeg |
	
	certificateOfDepositLeg := self for: aCertificateOfDeposit.
	account register: certificateOfDepositLeg.
		
	^ certificateOfDepositLeg! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'print' stamp: 'ft 10/20/2018 14:54:52'!
print

	^'Deposito por ', value printString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'value' stamp: 'ft 10/19/2018 09:58:17'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!TransferLeg methodsFor: 'value' stamp: 'ft 10/19/2018 14:25:32'!
value

	^ transfer value! !


!TransferLeg methodsFor: 'transfer' stamp: 'ft 10/19/2018 14:25:26'!
transfer

	^ transfer! !


!TransferLeg methodsFor: 'print' stamp: 'ft 10/20/2018 14:46:04'!
print

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'ft 10/19/2018 14:22:21'!
register: aTransfer on: account

	| withdraw |
	
	withdraw := self for: aTransfer.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'value' stamp: 'ft 10/19/2018 09:59:33'!
affectBalance: currentBalance

	^currentBalance + self value! !


!TransferDeposit methodsFor: 'initialization' stamp: 'ft 10/19/2018 14:20:54'!
initializeFor: aTransfer

	transfer _ aTransfer! !


!TransferDeposit methodsFor: 'print' stamp: 'ft 10/20/2018 14:46:35'!
print

	^'Transferencia por ', self value printString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'ft 10/19/2018 14:15:54'!
for: aTransfer

	^ self new initializeFor: aTransfer! !

!TransferDeposit class methodsFor: 'instance creation' stamp: 'ft 10/19/2018 14:22:42'!
register: aTransfer on: account

	| deposit |
	
	deposit := self for: aTransfer.
	account register: deposit.
		
	^ deposit! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'ft 10/19/2018 09:59:54'!
affectBalance: currentBalance

	^currentBalance - self value! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'ft 10/19/2018 14:20:42'!
initializeFor: aTransfer

	transfer _ aTransfer! !


!TransferWithdraw methodsFor: 'print' stamp: 'ft 10/20/2018 14:56:50'!
print

	^'Transferencia por ', self value negated printString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'ft 10/19/2018 14:20:13'!
for: aTransfer

	^ self new initializeFor: aTransfer! !

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'ft 10/19/2018 14:23:02'!
register: aTransfer on: account

	| withdraw |
	
	withdraw := self for: aTransfer.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'print' stamp: 'ft 10/20/2018 14:47:09'!
print

	^'Extraccion por ', value printString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #CertificateOfDeposit
	instanceVariableNames: 'value timeFrame interestRate certificateOfDepositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'ft 10/21/2018 16:52:28'!
initializeWith: anAmount during: anAmountOfDays at: anInterestRate on: account

	value _ anAmount.
	timeFrame _ anAmountOfDays.
	interestRate _ anInterestRate.
	certificateOfDepositLeg _ CertificateOfDepositLeg register: self on: account! !


!CertificateOfDeposit methodsFor: 'value' stamp: 'ft 10/21/2018 17:05:04'!
earnings

	^value * (interestRate / 360) * timeFrame! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'ft 10/21/2018 17:17:58'!
interestRate

	^interestRate! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'ft 10/21/2018 17:18:11'!
timeFrame

	^timeFrame! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'ft 10/21/2018 16:59:31'!
value

	^value! !


!CertificateOfDeposit methodsFor: 'accessing' stamp: 'ft 10/21/2018 17:00:10'!
certificateOfDepositLeg

	^certificateOfDepositLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'class initialization' stamp: 'ft 10/21/2018 16:51:54'!
register: anAmount during: anAmountOfDays at: anInterestRate on: account

	^self new initializeWith: anAmount during: anAmountOfDays at: anInterestRate on: account! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 18:49:23'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'ft 10/19/2018 14:23:58'!
initializeWith: anAmount from: fromAccount to: toAccount

	value _ anAmount.
	depositLeg _ TransferDeposit register: self on: toAccount.
	withdrawLeg _ TransferWithdraw register: self on: fromAccount! !


!Transfer methodsFor: 'accessing' stamp: 'ft 10/19/2018 14:26:08'!
depositLeg

	^ depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'ft 10/19/2018 14:26:04'!
withdrawLeg

	^ withdrawLeg! !


!Transfer methodsFor: 'value' stamp: 'ft 10/19/2018 14:26:52'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'class initialization' stamp: 'ft 10/19/2018 10:08:41'!
register: anAmount from: fromAccount to: toAccount

	^self new initializeWith: anAmount from: fromAccount to: toAccount! !
