Class {
	#name : #ComplishonASTHeuristicsBuilder,
	#superclass : #Object,
	#instVars : [
		'complishonContext',
		'astNode'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #'instance creation' }
ComplishonASTHeuristicsBuilder class >> initializeOnContext: aSystemComplishonContext [
	
	^ self new
		initializeOnContext: aSystemComplishonContext;
		yourself
]

{ #category : #'API - building' }
ComplishonASTHeuristicsBuilder >> buildComplishon [

	astNode := (complishonContext isWorkspace
		ifTrue: [ RBParser parseFaultyExpression: complishonContext source ]
		ifFalse: [ RBParser parseFaultyMethod: complishonContext source ])
			nodeForOffset: complishonContext position.
	
	"Visiting the node configures the completion for that node"
	^ astNode acceptVisitor: self
]

{ #category : #accessing }
ComplishonASTHeuristicsBuilder >> complishonContext [
	^ complishonContext
]

{ #category : #accessing }
ComplishonASTHeuristicsBuilder >> complishonContext: anObject [
	complishonContext := anObject
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> configureEmptyFetcherForNode: aNode [
	
	^ self
		configureFetcherForNode: aNode
		using: EmptyComplishonFetcher new
		narrowingWith: ''
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> configureFetcherForNode: aNode using: aBlock narrowingWith: aString [
	
	| fetcher complishon2 |
	fetcher := aBlock value.
	complishon2 := Complishon fetcher: fetcher.
	complishon2 filterWithString: aString.
	^ complishon2
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> fetcherForMessageNode: aRBMessageNode [ 
	
	aRBMessageNode receiver isSelf ifTrue: [ 
		^ self newSelfMessageInHierarchyFetcher ].

	aRBMessageNode receiver isSuper ifTrue: [ 
		^ self newSuperMessageInHierarchyFetcher ].
	
	aRBMessageNode receiver isVariable ifTrue: [
		complishonContext environmentAt: aRBMessageNode receiver name ifPresent: [ :class |
			^ ClassImplementedMessagesComplishonFetcher new
				completionClass: class classSide;
				forHierarchy  ].
		
		"Heuristic: variables with type information.
		This is maybe an instance of this class, autocomplete for that class first, then continue with normal completion.
		E.g., aCollection => use completion for Collection class first, then normal collection.
		There are two cases: aPoint and anASTCache"
		complishonContext environmentAt: aRBMessageNode receiver name allButFirst asSymbol ifPresent: [ :class |
			^ (ClassImplementedMessagesComplishonFetcher new
				completionClass: class;
				forHierarchy), 
					(PackageImplementedMessagesComplishonFetcher new
						complishonPackage: class package)  ].
		complishonContext environmentAt: (aRBMessageNode receiver name allButFirst: 2) asSymbol ifPresent: [ :class |
			^ (ClassImplementedMessagesComplishonFetcher new
				completionClass: class;
				forHierarchy), (PackageImplementedMessagesComplishonFetcher new
						complishonPackage: class package) ]
	].

	^ PackageImplementedMessagesComplishonFetcher new
			complishonPackage: complishonContext complishonClass package
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> fetcherForVariableNode: aRBVariableNode [ 
	
	| instanceAccessible globallyAccessible |
	
	instanceAccessible := complishonContext isWorkspace
		ifTrue: [ EmptyComplishonFetcher new ]
		ifFalse: [ ((MethodVariableComplishonFetcher new)
				complishonASTNode: astNode),
			(InstanceVariableComplishonFetcher new
				completionClass: complishonContext complishonClass)
					forHierarchy ].

	globallyAccessible := complishonContext isWorkspace
		ifTrue: [ GlobalVariableComplishonFetcher new
			complishonEnvironment: complishonContext complishonEnvironment;
			yourself ]
		ifFalse: [ (ClassVariableComplishonFetcher new
			completionClass: complishonContext complishonClass) forHierarchy,
				(GlobalVariableComplishonFetcher new
					complishonEnvironment: complishonContext complishonEnvironment;
					yourself) ].
	
	^ aRBVariableNode name first isUppercase
		ifFalse: [ instanceAccessible , globallyAccessible ]
		ifTrue: [ globallyAccessible, instanceAccessible ]
]

{ #category : #initialization }
ComplishonASTHeuristicsBuilder >> initializeOnContext: aComplishonContext [ 
	
	complishonContext := aComplishonContext
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> newSelfMessageInHierarchyFetcher [
	
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass;
		forHierarchy
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> newSuperMessageInHierarchyFetcher [
	
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: complishonContext complishonClass superclass;
		forHierarchy
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitBlockNode: aRBBlockNode [ 

	"I'm probably in a comment..."
	^ self configureEmptyFetcherForNode: aRBBlockNode
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitLiteralValueNode: aRBLiteralValueNode [ 
	
	^ self configureEmptyFetcherForNode: aRBLiteralValueNode
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitMessageNode: aRBMessageNode [ 
	
	^ self
		configureFetcherForNode: aRBMessageNode
		using: [ (self fetcherForMessageNode: aRBMessageNode) withoutRepetition ]
		narrowingWith: aRBMessageNode selector
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitMethodNode: aRBMethodNode [ 

	"We are maybe trying to redefine an existing method in the package?"
	^ self
		configureFetcherForNode: aRBMethodNode
		using: [ (self newSuperMessageInHierarchyFetcher,
				PackageImplementedMessagesComplishonFetcher new)
					withoutRepetition ]
		narrowingWith: aRBMethodNode selector
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitParseErrorNode: aRBParseErrorNode [ 
	
	^ self configureEmptyFetcherForNode: aRBParseErrorNode
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitSelfNode: aRBSelfNode [ 
	
	^ self configureEmptyFetcherForNode: aRBSelfNode
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitSequenceNode: aRBSequenceNode [ 
	
	self configureEmptyFetcherForNode: aRBSequenceNode
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitSuperNode: aRBSuperNode [ 
	
	^ self visitSelfNode: aRBSuperNode
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitVariableNode: aRBVariableNode [ 
	
	^ self
		configureFetcherForNode: aRBVariableNode
		using: [ self fetcherForVariableNode: aRBVariableNode ]
		narrowingWith: aRBVariableNode name
]
