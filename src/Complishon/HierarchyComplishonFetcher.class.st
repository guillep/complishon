"
I am a complishon fetcher decorator for ClassBasedComplishonFetcher that will iterate from my child up to the end of the class hierarchy.
I'll yield all results found in one, then move to the superclass, and so on.
"
Class {
	#name : #HierarchyComplishonFetcher,
	#superclass : #ComplishonFetcherDecorator,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
HierarchyComplishonFetcher >> entriesDo: aBlock [
	| currentComplishonFetcher |
	currentComplishonFetcher := decoree.
	[ currentComplishonFetcher isEmptyComplishonFetcher ]
		whileFalse: [ currentComplishonFetcher entriesDo: aBlock.
			currentComplishonFetcher := currentComplishonFetcher onSuperclass ]
]
