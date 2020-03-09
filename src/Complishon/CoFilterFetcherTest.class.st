Class {
	#name : #CoFilterFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoFilterFetcherTest >> setUp [

	super setUp.
	fetcher := CoInstanceVariableFetcher new.
	fetcher completionClass: self completionClass.
	fetcher := fetcher select: [ :e | (e contents beginsWith: 'a') not ].
	expectedElements := #(b c).
]
