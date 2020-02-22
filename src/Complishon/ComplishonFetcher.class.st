"
I'm a kind of iterator (in the sense of GoF) that goes one by one over ""a stream"" of entities that can be consumed by the completion engine within a completion context.

I provide access to the elements I return one by one (using the next message) in a controlled manner. 
At the root, I define the architecture to yield one entry at a time. 
The next method invokes the hook method entriesInContext:do: with the generator yielding capacibility.
This way any use of next will be done step by step. 

My subclasses implement the following method entriesInContext: aContext do: aBlock which defines the semantics of element fetching

Here is a typical use (not mentioning the context of the completion, usually a tree and environment).

[[[
fetcher := AvoidRepeatedComplishonFetcher new
				complishonFetcher: (GenericComplishonFetcher onCollection: #( a b b a c )).
]]]
	
Here are two examples of definition

[[[
AvoidRepeatedCompleshonFecther >> entriesInContext: aContext do: aBlock
	
	fetcher context: aContext.
	fetcher entriesInContext: aContext do: [ :elem |
		(self hasAlreadyReturned: elem) ifFalse: [ 
			elements add: elem.
			aBlock value: elem ] ]
]]]

[[[
GenericComplishonFetcher >> entriesInContext: aContext do: aBlock

	collection do: aBlock
]]]



	

"
Class {
	#name : #ComplishonFetcher,
	#superclass : #Object,
	#instVars : [
		'generator'
	],
	#category : #'Complishon-Core'
}

{ #category : #composing }
ComplishonFetcher >> , anotherFetcher [ 

	^ ComplishonFetcherSequence new
		add: self;
		add: anotherFetcher;
		yourself
]

{ #category : #testing }
ComplishonFetcher >> atEnd [
	
	^ self generator atEnd
]

{ #category : #accessing }
ComplishonFetcher >> entriesDo: aBlock [
	"Key method for subclasses to define their semantics."
	
	^ self subclassResponsibility
]

{ #category : #accessing }
ComplishonFetcher >> generator [
	^ generator ifNil: [ 
		generator := Generator on: [ :g | 
			self entriesDo: [ :entry | g yield: entry ] ] ]
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
