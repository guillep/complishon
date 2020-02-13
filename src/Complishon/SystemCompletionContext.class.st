Class {
	#name : #SystemCompletionContext,
	#superclass : #Object,
	#instVars : [
		'engine',
		'complishonContext',
		'source',
		'position',
		'completionToken',
		'complishon'
	],
	#category : #Complishon
}

{ #category : #'initialize-release' }
SystemCompletionContext class >> engine: aCompletionEngine class: aClass source: aString position: anInteger [

	^ self new
		complishonContext: (ComplishonContext new
			complishonClass: aClass;
			complishonEnvironment: ComplishonSystemEnvironment new;
			yourself);
		source: aString;
		position: anInteger;
		yourself
]

{ #category : #accessing }
SystemCompletionContext >> completionToken [
	^ completionToken ifNil: [ ^ ''  ]
]

{ #category : #testing }
SystemCompletionContext >> complishon [

	| node fetcher |
	complishon ifNotNil: [ ^ complishon ].

	node := (RBParser parseFaultyMethod: source) nodeForOffset: position.
	fetcher := InstanceVariableComplishonFetcher new.
	complishon := Complishon onContext: complishonContext fetcher: fetcher.
	self narrowWith: (node isVariable ifTrue: [ node name ] ifFalse: [ '' ]).
	^ complishon
]

{ #category : #accessing }
SystemCompletionContext >> complishonContext [
	^ complishonContext
]

{ #category : #accessing }
SystemCompletionContext >> complishonContext: anObject [
	complishonContext := anObject
]

{ #category : #accessing }
SystemCompletionContext >> engine [
	^ engine
]

{ #category : #accessing }
SystemCompletionContext >> engine: anObject [
	engine := anObject
]

{ #category : #accessing }
SystemCompletionContext >> entries [
	
	^ (complishon first: 20)
		collect: [ :e | NECInstVarEntry contents: e node: nil ]
]

{ #category : #accessing }
SystemCompletionContext >> entryCount [
	^ self entries size
]

{ #category : #testing }
SystemCompletionContext >> hasEntries [

	^ self complishon notEmpty
]

{ #category : #menu }
SystemCompletionContext >> hasMessage [
	
	^ false
]

{ #category : #narrowing }
SystemCompletionContext >> narrowWith: aString [ 
	
	complishon filterWithString: aString.
	"and update the completionToken"
	completionToken := aString
]

{ #category : #accessing }
SystemCompletionContext >> position [
	^ position
]

{ #category : #accessing }
SystemCompletionContext >> position: anObject [
	position := anObject
]

{ #category : #accessing }
SystemCompletionContext >> source [
	^ source
]

{ #category : #accessing }
SystemCompletionContext >> source: anObject [
	source := anObject
]

{ #category : #accessing }
SystemCompletionContext >> title [

	^ ''
]
