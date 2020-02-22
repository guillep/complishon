"
I am a filtering complishon fetcher. I decorate a complishon fetcher and filter its results to those ones that satisfy a given condition block.
I can be created by sending the #select: message to an existing fetcher.

(GenericComplishonFetcher onCollection: aCollection) select: [ :each | each even ]

As a convenience method to get rid of the upmost filter in the decorator chain, all fetchers understand #withoutFilter.
#withoutFilter will return self for all fetchers except for a filter one.
A filter will return its decoree.

Finally, as a convenience for code completion, the method #narrowFilterBlock: is a convenience allowing to replace the filter block on the fly.
It should be used only if the block actually narrows the selection, or at least filters the same elements.
"
Class {
	#name : #FilterComplishonFetcher,
	#superclass : #ComplishonFetcherDecorator,
	#instVars : [
		'filterBlock'
	],
	#category : #'Complishon-Core'
}

{ #category : #accessing }
FilterComplishonFetcher >> entriesDo: aBlockClosure [
	decoree
		entriesDo: [ :each | 
			(filterBlock value: each)
				ifTrue: [ aBlockClosure value: each ] ]
]

{ #category : #accessing }
FilterComplishonFetcher >> filterBlock: aBlockClosure [ 
	
	filterBlock := aBlockClosure
]

{ #category : #filtering }
FilterComplishonFetcher >> narrowFilterBlock: aBlock [

	self filterBlock: aBlock
]

{ #category : #filtering }
FilterComplishonFetcher >> select: aBlockClosure [

	"Do not filter over a filter.
	Instead, create a new filter over the original fetcher"
	^ self withoutFilter select: aBlockClosure
]

{ #category : #filtering }
FilterComplishonFetcher >> withoutFilter [
	
	^ decoree
]
