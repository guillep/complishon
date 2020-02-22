"
I am a fetcher looking for the instance variables implemented in a class.
"
Class {
	#name : #InstanceVariableComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
InstanceVariableComplishonFetcher >> entriesDo: aBlock [
	
	self completionClass instVarNames do: aBlock
]
