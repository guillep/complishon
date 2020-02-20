Class {
	#name : #HierarchyComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'complishonFetcher'
	],
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
HierarchyComplishonFetcher >> complishonFetcher [
	^ complishonFetcher
]

{ #category : #accessing }
HierarchyComplishonFetcher >> complishonFetcher: anObject [
	complishonFetcher := anObject
]

{ #category : #accessing }
HierarchyComplishonFetcher >> context: aContext [

	super context: aContext.
	complishonFetcher context: aContext.
]

{ #category : #accessing }
HierarchyComplishonFetcher >> entriesDo: aBlock [
	| currentComplishonFetcher |
	currentComplishonFetcher := complishonFetcher.
	[ currentComplishonFetcher isEmptyComplishonFetcher ]
		whileFalse: [ currentComplishonFetcher entriesDo: aBlock.
			currentComplishonFetcher := currentComplishonFetcher onSuperclass ]
]
