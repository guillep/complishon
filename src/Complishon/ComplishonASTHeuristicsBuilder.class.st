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
		'methodNodeHeuristic',
		'variablesHeuristic'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #initialization }
ComplishonASTHeuristicsBuilder >> initialize [

	super initialize.
	methodNodeHeuristic := CoSuperMessageHeuristic new
		next: CoUnknownMessageHeuristic new.

	messageHeuristic := CoSelfMessageHeuristic new
		next: (CoSuperMessageHeuristic new
			next: (CoVariableValueMessageHeuristic new
				next: (CoLiteralMessageHeuristic new
					next: (CoGlobalVariableMessageHeuristic new
						next: (CoVariableWithTypeNameMessageHeuristic new
							next: CoUnknownMessageHeuristic new))))).
		
	variablesHeuristic := CoLocalScopeVariablesHeuristic new
		next: (CoWorkspaceVariablesHeuristic new
			next: (CoInstanceAccessibleVariablesHeuristic new
				next: CoGlobalVariablesHeuristic new)).

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
		configureFetcherForNode: aRBVariableNode
		usingHeuristic: variablesHeuristic
		narrowingWith: aRBVariableNode name
]
