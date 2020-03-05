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

	| fetcher entries sorter |
	entries := aNode completionEntries: complishonContext position.
	sorter := complishonContext class sorterClass new context: complishonContext.
	entries := sorter sortCompletionList: entries asOrderedCollection.

	fetcher := (CoCollectionFetcher onCollection: entries).

	^ self
		configureFetcher: fetcher
		forNode: aNode
		narrowingWith: (aNode completionToken: complishonContext position)
]
