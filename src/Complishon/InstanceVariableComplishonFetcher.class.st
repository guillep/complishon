Class {
	#name : #InstanceVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #Complishon
}

{ #category : #entries }
InstanceVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [
	aContext complishonClass instVarNames do: aBlock
]
