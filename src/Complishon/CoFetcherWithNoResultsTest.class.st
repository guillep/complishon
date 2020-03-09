Class {
	#name : #CoFetcherWithNoResultsTest,
	#superclass : #CoBasicFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoFetcherWithNoResultsTest >> setUp [

	super setUp.
	fetcher := CoInstanceVariableFetcher new.
	fetcher completionClass: self completionClass.
	fetcher := fetcher select: [ :e | false ].
]

{ #category : #tests }
CoFetcherWithNoResultsTest >> testComplishonWithNoResultsShouldBeAtEnd [

	self assert: self fetcher atEnd
]
