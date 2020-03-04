Class {
	#name : #ClassVariableFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ClassVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassVariableFetcher new.
	fetcher completionClass: self context complishonClass.
	expectedElements := #( Ca Cb Cc )
]
