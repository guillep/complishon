Class {
	#name : #InstanceVariableComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
InstanceVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	self completionClass instVarNames do: aBlock
]
