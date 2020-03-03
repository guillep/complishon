Class {
	#name : #MyroslavaComplishonBuiler,
	#superclass : #ComplishonASTBuilder,
	#category : #'Complishon-SystemIntegration'
}

{ #category : #visiting }
MyroslavaComplishonBuiler >> parseNode [

	| node |
	node := super parseNode.
	node doSemanticAnalysis.
	TypingVisitor new visitNode: node.
	^ node
]

{ #category : #visiting }
MyroslavaComplishonBuiler >> visitNode: aNode [

	| fetcher |
	fetcher := (GenericComplishonFetcher onCollection: 
		(aNode completionEntries: complishonContext position)).

	^ self
		configureFetcher: fetcher
		forNode: aNode
		narrowingWith: (aNode completionToken: complishonContext position)
]
