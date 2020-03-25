Class {
	#name : #CoResultSetTest,
	#superclass : #CoBasicCompletionTest,
	#instVars : [
		'completion'
	],
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoResultSetTest >> setUp [

	super setUp.
	self completionClass addInstanceVariable: 'ba'.
	completion := CoResultSet
		fetcher: (CoInstanceVariableFetcher new
			completionClass: self completionClass)
]

{ #category : #tests }
CoResultSetTest >> testBroadenFilterAfterFetchComplishonShouldBroadenResults [

	completion filterWithString: 'ba'.
	completion fetch: 1.
	completion filterWithString: 'b'.
	
	self assert: completion first equals: 'b'
]

{ #category : #tests }
CoResultSetTest >> testBroaderFilterComplishonShouldBroadenResults [

	completion filterWithString: 'ba'.
	completion filterWithString: 'b'.
	
	self assert: completion first equals: 'b'
]

{ #category : #tests }
CoResultSetTest >> testComplishonWithElementsToFetchShouldHaveMore [

	self assert: completion hasMoreElements
]

{ #category : #tests }
CoResultSetTest >> testComplishonWithNoElementsToFetchShouldNotHaveMore [

	| c |
	c := CoResultSet fetcher: (CoInstanceVariableFetcher new
			completionClass: self completionClass).
	c fetchAll.	
	self deny: c hasMoreElements
]

{ #category : #tests }
CoResultSetTest >> testEnumerateShouldFetch [

	self assert: completion first equals: 'a'
]

{ #category : #tests }
CoResultSetTest >> testFilterComplishonAfterFetchingShouldNarrowResults [

	completion fetch: 1.
	completion filterWithString: 'b'.

	self assert: completion first equals: 'b'
]

{ #category : #tests }
CoResultSetTest >> testFilterTwiceWithSameCompletionShouldReturnSameResults [
	
	completion filterWithString: 'ba'.
	completion fetch: 2.
	completion filterWithString: 'ba'.

	self assertCollection: (completion first: 2) hasSameElements: #('ba')
]

{ #category : #tests }
CoResultSetTest >> testNarrowFilterAfterFetchComplishonShouldNarrowResults [

	completion filterWithString: 'b'.
	completion fetch: 1.
	completion filterWithString: 'ba'.

	self assert: completion first equals: 'ba'
]

{ #category : #tests }
CoResultSetTest >> testNarrowerFilterComplishonShouldNarrowResults [

	completion filterWithString: 'b'.
	completion filterWithString: 'ba'.

	self assert: completion first equals: 'ba'
]

{ #category : #tests }
CoResultSetTest >> testResetFilterShouldRetrievePreviousResults [

	completion filterWithString: 'b'.
	completion fetch: 5.
	completion resetFilter.

	self assert: completion first equals: 'a'
]

{ #category : #tests }
CoResultSetTest >> testResetFilterWithNoFilterSetShouldNotAlterResults [

	completion resetFilter.

	self assert: completion first equals: 'a'
]
