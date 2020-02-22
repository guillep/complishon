Class {
	#name : #FilterComplishonFetcher,
	#superclass : #ComplishonFetcherDecorator,
	#instVars : [
		'filterBlock'
	],
	#category : #'Complishon-Core'
}

{ #category : #accessing }
FilterComplishonFetcher >> complishon: aComplishonToFilter [ 

	decoree := aComplishonToFilter
]

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

{ #category : #resetting }
FilterComplishonFetcher >> reset [
	
	super reset.
	decoree reset.
]

{ #category : #filtering }
FilterComplishonFetcher >> select: aBlockClosure [

	"Do not filter over a filter.
	Instead, create a new filter over the original fetcher"
	
	^ decoree select: aBlockClosure
]

{ #category : #filtering }
FilterComplishonFetcher >> withoutFilter [
	
	^ decoree
]
