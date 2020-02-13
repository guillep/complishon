Class {
	#name : #BasicComplishonFetcherTest,
	#superclass : #ComplishonTest,
	#category : #Complishon
}

{ #category : #tests }
BasicComplishonFetcherTest >> testComplishonCompositionAtEndShouldBeAtEnd [

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
BasicComplishonFetcherTest >> testComplishonCompositionNextManyShouldReturnCollection [
	| c |
	c := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	c context: self context.
	self assert: (c next: 5) equals: #(a b c A B)
]

{ #category : #tests }
BasicComplishonFetcherTest >> testComplishonCompositionNextManyShouldStopAfterEndOfElements [

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
BasicComplishonFetcherTest >> testComplishonCompositionNextShouldReturnFirstValueFirst [

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
BasicComplishonFetcherTest >> testComplishonCompositionNextShouldReturnNilAfterEnd [

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
BasicComplishonFetcherTest >> testComplishonCompositionNextShouldReturnValuesOfSecondComplishonAfterFirst [

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
BasicComplishonFetcherTest >> testComplishonCompositionWithElementsShouldNotBeAtEnd [

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
BasicComplishonFetcherTest >> testComplishonWithNoResultsShouldBeAtEnd [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: self context.
	
	c := c select: [ :e | false ].
	
	self assert: c atEnd
]

{ #category : #tests }
BasicComplishonFetcherTest >> testFilterComplishonBeforeFetchingShouldNarrowResults [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: self context.
	
	c := c select: [ :e | (e beginsWith: 'a') not ].
	
	self assert: c next equals: 'b'
]

{ #category : #tests }
BasicComplishonFetcherTest >> testGlobalVariableComplishonAtEndShouldBeAtEnd [

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
BasicComplishonFetcherTest >> testGlobalVariableComplishonNextManyShouldReturnCollection [

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
BasicComplishonFetcherTest >> testGlobalVariableComplishonNextManyShouldStopAfterEndOfElements [

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
BasicComplishonFetcherTest >> testGlobalVariableComplishonNextShouldReturnAfterSecondGlobalVariable [

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
BasicComplishonFetcherTest >> testGlobalVariableComplishonNextShouldReturnFirstGlobalVariable [

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
BasicComplishonFetcherTest >> testGlobalVariableComplishonNextShouldReturnNilAfterEnd [

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
BasicComplishonFetcherTest >> testGlobalVariableComplishonWithElementsShouldNotBeAtEnd [

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
BasicComplishonFetcherTest >> testInstanceVariableComplishonAtEndShouldBeAtEnd [

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
BasicComplishonFetcherTest >> testInstanceVariableComplishonNextManyShouldReturnCollection [

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
BasicComplishonFetcherTest >> testInstanceVariableComplishonNextManyShouldStopAfterEndOfElements [

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
BasicComplishonFetcherTest >> testInstanceVariableComplishonNextShouldReturnAfterSecondInstanceVariable [

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
BasicComplishonFetcherTest >> testInstanceVariableComplishonNextShouldReturnFirstInstanceVariable [

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
BasicComplishonFetcherTest >> testInstanceVariableComplishonNextShouldReturnNilAfterEnd [

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
BasicComplishonFetcherTest >> testInstanceVariableComplishonWithElementsShouldNotBeAtEnd [

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
