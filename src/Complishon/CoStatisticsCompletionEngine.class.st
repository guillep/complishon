Class {
	#name : #CoStatisticsCompletionEngine,
	#superclass : #CoCompletionEngine,
	#instVars : [
		'statistics'
	],
	#category : #'Complishon-Statistics'
}

{ #category : #initialization }
CoStatisticsCompletionEngine >> closeMenu [

	context ifNotNil: [
		CoStatistics uniqueInstance
			logCancelCompletionFromTypedToken: context completionToken
			inClass: (self completionClass ifNotNil: [ :class | class name ])
			withDynamicExtent: self isScripting ].
	super closeMenu
]

{ #category : #initialization }
CoStatisticsCompletionEngine >> initialize [

	super initialize.
	statistics := CoStatistics uniqueInstance.
	complishonBuilder := CoStatisticsASTHeuristicsResultSetBuilder new.
	contextClass := CoStatisticsCompletionContext.
]
