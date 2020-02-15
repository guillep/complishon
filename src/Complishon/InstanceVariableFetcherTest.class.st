Class {
	#name : #InstanceVariableFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
InstanceVariableFetcherTest >> setUp [

	super setUp.
	fetcher := InstanceVariableComplishonFetcher new.
	fetcher context: self context.
	expectedElements := #( a b c )
]
