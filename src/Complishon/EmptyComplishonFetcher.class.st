Class {
	#name : #EmptyComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #Complishon
}

{ #category : #accessing }
EmptyComplishonFetcher >> entriesInContext: aContext do: aBlock [

	"Nothing"
]

{ #category : #accessing }
EmptyComplishonFetcher >> isEmptyComplishonFetcher [
	
	^ true
]
