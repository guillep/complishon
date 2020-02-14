Class {
	#name : #ClassVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
ClassVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [
	aContext complishonClass instanceSide classVarNames do: aBlock
]
