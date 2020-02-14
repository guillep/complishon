Class {
	#name : #InstanceVariableComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #Complishon
}

{ #category : #entries }
InstanceVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	self completionClass instVarNames do: aBlock
]
