Class {
	#name : #CoClassVariableFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoClassVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassVariableFetcher new.
	fetcher completionClass: self completionClass.
	expectedElements := #( Ca Cb Cc )
]
