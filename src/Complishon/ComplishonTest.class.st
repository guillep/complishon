Class {
	#name : #ComplishonTest,
	#superclass : #BasicComplishonTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
ComplishonTest >> testBroadenFilterAfterFetchComplishonShouldBroadenResults [

	| c context |
	(context := self context)
		complishonClass addInstanceVariable: 'ba'.
	c := Complishon
		onContext: context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c filterWithString: 'ba'.
	c fetch: 1.
	c filterWithString: 'b'.
	
	self assert: c first equals: 'b'
]

{ #category : #tests }
ComplishonTest >> testBroaderFilterComplishonShouldBroadenResults [

	| c context |
	(context := self context)
		complishonClass addInstanceVariable: 'ba'.
	c := Complishon
		onContext: context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c filterWithString: 'ba'.
	c filterWithString: 'b'.
	
	self assert: c first equals: 'b'
]

{ #category : #tests }
ComplishonTest >> testComplishonWithElementsToFetchShouldHaveMore [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.

	self assert: c hasMoreElements
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

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	
	self assert: c first equals: 'a'
]

{ #category : #tests }
ComplishonTest >> testFilterComplishonAfterFetchingShouldNarrowResults [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c fetch: 1.
	c filterWithString: 'b'.

	self assert: c first equals: 'b'
]

{ #category : #tests }
ComplishonTest >> testFilterTwiceWithSameCompletionShouldReturnSameResults [

	| c context |
	(context := self context)
		complishonClass addInstanceVariable: 'ba'.
	c := Complishon
		onContext: context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c filterWithString: 'ba'.
	c fetch: 2.
	c filterWithString: 'ba'.

	self assertCollection: (c first: 2) hasSameElements: #('ba')
]

{ #category : #tests }
ComplishonTest >> testNarrowFilterAfterFetchComplishonShouldNarrowResults [

	| c context |
	(context := self context)
		complishonClass addInstanceVariable: 'ba'.
	c := Complishon
		onContext: context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c filterWithString: 'b'.
	c fetch: 1.
	c filterWithString: 'ba'.

	self assert: c first equals: 'ba'
]

{ #category : #tests }
ComplishonTest >> testNarrowerFilterComplishonShouldNarrowResults [

	| c context |
	(context := self context)
		complishonClass addInstanceVariable: 'ba'.
	c := Complishon
		onContext: context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c filterWithString: 'b'.
	c filterWithString: 'ba'.

	self assert: c first equals: 'ba'
]

{ #category : #tests }
ComplishonTest >> testResetFilterShouldRetrievePreviousResults [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c filterWithString: 'b'.
	c fetch: 5.
	c resetFilter.

	self assert: c first equals: 'a'
]

{ #category : #tests }
ComplishonTest >> testResetFilterWithNoFilterSetShouldNotAlterResults [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c resetFilter.

	self assert: c first equals: 'a'
]
