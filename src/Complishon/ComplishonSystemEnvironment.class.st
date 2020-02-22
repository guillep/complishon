"
I represent an environment for the completion.
I know a system dictionary, and can be initialized with for example, Smalltalk globals.
"
Class {
	#name : #ComplishonSystemEnvironment,
	#superclass : #Object,
	#instVars : [
		'systemDictionary'
	],
	#category : #'Complishon-SystemIntegration'
}

{ #category : #'instance creation' }
ComplishonSystemEnvironment class >> forSmalltalkGlobals [

	^ super new
		systemDictionary: Smalltalk globals;
		yourself
]

{ #category : #'instance creation' }
ComplishonSystemEnvironment class >> new [

	^ self forSmalltalkGlobals
]

{ #category : #accessing }
ComplishonSystemEnvironment >> at: aString ifPresent: aBlockClosure [
	
	systemDictionary at: aString ifPresent: aBlockClosure
]

{ #category : #accessing }
ComplishonSystemEnvironment >> environmentAt: aKey ifPresent: aBlock [
	
	^ systemDictionary at: aKey ifPresent: aBlock
]

{ #category : #accessing }
ComplishonSystemEnvironment >> globals [
	
	^ systemDictionary keys sorted
]

{ #category : #accessing }
ComplishonSystemEnvironment >> systemDictionary: aDictionary [

	systemDictionary := aDictionary
]
