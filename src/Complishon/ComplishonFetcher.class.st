Class {
	#name : #ComplishonFetcher,
	#superclass : #Object,
	#instVars : [
		'context',
		'generator'
	],
	#category : #'Complishon-Core'
}

{ #category : #composing }
ComplishonFetcher >> , anotherFetcher [ 

	^ ComposedComplishonFetcher new
		add: self;
		add: anotherFetcher;
		yourself
]

{ #category : #composing }
ComplishonFetcher >> andThen: aBlockClosure [ 
	
	^ ComposedComplishonFetcher new
		add: self;
		add: aBlockClosure value;
		yourself
]

{ #category : #testing }
ComplishonFetcher >> atEnd [
	
	^ self generator atEnd
]

{ #category : #accessing }
ComplishonFetcher >> context [
	^ context
]

{ #category : #accessing }
ComplishonFetcher >> context: anObject [
	context := anObject
]

{ #category : #accessing }
ComplishonFetcher >> entriesInContext: aContext do: aBlock [

	^ self subclassResponsibility
]

{ #category : #accessing }
ComplishonFetcher >> generator [
	
	^ generator ifNil: [
		generator := Generator on: [ :g | 
			self entriesInContext: context do: [ :entry | g yield: entry ] ] ]
]

{ #category : #testing }
ComplishonFetcher >> isEmptyComplishonFetcher [
	
	^ false
]

{ #category : #filtering }
ComplishonFetcher >> narrowFilterBlock: aBlockClosure [ 
	
	^ self select: aBlockClosure
]

{ #category : #accessing }
ComplishonFetcher >> next [
	
	^ self generator next
]

{ #category : #fetching }
ComplishonFetcher >> next: anInteger [ 
	
	^ Array new: anInteger streamContents: [ :stream | | total last |
		total := 0.
		[ (last := self next) ifNotNil: [ :each | 
			stream nextPut: each.
			total := total + 1 ] ]
			doWhileTrue: [ total < anInteger and: [ last notNil ] ] ]
]

{ #category : #resetting }
ComplishonFetcher >> reset [
	
	generator := nil
]

{ #category : #filtering }
ComplishonFetcher >> select: aBlockClosure [ 
	
	^ FilterComplishonFetcher new
		complishon: self;
		context: context;
		filterBlock: aBlockClosure;
		yourself
]

{ #category : #enumerating }
ComplishonFetcher >> upToEnd [
	
	^ self generator upToEnd
]

{ #category : #filtering }
ComplishonFetcher >> withoutFilter [
	
	^ self
]

{ #category : #composing }
ComplishonFetcher >> withoutRepetition [

	^ AvoidRepeatedComplishonFetcher new
		complishonFetcher: self;
		yourself
]
