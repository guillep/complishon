"
I'm a fetcher simply enumerating a collection of items defined using the collection: message.
Mainly used for testing.
"
Class {
	#name : #CoGenericFetcher,
	#superclass : #CoFetcher,
	#instVars : [
		'collection'
	],
	#category : #'Complishon-Core'
}

{ #category : #'instance creation' }
CoGenericFetcher class >> onCollection: aCollection [ 
	
	^ self new
		collection: aCollection;
		yourself
]

{ #category : #accessing }
CoGenericFetcher >> collection: aCollection [ 
	collection := aCollection
]

{ #category : #accessing }
CoGenericFetcher >> entriesDo: aBlock [

	collection do: aBlock
]
