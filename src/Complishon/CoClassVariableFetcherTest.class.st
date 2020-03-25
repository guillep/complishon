Class {
	#name : #CoClassVariableFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoClassVariableFetcherTest >> setUp [

	super setUp.
	fetcher := CoClassVariableFetcher new.
	fetcher completionClass: self completionClass.
	expectedElements := { 
		NECClassVarEntry contents: 'Ca' node: nil. 
		NECClassVarEntry contents: 'Cb' node: nil.
		NECClassVarEntry contents: 'Cc' node: nil.}
]
