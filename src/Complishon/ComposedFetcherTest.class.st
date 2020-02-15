Class {
	#name : #ComposedFetcherTest,
	#superclass : #BasicComplishonTest,
	#instVars : [
		'fetcher'
	],
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ComposedFetcherTest >> fetcher [
	
	^ fetcher
]

{ #category : #tests }
ComposedFetcherTest >> setUp [

	super setUp.
	fetcher := InstanceVariableComplishonFetcher new
		andThen: [ GlobalVariableComplishonFetcher new ].
	fetcher
		context:
			(ComplishonContext new
				complishonClass:
					(ComplishonMockClass new
						instanceVariables: {'a' . 'b' . 'c'};
						yourself);
				complishonEnvironment:
					(ComplishonMockEnvironment new
						globals: {'A' . 'B' . 'C'};
						yourself);
				yourself)
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionAtEndShouldBeAtEnd [
	
	self fetcher next: 10.
	self assert: self fetcher atEnd
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionNextManyShouldReturnCollection [

	self assert: (self fetcher next: 5) equals: #(a b c A B)
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionNextManyShouldStopAfterEndOfElements [

	self assert: (self fetcher next: 10) equals: #( a b c A B C )
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionNextShouldReturnFirstValueFirst [

	self assert: self fetcher next equals: 'a'
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionNextShouldReturnNilAfterEnd [

	self fetcher next: 6.
	self assert: self fetcher next equals: nil
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionNextShouldReturnValuesOfSecondComplishonAfterFirst [

	"Consume instance variables"
	self fetcher next: 3.
	self assert: self fetcher next equals: 'A'
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionWithElementsShouldNotBeAtEnd [
	| c |
	c := self fetcher.
	self deny: c atEnd
]
