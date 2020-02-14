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
	#category : #'Complishon-SystemIntegration'
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
SystemCompletionContext >> completionAt: aNumber [
	| entry |
	
	entry := (self entries at: aNumber) contents asSymbol separateKeywords.
	^ NECPreferences spaceAfterCompletion 
		ifTrue: [ entry, ' ' ]
		ifFalse: [ entry ]
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
	fetcher := node acceptVisitor: self.
	complishonContext astNode: node.
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

	^ (complishon first: 20) collect: [ :e | NECInstVarEntry contents: e node: nil ]
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

{ #category : #visiting }
SystemCompletionContext >> visitLiteralValueNode: aRBLiteralValueNode [ 
	
	^ EmptyComplishonFetcher new
]

{ #category : #visiting }
SystemCompletionContext >> visitMessageNode: aRBMessageNode [ 
	
	aRBMessageNode receiver isSelf ifTrue: [ 
		^ ClassImplementedMessagesComplishonFetcher new
			completionClass: complishonContext complishonClass;
			forHierarchy ].
	
	aRBMessageNode receiver isVariable ifTrue: [ 
		Smalltalk globals at: aRBMessageNode receiver name ifPresent: [ :class |
			^ ClassImplementedMessagesComplishonFetcher new
				completionClass: class classSide;
				forHierarchy ] ].

	^ PackageImplementedMessagesComplishonFetcher new
]

{ #category : #visiting }
SystemCompletionContext >> visitMethodNode: aRBMethodNode [ 

	"We are maybe trying to redefine an existing method in the package?"
	^ PackageImplementedMessagesComplishonFetcher new
]

{ #category : #visiting }
SystemCompletionContext >> visitVariableNode: aRBVariableNode [ 
	
	| instanceAccessible globallyAccessible |
	instanceAccessible := MethodVariableComplishonFetcher new,
		(InstanceVariableComplishonFetcher new
			completionClass: complishonContext complishonClass)
				forHierarchy.
	
	globallyAccessible := GlobalVariableComplishonFetcher new.
	
	^ aRBVariableNode name first isUppercase
		ifFalse: [ instanceAccessible , globallyAccessible ]
		ifTrue: [ globallyAccessible, instanceAccessible ]
]
