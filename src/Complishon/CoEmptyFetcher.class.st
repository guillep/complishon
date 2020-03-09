"
By default I do not nothing. I'm the NullObject of the fetcher hierarchy.
"
Class {
	#name : #CoEmptyFetcher,
	#superclass : #CoFetcher,
	#category : #'Complishon-Core'
}

{ #category : #accessing }
CoEmptyFetcher >> entriesDo: aBlock [

	"Nothing"
]

{ #category : #accessing }
CoEmptyFetcher >> isEmptyComplishonFetcher [
	
	^ true
]
