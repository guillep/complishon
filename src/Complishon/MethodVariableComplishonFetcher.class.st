"
I am a complishon fetcher that autocompletes variable names accessible in the lexical context of a method.
That is, block temporaries, block arguments, method temporaries and method arguments.

From a given ast node, I walk up the tree looking for scopes and yield the variables I find.
"
Class {
	#name : #MethodVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'complishonASTNode'
	],
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
MethodVariableComplishonFetcher >> complishonASTNode [
	^ complishonASTNode
]

{ #category : #accessing }
MethodVariableComplishonFetcher >> complishonASTNode: anObject [
	complishonASTNode := anObject
]

{ #category : #accessing }
MethodVariableComplishonFetcher >> entriesDo: aBlock [

	| currentNode |
	currentNode := complishonASTNode.
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
