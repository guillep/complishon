"
I am the an AST based heuristics builder.
The completion engine calls configures me with a completion context and eventually sends me the #buildCompletion message.
I then return a Complishon object configured with a correct fetcher and initial filter.

My subclasses define how to create the complishon given the context.
"
Class {
	#name : #ComplishonBuilder,
	#superclass : #Object,
	#instVars : [
		'complishonContext'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #'instance creation' }
ComplishonBuilder class >> initializeOnContext: aSystemComplishonContext [
	
	^ self new
		initializeOnContext: aSystemComplishonContext;
		yourself
]

{ #category : #'API - building' }
ComplishonBuilder >> buildComplishon [

	self subclassResponsibility
]

{ #category : #accessing }
ComplishonBuilder >> complishonContext [
	^ complishonContext
]

{ #category : #accessing }
ComplishonBuilder >> complishonContext: anObject [
	complishonContext := anObject
]

{ #category : #initialization }
ComplishonBuilder >> initializeOnContext: aComplishonContext [ 
	
	complishonContext := aComplishonContext
]
