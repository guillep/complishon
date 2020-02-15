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
HierarchyComplishonFetcher >> entriesInContext: aContext do: aBlock [

	| currentComplishonFetcher |
	currentComplishonFetcher := complishonFetcher.
	[ currentComplishonFetcher isEmptyComplishonFetcher ] whileFalse: [
		currentComplishonFetcher entriesInContext: aContext do: aBlock.
		currentComplishonFetcher := currentComplishonFetcher onSuperclass ]
]
