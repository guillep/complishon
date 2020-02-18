"
I'm a fetcher composed of a sequence of subfetchers. 
When executed, I execute my subfetchers one by one.
"
Class {
	#name : #ComposedComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'subcomplishons'
	],
	#category : #'Complishon-Core'
}

{ #category : #adding }
ComposedComplishonFetcher >> add: aComplishon [
	
	subcomplishons add: aComplishon
]

{ #category : #resetting }
ComposedComplishonFetcher >> context: anObject [
	
	super context: anObject.
	subcomplishons do: [ :each | each context: anObject ]
]

{ #category : #accessing }
ComposedComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	subcomplishons do: [ :complishon |
		complishon entriesInContext: aContext do: aBlock ]
]

{ #category : #adding }
ComposedComplishonFetcher >> initialize [

	super initialize.
	subcomplishons := OrderedCollection new
]

{ #category : #resetting }
ComposedComplishonFetcher >> reset [
	
	super reset.
	subcomplishons do: [ :each | each reset ].
]
