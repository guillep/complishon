"
I am an abstract complishon fetcher that looks for things inside a class.
My subclasses will, for example, fetch a class' class variables, messages implemented in the class, instance variables.

I am explicitly created with the superclass I will look into.
This allows other combinators to act upon me.
- I define #onSuperclass that creates a copy of myself but acting on my superclass.
- I define #forHierarchy that decorates myself with a HierarchyComplishonFetcher that makes a search for the entire hierarchy.
"
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
		decoree: self;
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
