Class {
	#name : #HierarchyImplementedSelectorsFetcherTest,
	#superclass : #ImplementedSelectorsFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
HierarchyImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := ClassImplementedMessagesComplishonFetcher new
		completionClass: self context complishonClass;
		forHierarchy.
	fetcher context: self context.
	expectedElements := #(ma mb mc superma supermb supermc).
]
