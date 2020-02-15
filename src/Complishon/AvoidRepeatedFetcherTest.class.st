Class {
	#name : #AvoidRepeatedFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
AvoidRepeatedFetcherTest >> setUp [

	super setUp.
	fetcher := AvoidRepeatedComplishonFetcher new
		complishonFetcher: (GenericComplishonFetcher onCollection: #( a b b a c )).
	fetcher context: self context.
	expectedElements := #(a b c).
]
