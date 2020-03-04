Class {
	#name : #HierarchyImplementedSelectorsFetcherTest,
	#superclass : #ImplementedSelectorsFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
HierarchyImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassImplementedMessagesFetcher new
		completionClass: self context complishonClass;
		forHierarchy.
	expectedElements := #(ma mb mc superma supermb supermc).
]
