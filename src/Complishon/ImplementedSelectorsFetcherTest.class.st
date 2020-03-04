Class {
	#name : #ImplementedSelectorsFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
ImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassImplementedMessagesFetcher new.
	fetcher completionClass: self context complishonClass.
	expectedElements := #(ma mb mc).
]
