Class {
	#name : #GlobalVariableFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
GlobalVariableFetcherTest >> setUp [

	super setUp.
	fetcher := GlobalVariableComplishonFetcher new.
	fetcher complishonEnvironment: self context complishonEnvironment.
	expectedElements := #(A B C).
]
