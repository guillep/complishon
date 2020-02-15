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
