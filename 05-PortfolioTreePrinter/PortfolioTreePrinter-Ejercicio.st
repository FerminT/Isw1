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


!AccountTransaction methodsFor: 'accept' stamp: 'ft 10/22/2018 18:58:06'!
accept: aVisitor

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


!CertificateOfDepositLeg methodsFor: 'accept' stamp: 'ft 10/22/2018 18:58:39'!
accept: aVisitor

	aVisitor visitCertificateOfDepositLeg: self! !

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


!Deposit methodsFor: 'accept' stamp: 'ft 10/22/2018 18:59:07'!
accept: aVisitor

	aVisitor visitDeposit: self! !

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


!TransferLeg methodsFor: 'accept' stamp: 'ft 10/22/2018 18:59:26'!
accept: aVisitor

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


!TransferDeposit methodsFor: 'accept' stamp: 'ft 10/22/2018 18:59:41'!
accept: aVisitor

	aVisitor visitTransferDeposit: self! !

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


!TransferWithdraw methodsFor: 'accept' stamp: 'ft 10/22/2018 18:59:58'!
accept: aVisitor

	aVisitor visitTransferWithdraw: self! !

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


!Withdraw methodsFor: 'accept' stamp: 'ft 10/22/2018 19:00:11'!
accept: aVisitor

	aVisitor visitWithdraw: self! !

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


!classDefinition: #AccountTransactionsVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransactionsVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransactionsVisitor methodsFor: 'initialization' stamp: 'ft 10/22/2018 19:26:57'!
initializeOf: anAccount

	account _ anAccount! !


!AccountTransactionsVisitor methodsFor: 'value' stamp: 'ft 10/22/2018 19:27:24'!
value

	self subclassResponsibility ! !


!AccountTransactionsVisitor methodsFor: 'visits' stamp: 'ft 10/22/2018 19:28:51'!
visitCertificateOfDepositLeg: aCertificateOfDepositLeg

	self subclassResponsibility ! !

!AccountTransactionsVisitor methodsFor: 'visits' stamp: 'ft 10/22/2018 19:28:34'!
visitDeposit: aDeposit

	self subclassResponsibility ! !

!AccountTransactionsVisitor methodsFor: 'visits' stamp: 'ft 10/22/2018 19:28:05'!
visitTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!AccountTransactionsVisitor methodsFor: 'visits' stamp: 'ft 10/22/2018 19:28:17'!
visitTransferWithdraw: aTransferWIthdraw

	self subclassResponsibility ! !

!AccountTransactionsVisitor methodsFor: 'visits' stamp: 'ft 10/22/2018 19:27:52'!
visitWithdraw: aWithdraw

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransactionsVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor class
	instanceVariableNames: ''!

!AccountTransactionsVisitor class methodsFor: 'class initialization' stamp: 'ft 10/22/2018 19:26:43'!
of: anAccount

	^self new initializeOf: anAccount! !


!classDefinition: #AccountInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountInvestmentEarnings
	instanceVariableNames: 'earnings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentEarnings methodsFor: 'visits' stamp: 'ft 10/22/2018 19:38:20'!
visitCertificateOfDepositLeg: aCertificateOfDepositLeg

	earnings _ earnings + aCertificateOfDepositLeg earnings! !

!AccountInvestmentEarnings methodsFor: 'visits' stamp: 'ft 10/22/2018 19:37:23'!
visitDeposit: aDeposit! !

!AccountInvestmentEarnings methodsFor: 'visits' stamp: 'ft 10/22/2018 19:37:44'!
visitTransferDeposit: aTransferDeposit! !

!AccountInvestmentEarnings methodsFor: 'visits' stamp: 'ft 10/22/2018 19:37:53'!
visitTransferWithdraw: aTransferWithdraw! !

!AccountInvestmentEarnings methodsFor: 'visits' stamp: 'ft 10/22/2018 19:37:33'!
visitWithdraw: aWithdraw! !


!AccountInvestmentEarnings methodsFor: 'value' stamp: 'ft 10/22/2018 19:39:15'!
value

	earnings _ 0.
	
	account visitTransactionsWith: self.
	
	^earnings! !


!classDefinition: #AccountInvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountInvestmentNet
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:33:52'!
visitCertificateOfDepositLeg: aCertificateOfDepositLeg

	net _ net + aCertificateOfDepositLeg value! !

!AccountInvestmentNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:31:44'!
visitDeposit: aDeposit! !

!AccountInvestmentNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:32:07'!
visitTransferDeposit: aTransferDeposit! !

!AccountInvestmentNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:32:15'!
visitTransferWithdraw: aTransferWithdraw! !

!AccountInvestmentNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:31:53'!
visitWithdraw: aWithdraw! !


!AccountInvestmentNet methodsFor: 'value' stamp: 'ft 10/22/2018 19:34:23'!
value

	net _ 0.
	
	account visitTransactionsWith: self.
	
	^net! !


