Class {
	#name : #FilterFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
FilterFetcherTest >> setUp [

	super setUp.
	fetcher := CoInstanceVariableFetcher new.
	fetcher completionClass: self context complishonClass.
	fetcher := fetcher select: [ :e | (e contents beginsWith: 'a') not ].
	expectedElements := #(b c).
]
