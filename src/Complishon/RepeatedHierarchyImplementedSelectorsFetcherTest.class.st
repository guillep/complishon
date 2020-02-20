Class {
	#name : #RepeatedHierarchyImplementedSelectorsFetcherTest,
	#superclass : #ImplementedSelectorsFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
RepeatedHierarchyImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := (ClassImplementedMessagesComplishonFetcher new
		completionClass: self context complishonClass;
		forHierarchy)
		withoutRepetition.
	self context complishonClass superclass
		selectors: (self context complishonClass superclass selectors copyWith: 'ma').
	expectedElements := #(ma mb mc superma supermb supermc).
]
