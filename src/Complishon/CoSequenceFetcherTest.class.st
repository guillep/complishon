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
	expectedElements := { 
		NECInstVarEntry contents: 'a' node: nil. 
		NECInstVarEntry contents: 'b' node: nil.
		NECInstVarEntry contents: 'c' node: nil.
		NECGlobalEntry contents: 'A' node: nil. 
		NECGlobalEntry contents: 'B' node: nil.
		NECGlobalEntry contents: 'C' node: nil. }
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
