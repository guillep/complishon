"
I am a fetcher looking for the class variables implemented in a class.
"
Class {
	#name : #ClassVariableComplishonFetcher,
	#superclass : #ClassBasedComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
ClassVariableComplishonFetcher >> entriesDo: aBlock [
	
	self completionClass instanceSide classVarNames do: [ :e |
		aBlock value: (NECClassVarEntry contents: e node: self)]
]
