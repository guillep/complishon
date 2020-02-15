Class {
	#name : #BasicFetcherWithElementsTest,
	#superclass : #BasicFetcherTest,
	#instVars : [
		'expectedElements'
	],
	#category : #'Complishon-Tests'
}

{ #category : #testing }
BasicFetcherWithElementsTest class >> isAbstract [

	^ self == BasicFetcherWithElementsTest
]

{ #category : #helpers }
BasicFetcherWithElementsTest >> firstExpectedElement [

	^ expectedElements first
]

{ #category : #helpers }
BasicFetcherWithElementsTest >> secondExpectedElement [

	^ expectedElements second
]

{ #category : #tests }
BasicFetcherWithElementsTest >> testNewFetcherWithElementsShouldNotBeAtEnd [

	self deny: self fetcher atEnd
]

{ #category : #tests }
BasicFetcherWithElementsTest >> testNextManyAfterLimitShouldStopAfterLimit [

	self assert: (self fetcher next: expectedElements size + 1) equals: expectedElements
]

{ #category : #tests }
BasicFetcherWithElementsTest >> testNextManyShouldReturnCollection [

	self assert: (self fetcher next: 2) equals: { self firstExpectedElement . self secondExpectedElement }
]

{ #category : #tests }
BasicFetcherWithElementsTest >> testNextNextShouldReturnSecondExpectedElement [

	self fetcher next.
	self assert: self fetcher next equals: self secondExpectedElement
]

{ #category : #tests }
BasicFetcherWithElementsTest >> testNextShouldReturnFirstElement [

	self assert: self fetcher next equals: self firstExpectedElement
]

{ #category : #tests }
BasicFetcherWithElementsTest >> testResetShouldRestartGenerator [

	self fetcher upToEnd; reset.
	self assert: (self fetcher next: expectedElements size + 1) equals: expectedElements
]
