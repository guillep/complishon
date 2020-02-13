Class {
	#name : #GlobalVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #Complishon
}

{ #category : #accessing }
GlobalVariableComplishonFetcher >> entriesInContext: aContext do: aBlock [

	aContext complishonEnvironment globals do: aBlock
]
