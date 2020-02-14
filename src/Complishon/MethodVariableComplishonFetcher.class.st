Class {
	#name : #MethodVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
MethodVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [

	| currentNode |
	currentNode := aContext complishonASTNode.
	[ currentNode notNil ] whileTrue: [ 
		currentNode allDefinedVariables do: aBlock.
		currentNode := currentNode parent ]
]
