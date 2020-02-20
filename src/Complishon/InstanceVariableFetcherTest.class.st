Class {
	#name : #InstanceVariableFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
InstanceVariableFetcherTest >> setUp [

	super setUp.
	fetcher := InstanceVariableComplishonFetcher new.
	fetcher completionClass: self context complishonClass.
	expectedElements := #( a b c )
]
