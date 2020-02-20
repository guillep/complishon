Class {
	#name : #MethodVariablesFetcherTest,
	#superclass : #BasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
MethodVariablesFetcherTest >> setUp [

	super setUp.
	self context.
	fetcher := MethodVariableComplishonFetcher new.
	fetcher complishonASTNode: innerNode.
	expectedElements := #(blockTemporary blockArgument methodTemporary methodArgument).
]
