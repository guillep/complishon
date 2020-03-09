Class {
	#name : #CoRepeatedHierarchyImplementedSelectorsFetcherTest,
	#superclass : #CoImplementedSelectorsFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
CoRepeatedHierarchyImplementedSelectorsFetcherTest >> setUp [

	super setUp.
	fetcher := (CoClassImplementedMessagesFetcher new
		completionClass: self completionClass;
		forHierarchy)
		withoutRepetition.
	self completionClass superclass
		selectors: (self completionClass superclass selectors copyWith: 'ma').
	expectedElements := #(ma mb mc superma supermb supermc).
]
