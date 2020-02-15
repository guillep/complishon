Class {
	#name : #FilterFetcherTest,
	#superclass : #BasicComplishonTest,
	#category : #'Complishon-Tests'
}

{ #category : #tests }
FilterFetcherTest >> testFilterComplishonBeforeFetchingShouldNarrowResults [

	| c |
	c := InstanceVariableComplishonFetcher new.
	c context: self context.
	
	c := c select: [ :e | (e beginsWith: 'a') not ].
	
	self assert: c next equals: 'b'
]
