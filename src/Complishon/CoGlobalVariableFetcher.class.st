"
I am a fetcher looking for globals in an environment.
"
Class {
	#name : #CoGlobalVariableFetcher,
	#superclass : #CoFetcher,
	#instVars : [
		'complishonEnvironment'
	],
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
CoGlobalVariableFetcher >> complishonEnvironment [
	^ complishonEnvironment
]

{ #category : #accessing }
CoGlobalVariableFetcher >> complishonEnvironment: anObject [
	complishonEnvironment := anObject
]

{ #category : #accessing }
CoGlobalVariableFetcher >> entriesDo: aBlock [

	complishonEnvironment globals do: [ :e |
		aBlock value: (NECGlobalEntry contents: e node: self)]
]
