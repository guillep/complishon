Class {
	#name : #ComplishonTest,
	#superclass : #BasicComplishonTest,
	#instVars : [
		'complishon'
	],
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ComplishonTest >> setUp [

	| context |
	super setUp.
	(context := self context)
		complishonClass addInstanceVariable: 'ba'.
	complishon := Complishon
		onContext: context
		fetcher: InstanceVariableComplishonFetcher new
]

{ #category : #tests }
ComplishonTest >> testBroadenFilterAfterFetchComplishonShouldBroadenResults [

	complishon filterWithString: 'ba'.
	complishon fetch: 1.
	complishon filterWithString: 'b'.
	
	self assert: complishon first equals: 'b'
]

{ #category : #tests }
ComplishonTest >> testBroaderFilterComplishonShouldBroadenResults [

	complishon filterWithString: 'ba'.
	complishon filterWithString: 'b'.
	
	self assert: complishon first equals: 'b'
]

{ #category : #tests }
ComplishonTest >> testComplishonWithElementsToFetchShouldHaveMore [

	self assert: complishon hasMoreElements
]

{ #category : #tests }
ComplishonTest >> testComplishonWithNoElementsToFetchShouldNotHaveMore [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	c fetchAll.	
	self deny: c hasMoreElements
]

{ #category : #tests }
ComplishonTest >> testEnumerateShouldFetch [

	self assert: complishon first equals: 'a'
]

{ #category : #tests }
ComplishonTest >> testFilterComplishonAfterFetchingShouldNarrowResults [

	complishon fetch: 1.
	complishon filterWithString: 'b'.

	self assert: complishon first equals: 'b'
]

{ #category : #tests }
ComplishonTest >> testFilterTwiceWithSameCompletionShouldReturnSameResults [
	
	complishon filterWithString: 'ba'.
	complishon fetch: 2.
	complishon filterWithString: 'ba'.

	self assertCollection: (complishon first: 2) hasSameElements: #('ba')
]

{ #category : #tests }
ComplishonTest >> testNarrowFilterAfterFetchComplishonShouldNarrowResults [

	complishon filterWithString: 'b'.
	complishon fetch: 1.
	complishon filterWithString: 'ba'.

	self assert: complishon first equals: 'ba'
]

{ #category : #tests }
ComplishonTest >> testNarrowerFilterComplishonShouldNarrowResults [

	complishon filterWithString: 'b'.
	complishon filterWithString: 'ba'.

	self assert: complishon first equals: 'ba'
]

{ #category : #tests }
ComplishonTest >> testResetFilterShouldRetrievePreviousResults [

	complishon filterWithString: 'b'.
	complishon fetch: 5.
	complishon resetFilter.

	self assert: complishon first equals: 'a'
]

{ #category : #tests }
ComplishonTest >> testResetFilterWithNoFilterSetShouldNotAlterResults [

	complishon resetFilter.

	self assert: complishon first equals: 'a'
]
