Class {
	#name : #ClassImplementedMessagesComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
ClassImplementedMessagesComplishonFetcher >> entriesDo: aBlock [
	
	self completionClass selectorsDo: aBlock
]
