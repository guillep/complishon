Class {
	#name : #CoSequenceFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoSequenceFetcherTest >> setUp [

	super setUp.
	fetcher := (CoInstanceVariableFetcher new
			completionClass: self completionClass)
				, (CoGlobalVariableFetcher new
					complishonEnvironment: self completionEnvironment).
	expectedElements := #(a b c A B C)
]

{ #category : #tests }
CoSequenceFetcherTest >> testComplishonCompositionNextManyShouldStopAfterEndOfElements [

	self assert: (self fetcher next: 10) equals: #( a b c A B C )
]

{ #category : #tests }
CoSequenceFetcherTest >> testComplishonCompositionNextShouldReturnValuesOfSecondComplishonAfterFirst [

	"Consume instance variables"
	self fetcher next: 3.
	self assert: self fetcher next equals: 'A'
]

{ #category : #tests }
CoSequenceFetcherTest >> testNextManyAfterFirstSubfetcherShouldReturnCollectionWithSecondSubfetcherElements [

	self assert: (self fetcher next: 5) equals: #(a b c A B)
]
