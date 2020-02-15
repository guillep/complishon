Class {
	#name : #BasicFetcherTest,
	#superclass : #BasicComplishonTest,
	#instVars : [
		'fetcher'
	],
	#category : #'Complishon-Tests'
}

{ #category : #testing }
BasicFetcherTest class >> isAbstract [

	^ self == BasicFetcherTest
]

{ #category : #accessing }
BasicFetcherTest >> fetcher [
	^ fetcher
]

{ #category : #tests }
BasicFetcherTest >> testConsumedFetcherShouldBeAtEnd [
	
	self fetcher upToEnd.
	self assert: self fetcher atEnd
]

{ #category : #tests }
BasicFetcherTest >> testNextShouldReturnNilAfterEnd [

	self fetcher upToEnd.
	self assert: self fetcher next equals: nil
]
