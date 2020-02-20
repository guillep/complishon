Class {
	#name : #InstanceVariableComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
InstanceVariableComplishonFetcher >> entriesDo: aBlock [
	
	self completionClass instVarNames do: aBlock
]
