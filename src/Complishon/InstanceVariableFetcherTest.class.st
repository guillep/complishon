Class {
	#name : #InstanceVariableFetcherTest,
	#superclass : #BasicComplishonTest,
	#instVars : [
		'fetcher'
	],
	#category : #'Complishon-Tests'
}

{ #category : #tests }
InstanceVariableFetcherTest >> fetcher [

	^ fetcher
]

{ #category : #tests }
InstanceVariableFetcherTest >> setUp [

	super setUp.
	fetcher := InstanceVariableComplishonFetcher new.
	fetcher
		context:
			(ComplishonContext new
				complishonClass:
					(ComplishonMockClass new
						instanceVariables: {'a' . 'b' . 'c'};
						yourself);
				complishonEnvironment:
					(ComplishonMockEnvironment new
						globals: {'A' . 'B' . 'C'};
						yourself);
				yourself)
]

{ #category : #tests }
InstanceVariableFetcherTest >> testInstanceVariableComplishonAtEndShouldBeAtEnd [
	
	self fetcher next: 3.
	self assert: self fetcher atEnd
]

{ #category : #tests }
InstanceVariableFetcherTest >> testInstanceVariableComplishonNextManyShouldReturnCollection [

	self assert: (self fetcher next: 2) equals: #('a' 'b')
]

{ #category : #tests }
InstanceVariableFetcherTest >> testInstanceVariableComplishonNextManyShouldStopAfterEndOfElements [

	self assert: (self fetcher next: 10) equals: #('a' 'b' 'c')
]

{ #category : #tests }
InstanceVariableFetcherTest >> testInstanceVariableComplishonNextShouldReturnAfterSecondInstanceVariable [

	self fetcher next.
	self assert: self fetcher next equals: 'b'
]

{ #category : #tests }
InstanceVariableFetcherTest >> testInstanceVariableComplishonNextShouldReturnFirstInstanceVariable [

	self assert: self fetcher next equals: 'a'
]

{ #category : #tests }
InstanceVariableFetcherTest >> testInstanceVariableComplishonNextShouldReturnNilAfterEnd [

	self fetcher
		next;
		next;
		next.
	self assert: self fetcher next equals: nil
]

{ #category : #tests }
InstanceVariableFetcherTest >> testInstanceVariableComplishonWithElementsShouldNotBeAtEnd [

	self deny: self fetcher atEnd
]
