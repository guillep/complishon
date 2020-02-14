Class {
	#name : #ClassImplementedMessagesComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
ClassImplementedMessagesComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	self completionClass selectorsDo: aBlock
]
