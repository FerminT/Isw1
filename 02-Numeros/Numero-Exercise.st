!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:15:55'!
* aMultiplier 
	
	^aMultiplier productFromEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:14:32'!
+ anAdder 
	
	^anAdder additionFromEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:16:19'!
- aSubtrahend 
	
	^aSubtrahend subtractionFromEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:14:54'!
/ aDivisor 
	
	^ aDivisor divisionFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:13:24'!
additionFromEntero: anEnteroAdder

	^self class with: value + anEnteroAdder integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 17:01:29'!
additionFromFraccion: aFraccionAdder

	| newNumerator |
	
	newNumerator _ self * aFraccionAdder denominator + aFraccionAdder numerator.
	
	^newNumerator / aFraccionAdder denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:13:45'!
divisionFromEntero: anEnteroDivisor

	^Fraccion with: anEnteroDivisor over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:28:01'!
divisionFromFraccion: aFraccionDivisor

	| newDenominator |
	
	newDenominator _ self * aFraccionDivisor denominator.
	
	^Fraccion with: aFraccionDivisor numerator over: newDenominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'lto 9/30/2018 16:50:13'!
fibonacci

	self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:15:21'!
productFromEntero: anEnteroMultiplier

	^self class with: value * anEnteroMultiplier integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:28:08'!
productFromFraccion: aFraccionMultiplier

	| newNumerator |
	
	newNumerator _ self * aFraccionMultiplier numerator.
	
	^newNumerator / aFraccionMultiplier denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 20:51:26'!
subtractionFromEntero: anEnteroSubtrahend
	
	^self class with: (anEnteroSubtrahend integerValue) - value.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:29:59'!
subtractionFromFraccion: aFraccionSubtrahend

	| newNumerator |
	
	newNumerator _ aFraccionSubtrahend numerator - (self * aFraccionSubtrahend denominator).

	^newNumerator / aFraccionSubtrahend denominator! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'ft 10/1/2018 10:13:13'!
isNegative
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'ft 10/1/2018 10:13:21'!
isOne
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'ft 10/1/2018 10:13:30'!
isZero
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'ft 10/1/2018 10:09:48'!
accept: aNumber

	self subclassResponsibility ! !

!Entero class methodsFor: 'instance creation' stamp: 'fermin 9/30/2018 16:22:26'!
initialize: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !

!Entero class methodsFor: 'instance creation' stamp: 'ft 10/1/2018 10:09:12'!
with: aValue 

	| enteroClass |

	enteroClass _ Entero subclasses detect: [ :anEnteroClass | anEnteroClass accept: aValue ].
	
	^ enteroClass initialize: aValue.! !


!Entero class methodsFor: 'error descriptions' stamp: 'NR 9/23/2018 22:17:16'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no est� definido aqu� para enteros negativos'! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:17:35'!
canNotDivideByZero

	self error: Numero canNotDivideByZeroErrorDescription ! !

!Cero methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:39:02'!
ifNegativeExecute: aBlockClosureToExecute! !

!Cero methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:39:43'!
ifOneExecute: aBlockToExecute! !

!Cero methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:39:55'!
ifZeroExecute: aBlockClosureToExecute

	aBlockClosureToExecute value.! !

!Cero methodsFor: 'testing' stamp: 'ft 10/1/2018 10:13:59'!
isNegative

	^false! !

!Cero methodsFor: 'testing' stamp: 'ft 10/1/2018 10:13:52'!
isOne

	^false! !

!Cero methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:40:15'!
isValidDenominator

	self error: 'una fraccion no puede ser cero' ! !

!Cero methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:40:25'!
isValidNumerator

	self error: 'una fraccion no puede ser cero' ! !

!Cero methodsFor: 'testing' stamp: 'ft 10/1/2018 10:13:42'!
isZero

	^true! !


!Cero methodsFor: 'arithmetic operations' stamp: 'lto 9/30/2018 16:50:37'!
fibonacci

	^ Entero with: 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'initialization' stamp: 'ft 9/27/2018 21:53:14'!
accept: aNumber

	^aNumber = 0! !


!classDefinition: #LosDemas category: #'Numero-Exercise'!
Entero subclass: #LosDemas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!LosDemas methodsFor: 'arithmetic operations' stamp: 'lto 9/30/2018 16:50:46'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !


!LosDemas methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:14:59'!
canNotDivideByZero! !

!LosDemas methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:42:17'!
ifNegativeExecute: aBlockClosureToExecute! !

!LosDemas methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:42:24'!
ifOneExecute: aBlockToExecute! !

!LosDemas methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:42:38'!
ifZeroExecute: aBlockClosureToExecute! !

!LosDemas methodsFor: 'testing' stamp: 'ft 10/1/2018 10:14:27'!
isNegative

	^false! !

!LosDemas methodsFor: 'testing' stamp: 'ft 10/1/2018 10:14:21'!
isOne

	^false! !

!LosDemas methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:42:56'!
isValidDenominator! !

!LosDemas methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:43:04'!
isValidNumerator! !

