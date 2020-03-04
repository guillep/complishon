Class {
	#name : #HierarchyInstanceVariableFetcherTest,
	#superclass : #InstanceVariableFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
HierarchyInstanceVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoInstanceVariableFetcher new
		completionClass: self context complishonClass;
		forHierarchy.
	expectedElements := #( a b c supera superb superc )
]
