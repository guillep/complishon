"
I am the an AST based heuristics builder.
The completion engine calls configures me with a completion context and eventually sends me the #buildCompletion message.
I then return a Complishon object configured with a correct fetcher and initial filter.

My subclasses define how to create the complishon given the context.
"
Class {
	#name : #CoResultSetBuilder,
	#superclass : #Object,
	#instVars : [
		'complishonContext'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #'instance creation' }
CoResultSetBuilder class >> initializeOnContext: aSystemComplishonContext [
	
	^ self new
		initializeOnContext: aSystemComplishonContext;
		yourself
]

{ #category : #'API - building' }
CoResultSetBuilder >> buildComplishon [

	self subclassResponsibility
]

{ #category : #accessing }
CoResultSetBuilder >> complishonContext [
	^ complishonContext
]

{ #category : #accessing }
CoResultSetBuilder >> complishonContext: anObject [
	complishonContext := anObject
]

{ #category : #initialization }
CoResultSetBuilder >> initializeOnContext: aComplishonContext [ 
	
	complishonContext := aComplishonContext
]
