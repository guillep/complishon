Class {
	#name : #HierarchyComplishonFetcher,
	#superclass : #ComplishonFetcherDecorator,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
HierarchyComplishonFetcher >> complishonFetcher [
	^ decoree
]

{ #category : #accessing }
HierarchyComplishonFetcher >> complishonFetcher: anObject [
	decoree := anObject
]

{ #category : #accessing }
HierarchyComplishonFetcher >> context: aContext [

	super context: aContext.
	decoree context: aContext.
]

{ #category : #accessing }
HierarchyComplishonFetcher >> entriesDo: aBlock [
	| currentComplishonFetcher |
	currentComplishonFetcher := decoree.
	[ currentComplishonFetcher isEmptyComplishonFetcher ]
		whileFalse: [ currentComplishonFetcher entriesDo: aBlock.
			currentComplishonFetcher := currentComplishonFetcher onSuperclass ]
]