!LosDemas methodsFor: 'testing' stamp: 'ft 10/1/2018 10:14:17'!
isZero

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LosDemas class' category: #'Numero-Exercise'!
LosDemas class
	instanceVariableNames: ''!

!LosDemas class methodsFor: 'initialization' stamp: 'lto 9/30/2018 16:31:31'!
accept: aNumber

	^aNumber > 1! !


!classDefinition: #Negativos category: #'Numero-Exercise'!
Entero subclass: #Negativos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativos methodsFor: 'arithmetic operations' stamp: 'lto 9/30/2018 16:51:03'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription! !


!Negativos methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:15:05'!
canNotDivideByZero! !

!Negativos methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:43:51'!
ifNegativeExecute: aBlockClosureToExecute

	aBlockClosureToExecute value.! !

!Negativos methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:43:57'!
ifOneExecute: aBlockToExecute! !

!Negativos methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:44:04'!
ifZeroExecute: aBlockClosureToExecute! !

!Negativos methodsFor: 'testing' stamp: 'ft 10/1/2018 10:14:50'!
isNegative

	^true! !

!Negativos methodsFor: 'testing' stamp: 'ft 10/1/2018 10:14:38'!
isOne

	^false! !

!Negativos methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:44:12'!
isValidDenominator! !

!Negativos methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:44:18'!
isValidNumerator! !

!Negativos methodsFor: 'testing' stamp: 'ft 10/1/2018 10:14:42'!
isZero

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativos class' category: #'Numero-Exercise'!
Negativos class
	instanceVariableNames: ''!

!Negativos class methodsFor: 'initialization' stamp: 'ft 9/27/2018 21:51:41'!
accept: aNumber

	^aNumber < 0! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'lto 9/30/2018 16:51:29'!
fibonacci

	^ self! !


!Uno methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:15:11'!
canNotDivideByZero! !

!Uno methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:45:04'!
ifNegativeExecute: aBlockClosureToExecute! !

!Uno methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:45:57'!
ifOneExecute: aBlockToExecute

	aBlockToExecute value.! !

!Uno methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:45:21'!
ifZeroExecute: aBlockClosureToExecute! !

!Uno methodsFor: 'testing' stamp: 'ft 10/1/2018 10:15:00'!
isNegative

	^false! !

!Uno methodsFor: 'testing' stamp: 'ft 10/1/2018 10:15:11'!
isOne

	^true! !

!Uno methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:45:29'!
isValidDenominator

	self error: 'una fraccion no puede tener denominador 1 porque sino es un entero'! !

!Uno methodsFor: 'testing' stamp: 'fermin 9/30/2018 17:45:39'!
isValidNumerator! !

!Uno methodsFor: 'testing' stamp: 'ft 10/1/2018 10:15:04'!
isZero

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'initialization' stamp: 'fermin 9/30/2018 17:35:03'!
accept: aNumber

	^aNumber = 1! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:15:38'!
* aMultiplier 

	^aMultiplier productFromFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:14:42'!
+ anAdder 
	
	^anAdder additionFromFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:16:32'!
- aSubtrahend 
	
	^aSubtrahend subtractionFromFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:15:09'!
/ aDivisor 
	
	^aDivisor divisionFromFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:17:03'!
additionFromEntero: anEnteroAdder

	| newNumerator |
	
	newNumerator _ anEnteroAdder * denominator + numerator.
	^newNumerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:17:12'!
additionFromFraccion: aFraccionAdder

	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:27:39'!
divisionFromEntero: anEnteroDivisor

	| newNumerator newDenominator |
	
	newNumerator _ denominator * anEnteroDivisor.
	newDenominator _ numerator.
	
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:17:38'!
divisionFromFraccion: aFraccionDivisor
	
	^(aFraccionDivisor numerator * denominator) / (aFraccionDivisor denominator * numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 17:01:48'!
productFromEntero: anEnteroMultiplier

	| newNumerator |

	newNumerator _ anEnteroMultiplier * numerator.
	
	^newNumerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:18:10'!
productFromFraccion: aFraccionMultiplier

	^(numerator * aFraccionMultiplier numerator) / (denominator * aFraccionMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:26:46'!
subtractionFromEntero: anEnteroSubtrahend

	| newNumerator |
	
	newNumerator _ denominator * anEnteroSubtrahend - numerator.
	
	^newNumerator / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ft 9/27/2018 10:24:21'!
subtractionFromFraccion: aFraccionSubtrahend

	| newNumerator newDenominator |
	
	newNumerator := (aFraccionSubtrahend numerator * denominator) - (aFraccionSubtrahend denominator * numerator).
	newDenominator := denominator * aFraccionSubtrahend denominator.
	
	^newNumerator / newDenominator! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'fermin 9/30/2018 17:46:25'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isValidNumerator.
	aDenominator isValidDenominator.
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'fermin 9/30/2018 17:46:49'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor canNotDivideByZero.
	aDividend ifZeroExecute: [^ aDividend] .
	
	aDivisor ifNegativeExecute: [^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator ifOneExecute: [^ numerator].

	^self new initializeWith: numerator over: denominator
	! !
