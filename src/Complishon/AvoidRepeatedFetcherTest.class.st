Class {
	#name : #AvoidRepeatedFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
AvoidRepeatedFetcherTest >> setUp [

	super setUp.
	fetcher := CoAvoidRepeatedFetcher new
		decoree: (CoGenericFetcher onCollection: #( a b b a c )).
	expectedElements := #(a b c).
]
