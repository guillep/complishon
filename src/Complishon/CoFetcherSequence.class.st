"
I'm a fetcher composed of a sequence of subfetchers. 
When executed, I execute my subfetchers one by one.

Sequences are created by sending the message #, between two fetchers.
"
Class {
	#name : #CoFetcherSequence,
	#superclass : #CoFetcher,
	#instVars : [
		'subcomplishons'
	],
	#category : #'Complishon-Core'
}

{ #category : #adding }
CoFetcherSequence >> add: aComplishon [
	
	subcomplishons add: aComplishon
]

{ #category : #resetting }
CoFetcherSequence >> context: anObject [
	
	super context: anObject.
	subcomplishons do: [ :each | each context: anObject ]
]

{ #category : #accessing }
CoFetcherSequence >> entriesDo: aBlock [
	subcomplishons do: [ :complishon | complishon entriesDo: aBlock ]
]

{ #category : #adding }
CoFetcherSequence >> initialize [

	super initialize.
	subcomplishons := OrderedCollection new
]

{ #category : #resetting }
CoFetcherSequence >> reset [
	
	super reset.
	subcomplishons do: [ :each | each reset ].
]
