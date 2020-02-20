Class {
	#name : #ImplementedSelectorsFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
ImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := ClassImplementedMessagesComplishonFetcher new.
	fetcher completionClass: self context complishonClass.
	expectedElements := #(ma mb mc).
]
