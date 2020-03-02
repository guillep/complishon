"
I implement an heuristic for variables accessible from the instance side, such as instance variables and class variables.

See my superclass for details.
"
Class {
	#name : #CoInstanceAccessibleVariablesHeuristic,
	#superclass : #CoASTNodeFetcherHeuristic,
	#category : #'Complishon-Heuristics'
}

{ #category : #requests }
CoInstanceAccessibleVariablesHeuristic >> appliesForNode: aNode inContext: aContext [

	^ aContext isWorkspace not
]

{ #category : #requests }
CoInstanceAccessibleVariablesHeuristic >> buildFetcherFor: aNode inContext: complishonContext [
	
	| ivFetcher cvFetcher |
	
	"Then instance variables"
	ivFetcher := (InstanceVariableComplishonFetcher new
		completionClass: complishonContext complishonClass) forHierarchy.
	
	"Then class variables if not a workspace"
	cvFetcher :=  (ClassVariableComplishonFetcher new
			completionClass: complishonContext complishonClass) forHierarchy.
	
	^ ivFetcher, cvFetcher, (next fetcherFor: aNode inContext: complishonContext)
]
