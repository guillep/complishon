Class {
	#name : #ClassVariableFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ClassVariableFetcherTest >> setUp [

	super setUp.
	fetcher := ClassVariableComplishonFetcher new.
	fetcher context: self context.
	expectedElements := #( Ca Cb Cc )
]
