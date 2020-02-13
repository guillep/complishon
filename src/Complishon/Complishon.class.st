Class {
	#name : #Complishon,
	#superclass : #Object,
	#instVars : [
		'results',
		'fetcher',
		'context',
		'completionString'
	],
	#category : #Complishon
}

{ #category : #'instance creation' }
Complishon class >> onContext: aComplishonContext fetcher: aFetcher [
	
	^ self new
		context: aComplishonContext;
		fetcher: aFetcher;
		yourself
]

{ #category : #accessing }
Complishon >> context [
	^ context
]

{ #category : #accessing }
Complishon >> context: anObject [
	context := anObject
]

{ #category : #enumerating }
Complishon >> ensureResults: aSize [
	
	results size >= aSize ifTrue: [ ^ self ].
	self fetch: aSize - results size.
]

{ #category : #fetching }
Complishon >> fetch: anInteger [ 
	
	results addAll: (fetcher next: anInteger)
]

{ #category : #fetching }
Complishon >> fetchAll [
	
	results addAll: fetcher upToEnd
]

{ #category : #accessing }
Complishon >> fetcher [
	^ fetcher
]

{ #category : #accessing }
Complishon >> fetcher: anObject [
	fetcher := anObject.
	fetcher context: context
]

{ #category : #'api-filtering' }
Complishon >> filterWithString: aString [ 
	
	completionString size > aString size
		ifTrue: [
			"Reset results"
			results := OrderedCollection new.
			fetcher reset.
		] ifFalse: [ 
			"Filter existing results".
			results := results select: [ :e | aString isEmpty or: [ e beginsWith: aString ] ] ].
	
	"Finally, configure fetcher with new filter, and store new completion string"
	fetcher := fetcher select: [ :e | aString isEmpty or: [ e beginsWith: aString ] ].
	completionString := aString
]

{ #category : #enumerating }
Complishon >> first [
	
	self ensureResults: 1.
	^ results first
]

{ #category : #accessing }
Complishon >> first: anInteger [ 

	self ensureResults: anInteger.	
	
	results size > anInteger
		ifTrue: [ ^ results first: anInteger ].
	^ results
]

{ #category : #testing }
Complishon >> hasMoreElements [
	
	^ fetcher atEnd not
]

{ #category : #accessing }
Complishon >> initialize [

	super initialize.
	results := OrderedCollection new.
	completionString := ''
]

{ #category : #testing }
Complishon >> notEmpty [
	
	^ results notEmpty or: [ fetcher atEnd not ]
]

{ #category : #'api-filtering' }
Complishon >> resetFilter [
	
	results removeAll.
	fetcher := fetcher withoutFilter.
]

{ #category : #accessing }
Complishon >> results [
	^ results
]

{ #category : #accessing }
Complishon >> results: anObject [
	results := anObject
]
