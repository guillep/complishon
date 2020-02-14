Class {
	#name : #BasicComplishonTest,
	#superclass : #TestCase,
	#category : #Complishon
}

{ #category : #tests }
BasicComplishonTest >> context [
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
