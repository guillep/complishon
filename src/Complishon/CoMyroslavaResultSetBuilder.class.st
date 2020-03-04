Class {
	#name : #CoMyroslavaResultSetBuilder,
	#superclass : #CoASTResultSetBuilder,
	#category : #'Complishon-SystemIntegration'
}

{ #category : #visiting }
CoMyroslavaResultSetBuilder >> parseNode [

	| node |
	node := super parseNode.
	node doSemanticAnalysis.
	TypingVisitor new visitNode: node.
	^ node
]

{ #category : #visiting }
CoMyroslavaResultSetBuilder >> visitNode: aNode [

	| fetcher |
	fetcher := (CoGenericFetcher onCollection: 
		(aNode completionEntries: complishonContext position)).

	^ self
		configureFetcher: fetcher
		forNode: aNode
		narrowingWith: (aNode completionToken: complishonContext position)
]
