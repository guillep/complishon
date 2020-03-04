"
I am a null fetcher heuristic, returning an empty fetcher
"
Class {
	#name : #CoNullFetcherHeuristic,
	#superclass : #Object,
	#category : #'Complishon-Heuristics'
}

{ #category : #requests }
CoNullFetcherHeuristic >> fetcherFor: aNode inContext: anObject [

	^ CoEmptyFetcher new
]
