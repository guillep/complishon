Class {
	#name : #GlobalVariableFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
GlobalVariableFetcherTest >> setUp [

	super setUp.
	fetcher := GlobalVariableComplishonFetcher new.
	fetcher context: self context.
	expectedElements := #(A B C).
]