!classDefinition: #AccountSummaryLines category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountSummaryLines
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryLines methodsFor: 'value' stamp: 'ft 10/22/2018 19:17:03'!
value

	lines _ OrderedCollection new.
	
	account visitTransactionsWith: self.
	
	^lines! !


!AccountSummaryLines methodsFor: 'visits' stamp: 'ft 10/22/2018 19:12:55'!
visitCertificateOfDepositLeg: aCertificateOfDeposit

	^lines add: 'Plazo fijo por ', aCertificateOfDeposit value printString, 
		' durante ', aCertificateOfDeposit timeFrame printString, 
		' dias a una tna de ', (aCertificateOfDeposit interestRate * 100) printString, '%'! !

!AccountSummaryLines methodsFor: 'visits' stamp: 'ft 10/22/2018 19:13:02'!
visitDeposit: aDeposit

	^lines add: 'Deposito por ', aDeposit value printString! !

!AccountSummaryLines methodsFor: 'visits' stamp: 'ft 10/22/2018 19:13:08'!
visitTransferDeposit: aTransferDeposit

	^lines add: 'Transferencia por ', aTransferDeposit value printString! !

!AccountSummaryLines methodsFor: 'visits' stamp: 'ft 10/22/2018 19:13:14'!
visitTransferWithdraw: aTransferWithdraw

	^lines add: 'Transferencia por ', aTransferWithdraw value negated printString! !

!AccountSummaryLines methodsFor: 'visits' stamp: 'ft 10/22/2018 19:13:28'!
visitWithdraw: aWithdraw

	^lines add: 'Extraccion por ', aWithdraw value printString! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountTransferNet
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:22:03'!
visitCertificateOfDepositLeg: aCertificateOfDepositLeg! !

!AccountTransferNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:21:32'!
visitDeposit: aDeposit! !

!AccountTransferNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:44:31'!
visitTransferDeposit: aTransferDeposit

	net _ net + aTransferDeposit value! !

!AccountTransferNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:44:47'!
visitTransferWithdraw: aTransferWithdraw

	net _ net - aTransferWithdraw value! !

!AccountTransferNet methodsFor: 'visits' stamp: 'ft 10/22/2018 19:21:44'!
visitWithdraw: aWithdraw! !


!AccountTransferNet methodsFor: 'value' stamp: 'ft 10/22/2018 19:24:55'!
value

	net _ 0.
	
	account visitTransactionsWith: self.
	
	^net! !


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


!SummarizingAccount methodsFor: 'accept' stamp: 'ft 10/22/2018 19:58:08'!
accept: aVisitor

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'visitors' stamp: 'ft 10/24/2018 10:51:12'!
visitAccountsWith: aVisitor

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


!Portfolio methodsFor: 'accept' stamp: 'ft 10/22/2018 19:58:22'!
accept: aVisitor

	aVisitor visitPortfolio: self! !


!Portfolio methodsFor: 'visitors' stamp: 'ft 10/22/2018 20:08:07'!
visitAccountsWith: aVisitor

	" Acá hay que decidir si yo elijo a qué cuentas debe visitar el visitor (en qué orden), o si directamente lo mando a 'visitar' a cada una de las cuentas y que él decida el orden
	Lo primero parece tener más sentido"! !

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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'ft 10/22/2018 19:16:42'!
visitTransactionsWith: aVisitor

	transactions do: [ :transaction | transaction accept: aVisitor]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'accept' stamp: 'ft 10/22/2018 19:58:40'!
accept: aVisitor

	aVisitor visitReceptiveAccount: self! !


!ReceptiveAccount methodsFor: 'visitors' stamp: 'ft 10/24/2018 10:59:30'!
visitAccountsWith: aVisitor

	self accept: aVisitor! !


!classDefinition: #SummarizingAccountVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccountVisitor
	instanceVariableNames: 'account accountsNames lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccountVisitor methodsFor: 'initialization' stamp: 'ft 10/22/2018 19:52:41'!
initializeOf: anAccount with: aDictionary

	account _ anAccount.
	accountsNames _ aDictionary! !


!SummarizingAccountVisitor methodsFor: 'value' stamp: 'ft 10/24/2018 10:50:01'!
value

	lines _ OrderedCollection new.
	
	account visitAccountsWith: self.
	
	^lines! !


!SummarizingAccountVisitor methodsFor: 'visits' stamp: 'ft 10/22/2018 20:08:26'!
visitPortfolio: aPortfolio

	"Agregar lógica para los espacios y eso"

	aPortfolio visitAccountsWith: self! !

!SummarizingAccountVisitor methodsFor: 'visits' stamp: 'ft 10/22/2018 19:54:02'!
visitReceptiveAccount: aReceptiveAccount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummarizingAccountVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountVisitor class
	instanceVariableNames: ''!

!SummarizingAccountVisitor class methodsFor: 'class initialization' stamp: 'ft 10/22/2018 19:51:59'!
of: anAccount with: aDictionary

	^self new initializeOf: anAccount with: aDictionary! !


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
