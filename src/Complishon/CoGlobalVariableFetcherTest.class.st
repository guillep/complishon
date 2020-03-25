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
	expectedElements := { 
		NECGlobalEntry contents: 'A' node: nil.
		NECGlobalEntry contents: 'B' node: nil. 
		NECGlobalEntry contents: 'C' node: nil. }
]
