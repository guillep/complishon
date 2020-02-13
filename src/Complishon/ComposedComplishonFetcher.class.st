Class {
	#name : #ComposedComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'subcomplishons'
	],
	#category : #Complishon
}

{ #category : #adding }
ComposedComplishonFetcher >> add: aComplishon [
	
	subcomplishons add: aComplishon
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
