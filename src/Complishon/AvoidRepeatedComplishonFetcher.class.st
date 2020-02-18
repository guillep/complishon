"
I'm a fetcher decorator. I ensure that I will not return twice the same entity.
"
Class {
	#name : #AvoidRepeatedComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'fetcher',
		'elements'
	],
	#category : #'Complishon-Core'
}

{ #category : #accessing }
AvoidRepeatedComplishonFetcher >> complishonFetcher: anotherFetcher [
	
	fetcher := anotherFetcher
]

{ #category : #accessing }
AvoidRepeatedComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	fetcher context: aContext.
	fetcher entriesInContext: aContext do: [ :elem |
		(self hasAlreadyReturned: elem) ifFalse: [ 
			elements add: elem.
			aBlock value: elem ] ]
]

{ #category : #accessing }
AvoidRepeatedComplishonFetcher >> hasAlreadyReturned: anObject [

	^ elements includes: anObject
]

{ #category : #accessing }
AvoidRepeatedComplishonFetcher >> initialize [

	super initialize.
	elements := Set new.
]

{ #category : #accessing }
AvoidRepeatedComplishonFetcher >> reset [

	super reset.
	elements := Set new.
	fetcher reset.
]
