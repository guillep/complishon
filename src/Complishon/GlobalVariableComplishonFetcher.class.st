Class {
	#name : #GlobalVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
GlobalVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [

	aContext complishonEnvironment globals do: aBlock
]
