Class {
	#name : #FilterComplishonTest,
	#superclass : #ComplishonTest,
	#category : #Complishon
}

{ #category : #tests }
FilterComplishonTest >> testBroadenFilterAfterFetchComplishonShouldBroadenResults [

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
FilterComplishonTest >> testBroaderFilterComplishonShouldBroadenResults [

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
FilterComplishonTest >> testComplishonWithElementsToFetchShouldHaveMore [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.

	self assert: c hasMoreElements
]

{ #category : #tests }
FilterComplishonTest >> testComplishonWithNoElementsToFetchShouldNotHaveMore [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	c fetchAll.	
	self deny: c hasMoreElements
]

{ #category : #tests }
FilterComplishonTest >> testEnumerateShouldFetch [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	
	self assert: c first equals: 'a'
]

{ #category : #tests }
FilterComplishonTest >> testFilterComplishonAfterFetchingShouldNarrowResults [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c fetch: 1.
	c filterWithString: 'b'.

	self assert: c first equals: 'b'
]

{ #category : #tests }
FilterComplishonTest >> testNarrowFilterAfterFetchComplishonShouldNarrowResults [

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
FilterComplishonTest >> testNarrowerFilterComplishonShouldNarrowResults [

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
FilterComplishonTest >> testResetFilterShouldRetrievePreviousResults [

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
FilterComplishonTest >> testResetFilterWithNoFilterSetShouldNotAlterResults [

	| c |
	c := Complishon
		onContext: self context
		fetcher: InstanceVariableComplishonFetcher new.
	
	c resetFilter.

	self assert: c first equals: 'a'
]
