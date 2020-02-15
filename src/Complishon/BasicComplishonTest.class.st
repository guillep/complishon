Class {
	#name : #BasicComplishonTest,
	#superclass : #TestCase,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
BasicComplishonTest >> context [
	^ ComplishonContext new
		complishonClass:
			(ComplishonMockClass new
				instanceVariables: {'a' . 'b' . 'c'};
				selectors: #( ma mb mc );
				yourself);
		complishonEnvironment:
			(ComplishonMockEnvironment new
				globals: {'A' . 'B' . 'C'};
				yourself);
		yourself
]
