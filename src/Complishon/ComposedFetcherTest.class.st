Class {
	#name : #ComposedFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ComposedFetcherTest >> setUp [

	super setUp.
	fetcher := (InstanceVariableComplishonFetcher new
			completionClass: self context complishonClass)
				andThen: [ GlobalVariableComplishonFetcher new
					complishonEnvironment: self context complishonEnvironment ].
	expectedElements := #(a b c A B C)
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionNextManyShouldStopAfterEndOfElements [

	self assert: (self fetcher next: 10) equals: #( a b c A B C )
]

{ #category : #tests }
ComposedFetcherTest >> testComplishonCompositionNextShouldReturnValuesOfSecondComplishonAfterFirst [

	"Consume instance variables"
	self fetcher next: 3.
	self assert: self fetcher next equals: 'A'
]

{ #category : #tests }
ComposedFetcherTest >> testNextManyAfterFirstSubfetcherShouldReturnCollectionWithSecondSubfetcherElements [

	self assert: (self fetcher next: 5) equals: #(a b c A B)
]
