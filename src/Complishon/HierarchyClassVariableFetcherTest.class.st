Class {
	#name : #HierarchyClassVariableFetcherTest,
	#superclass : #ClassVariableFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
HierarchyClassVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassVariableFetcher new
		completionClass: self context complishonClass;
		forHierarchy.
	expectedElements := #( Ca Cb Cc SuperCa SuperCb SuperCc )
]
