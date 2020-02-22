"
I am a fetcher looking for the messages implemented in a class.
"
Class {
	#name : #ClassImplementedMessagesComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
ClassImplementedMessagesComplishonFetcher >> entriesDo: aBlock [
	
	self completionClass selectorsDo: aBlock
]
