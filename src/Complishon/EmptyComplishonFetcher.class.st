"
By default I do not nothing. I'm the NullObject of the fetcher hierarchy.
"
Class {
	#name : #EmptyComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #'Complishon-Core'
}

{ #category : #accessing }
EmptyComplishonFetcher >> entriesInContext: aContext do: aBlock [

	"Nothing"
]

{ #category : #accessing }
EmptyComplishonFetcher >> isEmptyComplishonFetcher [
	
	^ true
]
