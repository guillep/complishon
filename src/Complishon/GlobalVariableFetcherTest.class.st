Class {
	#name : #GlobalVariableFetcherTest,
	#superclass : #BasicComplishonTest,
	#instVars : [
		'fetcher'
	],
	#category : #'Complishon-Tests'
}

{ #category : #tests }
GlobalVariableFetcherTest >> setUp [

	super setUp.
	fetcher := GlobalVariableComplishonFetcher new.
	fetcher context: (ComplishonContext new
		complishonClass: (ComplishonMockClass new
			instanceVariables: { 'a' . 'b' . 'c' };
			yourself);
		complishonEnvironment: (ComplishonMockEnvironment new
			globals: { 'A' . 'B' . 'C' };
			yourself);
		yourself).
]

{ #category : #tests }
GlobalVariableFetcherTest >> testGlobalVariableComplishonAtEndShouldBeAtEnd [

	fetcher next: 3.
	self assert: fetcher atEnd
]

{ #category : #tests }
GlobalVariableFetcherTest >> testGlobalVariableComplishonNextManyShouldReturnCollection [

	self assert: (fetcher next: 2) equals: #( 'A' 'B' )
]

{ #category : #tests }
GlobalVariableFetcherTest >> testGlobalVariableComplishonNextManyShouldStopAfterEndOfElements [

	self assert: (fetcher next: 10) equals: #( 'A' 'B' 'C' )
]

{ #category : #tests }
GlobalVariableFetcherTest >> testGlobalVariableComplishonNextShouldReturnAfterSecondGlobalVariable [

	fetcher next.
	self assert: fetcher next equals: 'B'
]

{ #category : #tests }
GlobalVariableFetcherTest >> testGlobalVariableComplishonNextShouldReturnFirstGlobalVariable [

	self assert: fetcher next equals: 'A'
]

{ #category : #tests }
GlobalVariableFetcherTest >> testGlobalVariableComplishonNextShouldReturnNilAfterEnd [

	fetcher next; next; next.
	self assert: fetcher next equals: nil
]

{ #category : #tests }
GlobalVariableFetcherTest >> testGlobalVariableComplishonWithElementsShouldNotBeAtEnd [

	self deny: fetcher atEnd
]
