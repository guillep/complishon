Class {
	#name : #CoAvoidRepeatedFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
CoAvoidRepeatedFetcherTest >> setUp [

	super setUp.
	fetcher := CoAvoidRepeatedFetcher new
		decoree: (CoGenericFetcher onCollection: #( a b b a c )).
	expectedElements := #(a b c).
]
