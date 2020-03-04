Class {
	#name : #CoHierarchyImplementedSelectorsFetcherTest,
	#superclass : #CoImplementedSelectorsFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
CoHierarchyImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassImplementedMessagesFetcher new
		completionClass: self completionClass;
		forHierarchy.
	expectedElements := #(ma mb mc superma supermb supermc).
]
