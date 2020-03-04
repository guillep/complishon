Class {
	#name : #CoGlobalVariableFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoGlobalVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoGlobalVariableFetcher new.
	fetcher complishonEnvironment: self completionEnvironment.
	expectedElements := #(A B C).
]
