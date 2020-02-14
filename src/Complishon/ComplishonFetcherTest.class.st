Class {
	#name : #ComplishonFetcherTest,
	#superclass : #BasicComplishonTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ComplishonFetcherTest >> testComplishonCompositionAtEndShouldBeAtEnd [

	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	c next: 10.
	self assert: c atEnd
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonCompositionNextManyShouldReturnCollection [
	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: self context.
	self assert: (c next: 5) equals: #(a b c A B)
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonCompositionNextManyShouldStopAfterEndOfElements [

	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	self assert: (c next: 10) equals: #( a b c A B C )
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonCompositionNextShouldReturnFirstValueFirst [

	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
		
	self assert: c next equals: 'a'
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonCompositionNextShouldReturnNilAfterEnd [

	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	c next: 6.
	self assert: c next equals: nil
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonCompositionNextShouldReturnValuesOfSecondComplishonAfterFirst [

	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	"Consume instance variables"
	c next: 3.
	self assert: c next equals: 'A'
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonCompositionWithElementsShouldNotBeAtEnd [

	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
		
	self deny: c atEnd
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonWithNoResultsShouldBeAtEnd [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: self context.
	
	c := c select: [ :e | false ].
	
	self assert: c atEnd
]

{ #category : #tests }
ComplishonFetcherTest >> testFilterComplishonBeforeFetchingShouldNarrowResults [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: self context.
	
	c := c select: [ :e | (e beginsWith: 'a') not ].
	
	self assert: c next equals: 'b'
]

{ #category : #tests }
ComplishonFetcherTest >> testGlobalVariableComplishonAtEndShouldBeAtEnd [

	| c |
	c := GlobalVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	c next: 3.
	self assert: c atEnd
]

{ #category : #tests }
ComplishonFetcherTest >> testGlobalVariableComplishonNextManyShouldReturnCollection [

	| c |
	c := GlobalVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	self assert: (c next: 2) equals: #( 'A' 'B' )
]

{ #category : #tests }
ComplishonFetcherTest >> testGlobalVariableComplishonNextManyShouldStopAfterEndOfElements [

	| c |
	c := GlobalVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	self assert: (c next: 10) equals: #( 'A' 'B' 'C' )
]

{ #category : #tests }
ComplishonFetcherTest >> testGlobalVariableComplishonNextShouldReturnAfterSecondGlobalVariable [

	| c |
	c := GlobalVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).

	c next.
	self assert: c next equals: 'B'
]

{ #category : #tests }
ComplishonFetcherTest >> testGlobalVariableComplishonNextShouldReturnFirstGlobalVariable [

	| c |
	c := GlobalVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
		
	self assert: c next equals: 'A'
]

{ #category : #tests }
ComplishonFetcherTest >> testGlobalVariableComplishonNextShouldReturnNilAfterEnd [

	| c |
	c := GlobalVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	c next; next; next.
	self assert: c next equals: nil
]

{ #category : #tests }
ComplishonFetcherTest >> testGlobalVariableComplishonWithElementsShouldNotBeAtEnd [

	| c |
	c := GlobalVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
		
	self deny: c atEnd
]

{ #category : #tests }
ComplishonFetcherTest >> testInstanceVariableComplishonAtEndShouldBeAtEnd [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	c next: 3.
	self assert: c atEnd
]

{ #category : #tests }
ComplishonFetcherTest >> testInstanceVariableComplishonNextManyShouldReturnCollection [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	self assert: (c next: 2) equals: #( 'a' 'b' )
]

{ #category : #tests }
ComplishonFetcherTest >> testInstanceVariableComplishonNextManyShouldStopAfterEndOfElements [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	self assert: (c next: 10) equals: #( 'a' 'b' 'c' )
]

{ #category : #tests }
ComplishonFetcherTest >> testInstanceVariableComplishonNextShouldReturnAfterSecondInstanceVariable [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	c next.
	self assert: c next equals: 'b'
]

{ #category : #tests }
ComplishonFetcherTest >> testInstanceVariableComplishonNextShouldReturnFirstInstanceVariable [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
		
	self assert: c next equals: 'a'
]

{ #category : #tests }
ComplishonFetcherTest >> testInstanceVariableComplishonNextShouldReturnNilAfterEnd [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
	
	c next; next; next.
	self assert: c next equals: nil
]

{ #category : #tests }
ComplishonFetcherTest >> testInstanceVariableComplishonWithElementsShouldNotBeAtEnd [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).

	self deny: c atEnd
]
