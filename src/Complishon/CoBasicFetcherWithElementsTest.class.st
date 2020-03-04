Class {
	#name : #CoBasicFetcherWithElementsTest,
	#superclass : #CoBasicFetcherTest,
	#instVars : [
		'expectedElements'
	],
	#category : #'Complishon-Tests'
}

{ #category : #testing }
CoBasicFetcherWithElementsTest class >> isAbstract [

	^ self == CoBasicFetcherWithElementsTest
]

{ #category : #helpers }
CoBasicFetcherWithElementsTest >> firstExpectedElement [

	^ expectedElements first
]

{ #category : #helpers }
CoBasicFetcherWithElementsTest >> secondExpectedElement [

	^ expectedElements second
]

{ #category : #tests }
CoBasicFetcherWithElementsTest >> testNewFetcherWithElementsShouldNotBeAtEnd [

	self deny: self fetcher atEnd
]

{ #category : #tests }
CoBasicFetcherWithElementsTest >> testNextManyAfterLimitShouldStopAfterLimit [

	self assert: (self fetcher next: expectedElements size + 1) equals: expectedElements
]

{ #category : #tests }
CoBasicFetcherWithElementsTest >> testNextManyShouldReturnCollection [

	self assert: (self fetcher next: 2) equals: { self firstExpectedElement . self secondExpectedElement }
]

{ #category : #tests }
CoBasicFetcherWithElementsTest >> testNextNextShouldReturnSecondExpectedElement [

	self fetcher next.
	self assert: self fetcher next equals: self secondExpectedElement
]

{ #category : #tests }
CoBasicFetcherWithElementsTest >> testNextShouldReturnFirstElement [

	self assert: self fetcher next equals: self firstExpectedElement
]

{ #category : #tests }
CoBasicFetcherWithElementsTest >> testResetShouldRestartGenerator [

	self fetcher upToEnd; reset.
	self assert: (self fetcher next: expectedElements size + 1) equals: expectedElements
]
