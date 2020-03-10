"
I am the interface with the System's CompletionEngine, following the API of CompletionContext (entries, entryCount, activateEntryAt:, etc).
I delegate the calculation of the entries completely to a complishon object which is lazily built by a complishon builder.
The complishonBuilder instance can be specialized or replaced to change the search heuristics.
"
Class {
	#name : #CoCompletionContext,
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
CoCompletionContext class >> engine: aCompletionEngine class: aClass source: aString position: anInteger [

	^ self new
		complishonClass: aClass;
		engine: aCompletionEngine;
		source: aString;
		position: anInteger;
		yourself
]

{ #category : #activating }
CoCompletionContext >> activateEntryAt: anIndex [

	(self entries at: anIndex) activateOn: self
]

{ #category : #accessing }
CoCompletionContext >> completionAt: aNumber [
	| entry |
	
	entry := (self entries at: aNumber) contents asSymbol separateKeywords.
	^ NECPreferences spaceAfterCompletion 
		ifTrue: [ entry, ' ' ]
		ifFalse: [ entry ]
]

{ #category : #accessing }
CoCompletionContext >> completionToken [

	^ self complishon completionToken
]

{ #category : #testing }
CoCompletionContext >> complishon [

	complishon ifNotNil: [ ^ complishon ].
	^ complishon := self complishonBuilder
		complishonContext: self;
		buildComplishon
]

{ #category : #accessing }
CoCompletionContext >> complishon: anObject [
	complishon := anObject
]

{ #category : #accessing }
CoCompletionContext >> complishonBuilder [
	^ complishonBuilder
]

{ #category : #accessing }
CoCompletionContext >> complishonBuilder: anUndefinedObject [ 
	complishonBuilder := anUndefinedObject
]

{ #category : #accessing }
CoCompletionContext >> complishonClass [
	
	^ complishonClass
]

{ #category : #accessing }
CoCompletionContext >> complishonClass: aClass [
	
	^ complishonClass := aClass
]

{ #category : #accessing }
CoCompletionContext >> complishonEnvironment [
	
	^ CoSystemEnvironment new
]

{ #category : #accessing }
CoCompletionContext >> doItContext [

	^ engine doItContext
]

{ #category : #accessing }
CoCompletionContext >> doItRequestor [

	^ engine doItRequestor
]

{ #category : #accessing }
CoCompletionContext >> engine [
	^ engine
]

{ #category : #accessing }
CoCompletionContext >> engine: anObject [
	engine := anObject
]

{ #category : #accessing }
CoCompletionContext >> entries [

	^ self complishon first: 20
]

{ #category : #accessing }
CoCompletionContext >> entryCount [
	^ self entries size
]

{ #category : #accessing }
CoCompletionContext >> environmentAt: aString ifPresent: aBlockClosure [ 
	
	^ self complishonEnvironment environmentAt: aString ifPresent: aBlockClosure
]

{ #category : #testing }
CoCompletionContext >> hasEntries [

	^ self complishon notEmpty
]

{ #category : #menu }
CoCompletionContext >> hasMessage [
	
	^ false
]

{ #category : #initialization }
CoCompletionContext >> initialize [

	super initialize.
	complishonBuilder := CoASTHeuristicsResultSetBuilder initializeOnContext: self
]

{ #category : #testing }
CoCompletionContext >> isWorkspace [
	
	^ engine notNil and: [ engine isScripting ]
]

{ #category : #narrowing }
CoCompletionContext >> narrowWith: aString [ 

	self complishon filterWithString: aString
]

{ #category : #accessing }
CoCompletionContext >> position [
	^ position
]

{ #category : #accessing }
CoCompletionContext >> position: anObject [
	position := anObject
]

{ #category : #replacing }
CoCompletionContext >> replaceTokenInEditorWith: aString [
	
	engine replaceTokenInEditorWith: aString
]

{ #category : #accessing }
CoCompletionContext >> source [
	^ source
]

{ #category : #accessing }
CoCompletionContext >> source: anObject [
	source := anObject
]

{ #category : #accessing }
CoCompletionContext >> title [

	^ ''
]

{ #category : #'as yet unclassified' }
CoCompletionContext >> variableBindingNames [

	^ self engine variableBindingNames
]
