Class {
	#name : #CoResultSetTest,
	#superclass : #CoBasicCompletionTest,
	#instVars : [
		'complishon'
	],
	#category : #'Complishon-Tests'
}

{ #category : #tests }
CoResultSetTest >> setUp [

	super setUp.
	self completionClass addInstanceVariable: 'ba'.
	complishon := CoResultSet
		fetcher: (CoInstanceVariableFetcher new
			completionClass: self completionClass)
]

{ #category : #tests }
CoResultSetTest >> testBroadenFilterAfterFetchComplishonShouldBroadenResults [

	complishon filterWithString: 'ba'.
	complishon fetch: 1.
	complishon filterWithString: 'b'.
	
	self assert: complishon first equals: 'b'
]

{ #category : #tests }
CoResultSetTest >> testBroaderFilterComplishonShouldBroadenResults [

	complishon filterWithString: 'ba'.
	complishon filterWithString: 'b'.
	
	self assert: complishon first equals: 'b'
]

{ #category : #tests }
CoResultSetTest >> testComplishonWithElementsToFetchShouldHaveMore [

	self assert: complishon hasMoreElements
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

	self assert: complishon first equals: 'a'
]

{ #category : #tests }
CoResultSetTest >> testFilterComplishonAfterFetchingShouldNarrowResults [

	complishon fetch: 1.
	complishon filterWithString: 'b'.

	self assert: complishon first equals: 'b'
]

{ #category : #tests }
CoResultSetTest >> testFilterTwiceWithSameCompletionShouldReturnSameResults [
	
	complishon filterWithString: 'ba'.
	complishon fetch: 2.
	complishon filterWithString: 'ba'.

	self assertCollection: (complishon first: 2) hasSameElements: #('ba')
]

{ #category : #tests }
CoResultSetTest >> testNarrowFilterAfterFetchComplishonShouldNarrowResults [

	complishon filterWithString: 'b'.
	complishon fetch: 1.
	complishon filterWithString: 'ba'.

	self assert: complishon first equals: 'ba'
]

{ #category : #tests }
CoResultSetTest >> testNarrowerFilterComplishonShouldNarrowResults [

	complishon filterWithString: 'b'.
	complishon filterWithString: 'ba'.

	self assert: complishon first equals: 'ba'
]

{ #category : #tests }
CoResultSetTest >> testResetFilterShouldRetrievePreviousResults [

	complishon filterWithString: 'b'.
	complishon fetch: 5.
	complishon resetFilter.

	self assert: complishon first equals: 'a'
]

{ #category : #tests }
CoResultSetTest >> testResetFilterWithNoFilterSetShouldNotAlterResults [

	complishon resetFilter.

	self assert: complishon first equals: 'a'
]
