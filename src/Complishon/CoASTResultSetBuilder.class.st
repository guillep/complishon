"
I'm an abstract superclass for defining AST Based Complishons
"
Class {
	#name : #CoASTResultSetBuilder,
	#superclass : #CoResultSetBuilder,
	#instVars : [
		'astNode',
		'node'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #testing }
CoASTResultSetBuilder class >> isAbstract [

	^ self == CoASTResultSetBuilder
]

{ #category : #'API - building' }
CoASTResultSetBuilder >> buildComplishon [

	"Visiting the node configures the completion for that node"
	astNode := self parseNode.
	^ astNode acceptVisitor: self
]

{ #category : #'API - building' }
CoASTResultSetBuilder >> configureEmptyFetcherForNode: aNode [
	
	^ self
		configureFetcher: CoEmptyFetcher new
		forNode: aNode
		narrowingWith: ''
]

{ #category : #'private-building' }
CoASTResultSetBuilder >> configureFetcher: aFetcher forNode: aNode narrowingWith: aString [
	
	| complishon |
	complishon := CoResultSet fetcher: aFetcher.
	complishon filterWithString: aString.
	^ complishon
]

{ #category : #'private-building' }
CoASTResultSetBuilder >> configureFetcherForNode: aNode usingHeuristic: heuristic narrowingWith: aString [
	
	| fetcher |
	fetcher := heuristic fetcherFor: aNode inContext: complishonContext.
	^ self
		configureFetcher: fetcher
		forNode: aNode
		narrowingWith: aString
]

{ #category : #'private-building' }
CoASTResultSetBuilder >> configureFetcherForNode: aNode usingHeuristicAvoidingRepetitions: heuristic narrowingWith: aString [
	
	| fetcher |
	fetcher := heuristic fetcherFor: aNode inContext: complishonContext.
	^ self
		configureFetcher: fetcher withoutRepetition
		forNode: aNode
		narrowingWith: aString
]

{ #category : #accessing }
CoASTResultSetBuilder >> node: aNode [

	node := aNode
]

{ #category : #'API - building' }
CoASTResultSetBuilder >> parseNode [

	^ node ifNil: [ node := (complishonContext isWorkspace
		ifTrue: [ RBParser parseFaultyExpression: complishonContext source ]
		ifFalse: [ RBParser parseFaultyMethod: complishonContext source ])
			nodeForOffset: complishonContext position ]
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitBlockNode: aRBBlockNode [ 

	^ self visitNode: aRBBlockNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitLiteralValueNode: aRBLiteralValueNode [ 
	
	^ self visitNode: aRBLiteralValueNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitMessageNode: aRBMessageNode [
	
	^ self visitNode: aRBMessageNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitMethodNode: aRBMethodNode [
	
	^ self visitNode: aRBMethodNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitNode: aNode [
	
	^ self configureEmptyFetcherForNode: aNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitParseErrorNode: aRBParseErrorNode [ 
	
	^ self visitNode: aRBParseErrorNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitSelfNode: aRBSelfNode [ 
	
	^ self visitNode: aRBSelfNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitSequenceNode: aRBSequenceNode [ 
	
	^ self visitNode: aRBSequenceNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitSuperNode: aRBSuperNode [ 
	
	^ self visitNode: aRBSuperNode
]

{ #category : #visiting }
CoASTResultSetBuilder >> visitVariableNode: aRBVariableNode [
	
	^ self visitNode: aRBVariableNode
]
