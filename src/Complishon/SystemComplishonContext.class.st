Class {
	#name : #SystemComplishonContext,
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
SystemComplishonContext class >> engine: aCompletionEngine class: aClass source: aString position: anInteger [

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
SystemComplishonContext >> commonPrefix [
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
SystemComplishonContext >> completionAt: aNumber [
	| entry |
	
	entry := (self entries at: aNumber) contents asSymbol separateKeywords.
	^ NECPreferences spaceAfterCompletion 
		ifTrue: [ entry, ' ' ]
		ifFalse: [ entry ]
]

{ #category : #accessing }
SystemComplishonContext >> completionToken [
	^ completionToken ifNil: [ ^ ''  ]
]

{ #category : #testing }
SystemComplishonContext >> complishon [

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
SystemComplishonContext >> complishonContext [
	^ complishonContext
]

{ #category : #accessing }
SystemComplishonContext >> complishonContext: anObject [
	complishonContext := anObject
]

{ #category : #visiting }
SystemComplishonContext >> configureEmptyFetcherForNode: aNode [
	
	^ self
		configureFetcherForNode: aNode
		using: EmptyComplishonFetcher new
		narrowingWith: ''
]

{ #category : #visiting }
SystemComplishonContext >> configureFetcherForNode: aNode using: aBlock narrowingWith: aString [
	
	| fetcher |
	fetcher := aBlock value.
	complishonContext astNode: aNode.
	complishon := Complishon onContext: complishonContext fetcher: fetcher.
	self narrowWith: aString.
	^ fetcher
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

	^ (complishon first: 20) collect: [ :e | NECInstVarEntry contents: e node: nil ]
]

{ #category : #accessing }
SystemComplishonContext >> entryCount [
	^ self entries size
]

{ #category : #visiting }
SystemComplishonContext >> fetcherForMessageNode: aRBMessageNode [ 
	
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
SystemComplishonContext >> fetcherForVariableNode: aRBVariableNode [ 
	
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
SystemComplishonContext >> hasEntries [

	^ self complishon notEmpty
]

{ #category : #menu }
SystemComplishonContext >> hasMessage [
	
	^ false
]

{ #category : #testing }
SystemComplishonContext >> isWorkspace [
	
	^ engine notNil and: [ engine isScripting ]
]

{ #category : #narrowing }
SystemComplishonContext >> narrowWith: aString [ 
	
	complishon filterWithString: aString.
	"and update the completionToken"
	completionToken := aString
]

{ #category : #visiting }
SystemComplishonContext >> newSelfMessageInHierarchyFetcher [
	
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass;
		forHierarchy
]

{ #category : #visiting }
SystemComplishonContext >> newSuperMessageInHierarchyFetcher [
	
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass superclass;
		forHierarchy
]

{ #category : #accessing }
SystemComplishonContext >> position [
	^ position
]

{ #category : #accessing }
SystemComplishonContext >> position: anObject [
	position := anObject
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

{ #category : #visiting }
SystemComplishonContext >> visitBlockNode: aRBBlockNode [ 

	"I'm probably in a comment..."
	^ self configureEmptyFetcherForNode: aRBBlockNode
]

{ #category : #visiting }
SystemComplishonContext >> visitLiteralValueNode: aRBLiteralValueNode [ 
	
	^ self configureEmptyFetcherForNode: aRBLiteralValueNode
]

{ #category : #visiting }
SystemComplishonContext >> visitMessageNode: aRBMessageNode [ 
	
	^ self
		configureFetcherForNode: aRBMessageNode
		using: [ (self fetcherForMessageNode: aRBMessageNode) withoutRepetition ]
		narrowingWith: aRBMessageNode selector
]

{ #category : #visiting }
SystemComplishonContext >> visitMethodNode: aRBMethodNode [ 

	"We are maybe trying to redefine an existing method in the package?"
	^ self
		configureFetcherForNode: aRBMethodNode
		using: [ (self newSuperMessageInHierarchyFetcher,
				PackageImplementedMessagesComplishonFetcher new)
					withoutRepetition ]
		narrowingWith: aRBMethodNode selector
]

{ #category : #visiting }
SystemComplishonContext >> visitParseErrorNode: aRBParseErrorNode [ 
	
	^ self configureEmptyFetcherForNode: aRBParseErrorNode
]

{ #category : #visiting }
SystemComplishonContext >> visitSelfNode: aRBSelfNode [ 
	
	^ self configureEmptyFetcherForNode: aRBSelfNode
]

{ #category : #visiting }
SystemComplishonContext >> visitSequenceNode: aRBSequenceNode [ 
	
	self configureEmptyFetcherForNode: aRBSequenceNode
]

{ #category : #visiting }
SystemComplishonContext >> visitSuperNode: aRBSuperNode [ 
	
	^ self visitSelfNode: aRBSuperNode
]

{ #category : #visiting }
SystemComplishonContext >> visitVariableNode: aRBVariableNode [ 
	
	^ self
		configureFetcherForNode: aRBVariableNode
		using: [ self fetcherForVariableNode: aRBVariableNode ]
		narrowingWith: aRBVariableNode name
]
