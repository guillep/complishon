Class {
	#name : #HierarchyComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'complishonFetcher'
	],
	#category : #Complishon
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
HierarchyComplishonFetcher >> entriesInContext: aContext do: aBlock [

	| currentComplishonFetcher |
	currentComplishonFetcher := complishonFetcher.
	[ currentComplishonFetcher isEmptyComplishonFetcher ] whileFalse: [
		currentComplishonFetcher entriesInContext: aContext do: aBlock.
		currentComplishonFetcher := currentComplishonFetcher onSuperclass ]
]