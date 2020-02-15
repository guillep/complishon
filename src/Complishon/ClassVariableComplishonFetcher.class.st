Class {
	#name : #ClassVariableComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
ClassVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	self completionClass instanceSide classVarNames do: aBlock
]
