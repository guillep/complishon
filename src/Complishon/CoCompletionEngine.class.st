"
I am an adaptor between the Morphic text morphs supporting completion and Complishon.
I contain a complishonBuilder that is used to create a complishon.

See my superclass for details
"
Class {
	#name : #CoCompletionEngine,
	#superclass : #CompletionEngine,
	#instVars : [
		'complishonBuilder'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #accessing }
CoCompletionEngine >> complishonBuilder [

	^ complishonBuilder ifNil: [ CoASTHeuristicsResultSetBuilder new ]
]

{ #category : #accessing }
CoCompletionEngine >> complishonBuilder: anObject [
	complishonBuilder := anObject
]

{ #category : #'menu morph' }
CoCompletionEngine >> createContext [

	^ super createContext
		complishonBuilder: self complishonBuilder;
		yourself
]

{ #category : #initialization }
CoCompletionEngine >> initialize [

	super initialize.
	contextClass := CoCompletionContext.
]
