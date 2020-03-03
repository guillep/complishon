"
I am a fetcher looking for globals in an environment.
"
Class {
	#name : #GlobalVariableComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'complishonEnvironment'
	],
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
GlobalVariableComplishonFetcher >> complishonEnvironment [
	^ complishonEnvironment
]

{ #category : #accessing }
GlobalVariableComplishonFetcher >> complishonEnvironment: anObject [
	complishonEnvironment := anObject
]

{ #category : #accessing }
GlobalVariableComplishonFetcher >> entriesDo: aBlock [

	complishonEnvironment globals do: [ :e |
		aBlock value: (NECGlobalEntry contents: e node: self)]
]
