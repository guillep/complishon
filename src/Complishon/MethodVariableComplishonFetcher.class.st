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
		"ASTs are strange.
		There is no way to ask the variables defined in the scope in an ordered way.
		Hack our way through"
		self flag: #notNice.
		currentNode isSequence ifTrue: [ 
			currentNode temporaryNames do: aBlock.
			currentNode parent argumentNames do: aBlock ].
		currentNode := currentNode parent ]
]
