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
		engine: aCompletionEngine;
		source: aString;
		position: anInteger;
		yourself
]

{ #category : #smartis }
SystemCompletionContext >> commonPrefix [
	"Longest match among the typed text and all menu entries"

 	| seed matchLengths prefixLength entries |
	entries := self entries.
	seed := entries first contents asString.
	matchLengths := entries allButFirst
		collect: [ :entry | seed charactersExactlyMatching: entry contents asString ]
		thenSelect: [ :e | e >= completionToken size ].
	prefixLength := matchLengths isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ matchLengths min ].
	^ seed first: prefixLength.
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

	| node |
	complishon ifNotNil: [ ^ complishon ].

	node := (self isWorkspace
		ifTrue: [ RBParser parseFaultyExpression: source ]
		ifFalse: [ RBParser parseFaultyMethod: source ]) nodeForOffset: position.
	
	"Visiting the node configures the completion for that node"
	node acceptVisitor: self.
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

{ #category : #visiting }
SystemCompletionContext >> configureEmptyFetcherForNode: aNode [
	
	^ self
		configureFetcherForNode: aNode
		using: EmptyComplishonFetcher new
		narrowingWith: ''
]

{ #category : #visiting }
SystemCompletionContext >> configureFetcherForNode: aNode using: aBlock narrowingWith: aString [
	
	| fetcher |
	fetcher := aBlock value.
	complishonContext astNode: aNode.
	complishon := Complishon onContext: complishonContext fetcher: fetcher.
	self narrowWith: aString.
	^ fetcher
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

{ #category : #visiting }
SystemCompletionContext >> fetcherForMessageNode: aRBMessageNode [ 
	
	aRBMessageNode receiver isSelf ifTrue: [ 
		^ self newSelfMessageInHierarchyFetcher ].

	aRBMessageNode receiver isSuper ifTrue: [ 
		^ self newSuperMessageInHierarchyFetcher ].
	
	aRBMessageNode receiver isVariable ifTrue: [ 
		Smalltalk globals at: aRBMessageNode receiver name ifPresent: [ :class |
			^ ClassImplementedMessagesComplishonFetcher new
				completionClass: class classSide;
				forHierarchy  ] ].

	^ PackageImplementedMessagesComplishonFetcher new
]

{ #category : #visiting }
SystemCompletionContext >> fetcherForVariableNode: aRBVariableNode [ 
	
	| instanceAccessible globallyAccessible |
	
	instanceAccessible :=  self isWorkspace
		ifTrue: [ EmptyComplishonFetcher new ]
		ifFalse: [ MethodVariableComplishonFetcher new,
			(InstanceVariableComplishonFetcher new
				completionClass: complishonContext complishonClass)
					forHierarchy ].

	
	globallyAccessible := GlobalVariableComplishonFetcher new.
	
	^ aRBVariableNode name first isUppercase
		ifFalse: [ instanceAccessible , globallyAccessible ]
		ifTrue: [ globallyAccessible, instanceAccessible ]
]

{ #category : #testing }
SystemCompletionContext >> hasEntries [

	^ self complishon notEmpty
]

{ #category : #menu }
SystemCompletionContext >> hasMessage [
	
	^ false
]

{ #category : #testing }
SystemCompletionContext >> isWorkspace [
	
	^ engine notNil and: [ engine isScripting ]
]

{ #category : #narrowing }
SystemCompletionContext >> narrowWith: aString [ 
	
	complishon filterWithString: aString.
	"and update the completionToken"
	completionToken := aString
]

{ #category : #visiting }
SystemCompletionContext >> newSelfMessageInHierarchyFetcher [
	
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass;
		forHierarchy
]

{ #category : #visiting }
SystemCompletionContext >> newSuperMessageInHierarchyFetcher [
	
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass superclass;
		forHierarchy
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
SystemCompletionContext >> visitBlockNode: aRBBlockNode [ 

	"I'm probably in a comment..."
	^ self configureEmptyFetcherForNode: aRBBlockNode
]

{ #category : #visiting }
SystemCompletionContext >> visitLiteralValueNode: aRBLiteralValueNode [ 
	
	^ self configureEmptyFetcherForNode: aRBLiteralValueNode
]

{ #category : #visiting }
SystemCompletionContext >> visitMessageNode: aRBMessageNode [ 
	
	^ self
		configureFetcherForNode: aRBMessageNode
		using: [ (self fetcherForMessageNode: aRBMessageNode) withoutRepetition ]
		narrowingWith: aRBMessageNode selector
]

{ #category : #visiting }
SystemCompletionContext >> visitMethodNode: aRBMethodNode [ 

	"We are maybe trying to redefine an existing method in the package?"
	^ self
		configureFetcherForNode: aRBMethodNode
		using: [ PackageImplementedMessagesComplishonFetcher new ]
		narrowingWith: aRBMethodNode selector
]

{ #category : #visiting }
SystemCompletionContext >> visitParseErrorNode: aRBParseErrorNode [ 
	
	^ self configureEmptyFetcherForNode: aRBParseErrorNode
]

{ #category : #visiting }
SystemCompletionContext >> visitSelfNode: aRBSelfNode [ 
	
	^ self configureEmptyFetcherForNode: aRBSelfNode
]

{ #category : #visiting }
SystemCompletionContext >> visitSequenceNode: aRBSequenceNode [ 
	
	self configureEmptyFetcherForNode: aRBSequenceNode
]

{ #category : #visiting }
SystemCompletionContext >> visitSuperNode: aRBSuperNode [ 
	
	^ self visitSelfNode: aRBSuperNode
]

{ #category : #visiting }
SystemCompletionContext >> visitVariableNode: aRBVariableNode [ 
	
	^ self
		configureFetcherForNode: aRBVariableNode
		using: [ self fetcherForVariableNode: aRBVariableNode ]
		narrowingWith: aRBVariableNode name
]
