Class {
	#name : #CoImplementedSelectorsFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
CoImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassImplementedMessagesFetcher new.
	fetcher completionClass: self completionClass.
	expectedElements := #(ma mb mc).
]
