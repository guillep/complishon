Class {
	#name : #ClassVariableComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
ClassVariableComplishonFetcher >> entriesDo: aBlock [
	
	self completionClass instanceSide classVarNames do: aBlock
]
