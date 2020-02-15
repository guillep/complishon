Class {
	#name : #MethodVariablesFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
MethodVariablesFetcherTest >> setUp [

	super setUp.
	fetcher := MethodVariableComplishonFetcher new.
	fetcher context: self context.
	expectedElements := #(blockTemporary blockArgument methodTemporary methodArgument).
]
