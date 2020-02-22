"
I am an abstract decorator superclass encapsulating common tasks that should be done with my decoree.
I am a complishon fetcher exposing the same API, and redirecting it to my decoree by default.
My decoree is also a complishon fetcher.
"
Class {
	#name : #ComplishonFetcherDecorator,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'decoree'
	],
	#category : #'Complishon-Core'
}

{ #category : #testing }
ComplishonFetcherDecorator class >> isAbstract [

	^ self == ComplishonFetcherDecorator
]

{ #category : #accessing }
ComplishonFetcherDecorator >> decoree: anotherFetcher [
	
	decoree := anotherFetcher
]

{ #category : #resetting }
ComplishonFetcherDecorator >> reset [

	super reset.
	decoree reset.
]
