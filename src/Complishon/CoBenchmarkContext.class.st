Class {
	#name : #CoBenchmarkContext,
	#superclass : #Object,
	#instVars : [
		'method',
		'callsite'
	],
	#category : #'Complishon-Benchmarks'
}

{ #category : #accessing }
CoBenchmarkContext >> callsite [
	^ callsite
]

{ #category : #accessing }
CoBenchmarkContext >> callsite: anObject [
	callsite := anObject
]

{ #category : #accessing }
CoBenchmarkContext >> complishonClass [
	
	^ callsite methodNode methodClass
]

{ #category : #accessing }
CoBenchmarkContext >> doItContext [
	
	^ nil
]

{ #category : #accessing }
CoBenchmarkContext >> doItRequestor [

	^ nil
]

{ #category : #accessing }
CoBenchmarkContext >> environmentAt: aString ifPresent: aBlockClosure [ 
	
	self class environment at: aString ifPresent: aBlockClosure
]

{ #category : #testing }
CoBenchmarkContext >> isWorkspace [
	
	^ false
]

{ #category : #accessing }
CoBenchmarkContext >> position [
	
	^ callsite keywordsIntervals first first
]

{ #category : #accessing }
CoBenchmarkContext >> source [
	
	^ callsite methodNode method sourceCode
]
