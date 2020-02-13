Class {
	#name : #ComplishonTest,
	#superclass : #TestCase,
	#category : #Complishon
}

{ #category : #tests }
ComplishonTest >> context [
	^ ComplishonContext new
		complishonClass:
			(ComplishonMockClass new
				instanceVariables: {'a' . 'b' . 'c'};
				yourself);
		complishonEnvironment:
			(ComplishonMockEnvironment new
				globals: {'A' . 'B' . 'C'};
				yourself);
		yourself
]
