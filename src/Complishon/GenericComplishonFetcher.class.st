"
I'm a fetcher simply enumerating a collection of items defined using the collection: message.
"
Class {
	#name : #GenericComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'collection'
	],
	#category : #'Complishon-Core'
}

{ #category : #'instance creation' }
GenericComplishonFetcher class >> onCollection: aCollection [ 
	
	^ self new
		collection: aCollection;
		yourself
]

{ #category : #accessing }
GenericComplishonFetcher >> collection: aCollection [ 
	collection := aCollection
]

{ #category : #accessing }
GenericComplishonFetcher >> entriesDo: aBlock [

	collection do: aBlock
]
