"
I'm a fetcher composed of a sequence of subfetchers. 
When executed, I execute my subfetchers one by one.

Sequences are created by sending the message #, between two fetchers.
"
Class {
	#name : #ComplishonFetcherSequence,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'subcomplishons'
	],
	#category : #'Complishon-Core'
}

{ #category : #adding }
ComplishonFetcherSequence >> add: aComplishon [
	
	subcomplishons add: aComplishon
]

{ #category : #resetting }
ComplishonFetcherSequence >> context: anObject [
	
	super context: anObject.
	subcomplishons do: [ :each | each context: anObject ]
]

{ #category : #accessing }
ComplishonFetcherSequence >> entriesDo: aBlock [
	subcomplishons do: [ :complishon | complishon entriesDo: aBlock ]
]

{ #category : #adding }
ComplishonFetcherSequence >> initialize [

	super initialize.
	subcomplishons := OrderedCollection new
]

{ #category : #resetting }
ComplishonFetcherSequence >> reset [
	
	super reset.
	subcomplishons do: [ :each | each reset ].
]
