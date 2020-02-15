Class {
	#name : #ComplishonFetcherTest,
	#superclass : #BasicFetcherTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ComplishonFetcherTest >> setUp [

	super setUp.
	fetcher := InstanceVariableComplishonFetcher new.
	fetcher context: self context.
	fetcher := fetcher select: [ :e | false ].
]

{ #category : #tests }
ComplishonFetcherTest >> testComplishonWithNoResultsShouldBeAtEnd [

	self assert: self fetcher atEnd
]
