Class {
	#name : #ClassBasedComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'completionClass'
	],
	#category : #'Complishon-Fetchers'
}

{ #category : #testing }
ClassBasedComplishonFetcher class >> isAbstract [

	^ self == ClassBasedComplishonFetcher
]

{ #category : #accessing }
ClassBasedComplishonFetcher >> completionClass [
	^ completionClass
]

{ #category : #accessing }
ClassBasedComplishonFetcher >> completionClass: anObject [
	completionClass := anObject
]

{ #category : #'hierarchy-fetching' }
ClassBasedComplishonFetcher >> forHierarchy [
	
	^ HierarchyComplishonFetcher new
		complishonFetcher: self;
		yourself
]

{ #category : #'hierarchy-fetching' }
ClassBasedComplishonFetcher >> onSuperclass [
	
	completionClass superclass
		ifNil: [ ^ EmptyComplishonFetcher new ].

	^ self copy
		completionClass: completionClass superclass;
		yourself
]
