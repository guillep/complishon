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

{ #category : #resetting }
ComplishonFetcherDecorator >> reset [

	super reset.
	decoree reset.
]
