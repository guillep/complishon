Class {
	#name : #ImplementedSelectorsFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
ImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := ClassImplementedMessagesComplishonFetcher new.
	fetcher context: self context.
	expectedElements := #(ma mb mc).
]
