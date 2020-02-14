Class {
	#name : #ClassVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #Complishon
}

{ #category : #entries }
ClassVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [
	aContext complishonClass instanceSide classVarNames do: aBlock
]
