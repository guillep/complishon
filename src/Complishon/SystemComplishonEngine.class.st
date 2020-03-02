"
I am an adaptor between the Morphic text morphs supporting completion and Complishon.
I contain a complishonBuilder that is used to create a complishon.

See my superclass for details
"
Class {
	#name : #SystemComplishonEngine,
	#superclass : #CompletionEngine,
	#instVars : [
		'complishonBuilder'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #accessing }
SystemComplishonEngine >> complishonBuilder [

	^ complishonBuilder ifNil: [ ComplishonASTHeuristicsBuilder new ]
]

{ #category : #accessing }
SystemComplishonEngine >> complishonBuilder: anObject [
	complishonBuilder := anObject
]

{ #category : #'menu morph' }
SystemComplishonEngine >> createContext [

	^ super createContext
		complishonBuilder: self complishonBuilder;
		yourself
]

{ #category : #initialization }
SystemComplishonEngine >> initialize [

	super initialize.
	contextClass := SystemComplishonContext.
]
