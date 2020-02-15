Class {
	#name : #FilterFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
FilterFetcherTest >> setUp [

	super setUp.
	fetcher := InstanceVariableComplishonFetcher new.
	fetcher context: self context.
	fetcher := fetcher select: [ :e | (e beginsWith: 'a') not ].
	expectedElements := #(b c).
]
