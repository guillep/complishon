Class {
	#name : #SystemComplishonContext,
	#superclass : #Object,
	#instVars : [
		'engine',
		'source',
		'position',
		'complishon',
		'complishonBuilder',
		'complishonClass'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #'initialize-release' }
SystemComplishonContext class >> engine: aCompletionEngine class: aClass source: aString position: anInteger [

	^ self new
		complishonClass: aClass;
		engine: aCompletionEngine;
		source: aString;
		yourself
]

{ #category : #activating }
SystemComplishonContext >> activateEntryAt: anIndex [

	(self entries at: anIndex) activateOn: self
]

{ #category : #accessing }
SystemComplishonContext >> completionAt: aNumber [
	| entry |
	
	entry := (self entries at: aNumber) contents asSymbol separateKeywords.
	^ NECPreferences spaceAfterCompletion 
		ifTrue: [ entry, ' ' ]
		ifFalse: [ entry ]
]

{ #category : #accessing }
SystemComplishonContext >> completionToken [

	^ self complishon completionToken
]

{ #category : #testing }
SystemComplishonContext >> complishon [

	complishon ifNotNil: [ ^ complishon ].
	^ complishon := complishonBuilder buildComplishon
]

{ #category : #accessing }
SystemComplishonContext >> complishon: anObject [
	complishon := anObject
]

{ #category : #accessing }
SystemComplishonContext >> complishonClass [
	
	^ complishonClass
]

{ #category : #accessing }
SystemComplishonContext >> complishonClass: aClass [
	
	^ complishonClass := aClass
]

{ #category : #accessing }
SystemComplishonContext >> complishonEnvironment [
	
	^ ComplishonSystemEnvironment new
]

{ #category : #accessing }
SystemComplishonContext >> engine [
	^ engine
]

{ #category : #accessing }
SystemComplishonContext >> engine: anObject [
	engine := anObject
]

{ #category : #accessing }
SystemComplishonContext >> entries [

	^ (self complishon first: 20) collect: [ :e | NECInstVarEntry contents: e node: nil ]
]

{ #category : #accessing }
SystemComplishonContext >> entryCount [
	^ self entries size
]

{ #category : #accessing }
SystemComplishonContext >> environmentAt: aString ifPresent: aBlockClosure [ 
	
	^ self complishonEnvironment environmentAt: aString ifPresent: aBlockClosure
]

{ #category : #testing }
SystemComplishonContext >> hasEntries [

	^ self complishon notEmpty
]

{ #category : #menu }
SystemComplishonContext >> hasMessage [
	
	^ false
]

{ #category : #initialization }
SystemComplishonContext >> initialize [

	super initialize.
	complishonBuilder := ComplishonASTHeuristicsBuilder initializeOnContext: self
]

{ #category : #testing }
SystemComplishonContext >> isWorkspace [
	
	^ engine notNil and: [ engine isScripting ]
]

{ #category : #narrowing }
SystemComplishonContext >> narrowWith: aString [ 

	self complishon filterWithString: aString
]

{ #category : #accessing }
SystemComplishonContext >> position [
	^ engine position
]

{ #category : #accessing }
SystemComplishonContext >> position: anObject [
	position := anObject
]

{ #category : #replacing }
SystemComplishonContext >> replaceTokenInEditorWith: aString [
	
	engine replaceTokenInEditorWith: aString
]

{ #category : #accessing }
SystemComplishonContext >> source [
	^ source
]

{ #category : #accessing }
SystemComplishonContext >> source: anObject [
	source := anObject
]

{ #category : #accessing }
SystemComplishonContext >> title [

	^ ''
]
