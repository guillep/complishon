Class {
	#name : #CoMethodVariablesFetcherTest,
	#superclass : #CoBasicFetcherWithElementsTest,
	#category : #'Complishon-Tests'
}

{ #category : #running }
CoMethodVariablesFetcherTest >> setUp [

	super setUp.
	fetcher := CoMethodVariableFetcher new.
	fetcher complishonASTNode: self innerASTNode.
	expectedElements := #(blockTemporary blockArgument methodTemporary methodArgument).
]
