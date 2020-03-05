Class {
	#name : #CoStatisticsHeuristicWrapper,
	#superclass : #CoASTNodeFetcherHeuristic,
	#instVars : [
		'wrapped'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #requests }
CoStatisticsHeuristicWrapper >> appliesForNode: aNode inContext: aContext [

	^ wrapped appliesForNode: aNode inContext: aContext
]

{ #category : #requests }
CoStatisticsHeuristicWrapper >> buildFetcherFor: aNode inContext: aContext [

	| fetcher wrappedFetcher |
	fetcher := wrapped buildFetcherFor: aNode inContext: aContext.
	wrappedFetcher := fetcher collect: [ :e |
		(CoStatisticsCompletionEntry on: e)
			heuristic: self next;
			yourself ].
	^ wrappedFetcher, (self next fetcherFor: aNode inContext: aContext)
]

{ #category : #testing }
CoStatisticsHeuristicWrapper >> isStatisticsHeuristicWrapper [
	
	^ true
]

{ #category : #accessing }
CoStatisticsHeuristicWrapper >> wrapped [
	^ wrapped
]

{ #category : #accessing }
CoStatisticsHeuristicWrapper >> wrapped: anObject [
	wrapped := anObject
]
