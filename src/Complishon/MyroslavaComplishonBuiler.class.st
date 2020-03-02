Class {
	#name : #MyroslavaComplishonBuiler,
	#superclass : #ComplishonASTBuilder,
	#category : #'Complishon-SystemIntegration'
}

{ #category : #visiting }
MyroslavaComplishonBuiler >> visitNode: aNode [

	^ self
		configureFetcherForNode: aNode
		using: (GenericComplishonFetcher
			onCollection: (aNode completionEntries: complishonContext position))
		narrowingWith: (aNode completionToken: complishonContext position)
]
