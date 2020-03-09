Class {
	#name : #CoHierarchyClassVariableFetcherTest,
	#superclass : #CoClassVariableFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoHierarchyClassVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassVariableFetcher new
		completionClass: self completionClass;
		forHierarchy.
	expectedElements := #( Ca Cb Cc SuperCa SuperCb SuperCc )
]
