"
I am the an AST based heuristics builder.

When building the complishon, I build the AST from the source in the context, and get the current node from the context position.
Then I do a double dispatch on the current node and from it
1) I decide what fetchers to create
2) I extract the currently typed text and set is as initial filter
"
Class {
	#name : #ComplishonASTHeuristicsBuilder,
	#superclass : #ComplishonASTBuilder,
	#instVars : [
		'messageHeuristic',
		'methodNodeHeuristic'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #'private-building' }
ComplishonASTHeuristicsBuilder >> fetcherForVariableNode: aRBVariableNode [ 
	
	| fetcher |
	"First variables in the code"
	fetcher := ((MethodVariableComplishonFetcher new) complishonASTNode: astNode).
	
	complishonContext isWorkspace ifFalse: [
		"Then instance variables"
		fetcher := fetcher, (InstanceVariableComplishonFetcher new
			completionClass: complishonContext complishonClass) forHierarchy.
		"Then class variables if not a workspace"
		fetcher := fetcher, (ClassVariableComplishonFetcher new
			completionClass: complishonContext complishonClass) forHierarchy ].
	
	"Finally, globals"
	^ fetcher, (GlobalVariableComplishonFetcher new
			complishonEnvironment: complishonContext complishonEnvironment;
			yourself)
]

{ #category : #initialization }
ComplishonASTHeuristicsBuilder >> initialize [

	super initialize.
	messageHeuristic := CoSelfMessageHeuristic new
		next: (CoSuperMessageHeuristic new
			next: (CoVariableValueMessageHeuristic new
				next: (CoGlobalVariableMessageHeuristic new
					next: (CoVariableWithTypeNameMessageHeuristic new
						next: CoUnknownMessageHeuristic new)))).
	
	methodNodeHeuristic := CoSuperMessageHeuristic new
		next: CoUnknownMessageHeuristic new
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitMessageNode: aRBMessageNode [ 
	
	^ self
		configureFetcherForNode: aRBMessageNode
		usingHeuristicAvoidingRepetitions: messageHeuristic
		narrowingWith: aRBMessageNode selector
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitMethodNode: aRBMethodNode [ 

	^ self
		configureFetcherForNode: aRBMethodNode
		usingHeuristicAvoidingRepetitions: methodNodeHeuristic
		narrowingWith: aRBMethodNode selector
]

{ #category : #visiting }
ComplishonASTHeuristicsBuilder >> visitVariableNode: aRBVariableNode [ 
	
	^ self
		configureFetcher: (self fetcherForVariableNode: aRBVariableNode)
		forNode: aRBVariableNode
		narrowingWith: aRBVariableNode name
]
