"
I'm a fetcher decorator. I ensure that I will not return twice the same entity.
"
Class {
	#name : #AvoidRepeatedComplishonFetcher,
	#superclass : #ComplishonFetcherDecorator,
	#instVars : [
		'elements'
	],
	#category : #'Complishon-Core'
}

{ #category : #accessing }
AvoidRepeatedComplishonFetcher >> complishonFetcher: anotherFetcher [
	
	decoree := anotherFetcher
]

{ #category : #accessing }
AvoidRepeatedComplishonFetcher >> entriesDo: aBlock [
	decoree
		entriesDo: [ :elem | 
			(self hasAlreadyReturned: elem)
				ifFalse: [ elements add: elem.
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
	decoree reset.
]
