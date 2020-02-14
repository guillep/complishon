Class {
	#name : #ClassBasedComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'completionClass'
	],
	#category : #Complishon
}

{ #category : #testing }
ClassBasedComplishonFetcher class >> isAbstract [

	^ self == ClassBasedComplishonFetcher
]

{ #category : #accessing }
ClassBasedComplishonFetcher >> completionClass [
	^ completionClass ifNil: [ context complishonClass ]
]

{ #category : #accessing }
ClassBasedComplishonFetcher >> completionClass: anObject [
	completionClass := anObject
]

{ #category : #'hierarchy-fetching' }
ClassBasedComplishonFetcher >> onSuperclass [
	
	completionClass superclass
		ifNil: [ ^ EmptyComplishonFetcher new ].

	^ self copy
		completionClass: completionClass superclass;
		yourself
]
