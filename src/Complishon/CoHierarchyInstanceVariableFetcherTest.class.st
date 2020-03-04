Class {
	#name : #CoHierarchyInstanceVariableFetcherTest,
	#superclass : #CoInstanceVariableFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoHierarchyInstanceVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoInstanceVariableFetcher new
		completionClass: self completionClass;
		forHierarchy.
	expectedElements := #( a b c supera superb superc )
]
