"
I'm an abstract superclass for defining AST Based Complishons
"
Class {
	#name : #ComplishonASTBuilder,
	#superclass : #ComplishonBuilder,
	#instVars : [
		'astNode'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #testing }
ComplishonASTBuilder class >> isAbstract [

	^ self == ComplishonASTBuilder
]

{ #category : #'API - building' }
ComplishonASTBuilder >> buildComplishon [

	"Visiting the node configures the completion for that node"
	astNode := self parseNode.
	^ astNode acceptVisitor: self
]

{ #category : #'API - building' }
ComplishonASTBuilder >> configureEmptyFetcherForNode: aNode [
	
	^ self
		configureFetcher: EmptyComplishonFetcher new
		forNode: aNode
		narrowingWith: ''
]

{ #category : #'private-building' }
ComplishonASTBuilder >> configureFetcher: aFetcher forNode: aNode narrowingWith: aString [
	
	| complishon |
	complishon := Complishon fetcher: aFetcher.
	complishon filterWithString: aString.
	^ complishon
]

{ #category : #'private-building' }
ComplishonASTBuilder >> configureFetcherForNode: aNode usingHeuristic: heuristic narrowingWith: aString [
	
	| fetcher |
	fetcher := heuristic fetcherFor: aNode inContext: complishonContext.
	^ self
		configureFetcher: fetcher
		forNode: aNode
		narrowingWith: aString
]

{ #category : #'private-building' }
ComplishonASTBuilder >> configureFetcherForNode: aNode usingHeuristicAvoidingRepetitions: heuristic narrowingWith: aString [
	
	| fetcher |
	fetcher := heuristic fetcherFor: aNode inContext: complishonContext.
	^ self
		configureFetcher: fetcher withoutRepetition
		forNode: aNode
		narrowingWith: aString
]

{ #category : #'API - building' }
ComplishonASTBuilder >> parseNode [

	^ (complishonContext isWorkspace
		ifTrue: [ RBParser parseFaultyExpression: complishonContext source ]
		ifFalse: [ RBParser parseFaultyMethod: complishonContext source ])
			nodeForOffset: complishonContext position
]

{ #category : #visiting }
ComplishonASTBuilder >> visitBlockNode: aRBBlockNode [ 

	^ self visitNode: aRBBlockNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitLiteralValueNode: aRBLiteralValueNode [ 
	
	^ self visitNode: aRBLiteralValueNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitMessageNode: aRBMessageNode [
	
	^ self visitNode: aRBMessageNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitMethodNode: aRBMethodNode [
	
	^ self visitNode: aRBMethodNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitNode: aNode [
	
	^ self configureEmptyFetcherForNode: aNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitParseErrorNode: aRBParseErrorNode [ 
	
	^ self visitNode: aRBParseErrorNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitSelfNode: aRBSelfNode [ 
	
	^ self visitNode: aRBSelfNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitSequenceNode: aRBSequenceNode [ 
	
	^ self visitNode: aRBSequenceNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitSuperNode: aRBSuperNode [ 
	
	^ self visitNode: aRBSuperNode
]

{ #category : #visiting }
ComplishonASTBuilder >> visitVariableNode: aRBVariableNode [
	
	^ self visitNode: aRBVariableNode
]
