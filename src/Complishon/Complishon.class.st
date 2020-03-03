"
I am the main entry point of the completion system.
I am built from a (potentially composed) fetcher and a filter-string.

When asked for results, I fetch them from the fetcher.
Internally, I keep also a list of already fetched results to avoid fetching many times the same.
This is particularly useful when the filter is being narrowed (e.g., we go from a filter 'ab' to a filter 'abc').
In such a case, some of the results already fetched are still valid, and the fetcher state is valid too.
  => we then filter the subresults and change the fetcher filter
In case the filter is being broadened (e.g., we go from 'abc' to 'ab'), all results we already have are valid, but probably lots of other results were filtered already. So we reset both the results and the fetcher and restart the search.
"
Class {
	#name : #Complishon,
	#superclass : #Object,
	#instVars : [
		'results',
		'fetcher',
		'completionString'
	],
	#category : #'Complishon-Core'
}

{ #category : #'instance creation' }
Complishon class >> fetcher: aFetcher [
	
	^ self new
		fetcher: aFetcher;
		yourself
]

{ #category : #'instance creation' }
Complishon class >> onContext: aComplishonContext fetcher: aFetcher [
	
	^ self new
		fetcher: aFetcher;
		yourself
]

{ #category : #accessing }
Complishon >> completionToken [
	
	^ completionString
]

{ #category : #enumerating }
Complishon >> ensureResults: aSize [
	
	results size >= aSize ifTrue: [ ^ self ].
	self fetch: aSize - results size.
]

{ #category : #fetching }
Complishon >> fetch: anInteger [ 
	
	| newResults |
	newResults := fetcher next: anInteger.
	results addAll: newResults
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

	fetcher := anObject
]

{ #category : #'api-filtering' }
Complishon >> filterWithString: aString [ 
	
	"Narrow results"
	aString size >= completionString size
		ifTrue: [ 
			"Filter existing results".
			fetcher := fetcher narrowFilterBlock: [ :e | aString isEmpty or: [ e contents beginsWith: aString ] ].
			results := results select: [ :e | aString isEmpty or: [ e contents beginsWith: aString ] ] ]
		ifFalse: [
			"Smaller filter, reset results and filter"
			results := OrderedCollection new.
			fetcher reset.
			fetcher := fetcher select: [ :e | aString isEmpty or: [ e contents beginsWith: aString ] ].
		].
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
	completionString := ''.
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
