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
GenericComplishonFetcher >> entriesInContext: aContext do: aBlock [

	collection do: aBlock
]
