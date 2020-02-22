"
I am the an AST based heuristics builder.

When building the complishon, I build the AST from the source in the context, and get the current node from the context position.
Then I do a double dispatch on the current node and from it
1) I decide what fetchers to create
2) I extract the currently typed text and set is as initial filter
"
Class {
	#name : #ComplishonASTHeuristicsBuilder,
	#superclass : #ComplishonBuilder,
	#instVars : [
		'astNode'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #'API - building' }
ComplishonASTHeuristicsBuilder >> buildComplishon [

	astNode := (complishonContext isWorkspace
		ifTrue: [ RBParser parseFaultyExpression: complishonContext source ]
		ifFalse: [ RBParser parseFaultyMethod: complishonContext source ])
			nodeForOffset: complishonContext position.
	
	"Visiting the node configures the completion for that node"
	^ astNode acceptVisitor: self
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
		complishonContext environmentAt: aRBMessageNode receiver name ifPresent: [ :global |
			^ self newFetcherForGlobal: global ].
		
		"Heuristic: variables with type information.
		This is maybe an instance of this class, autocomplete for that class first, then continue with normal completion.
		E.g., aCollection => use completion for Collection class first, then normal collection.
		There are two cases: aPoint and anASTCache"
		aRBMessageNode receiver name size > 1 and: [
			complishonContext environmentAt: aRBMessageNode receiver name allButFirst asSymbol ifPresent: [ :global |
				^ (self newFetcherForGlobal: global), 
						(PackageImplementedMessagesComplishonFetcher new
							complishonPackage: complishonContext complishonClass package)  ] ].
		aRBMessageNode receiver name size > 2 and: [
			complishonContext environmentAt: (aRBMessageNode receiver name allButFirst: 2) asSymbol ifPresent: [ :global |
				^ (self newFetcherForGlobal: global),
						(PackageImplementedMessagesComplishonFetcher new
							complishonPackage: complishonContext complishonClass package) ] ]
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

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> newFetcherForGlobal: aGlobal [

	"This is a class or trait. Autocomplete class-side messages" 
	aGlobal isClassOrTrait ifTrue: [
		^ ClassImplementedMessagesComplishonFetcher new
			completionClass: aGlobal classSide;
			forHierarchy ].

	"This is not a class binding but a global object. Autocomplete based on its class"
	^ ClassImplementedMessagesComplishonFetcher new
		completionClass: aGlobal class;
		forHierarchy
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
				(PackageImplementedMessagesComplishonFetcher new
					complishonPackage: complishonContext complishonClass package;
					yourself))
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
	
	^ self configureEmptyFetcherForNode: aRBSequenceNode
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
