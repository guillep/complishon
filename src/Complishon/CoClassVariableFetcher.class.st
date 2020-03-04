"
I am a fetcher looking for the class variables implemented in a class.
"
Class {
	#name : #CoClassVariableFetcher,
	#superclass : #CoClassBasedFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #entries }
CoClassVariableFetcher >> entriesDo: aBlock [
	
	self completionClass instanceSide classVarNames do: [ :e |
		aBlock value: (NECClassVarEntry contents: e node: self)]
]
