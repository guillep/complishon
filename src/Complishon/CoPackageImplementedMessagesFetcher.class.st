"
I am a fetcher that yields the messages implemented in the given package.
"
Class {
	#name : #CoPackageImplementedMessagesFetcher,
	#superclass : #CoFetcher,
	#instVars : [
		'complishonPackage'
	],
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
CoPackageImplementedMessagesFetcher >> complishonPackage [
	^ complishonPackage
]

{ #category : #accessing }
CoPackageImplementedMessagesFetcher >> complishonPackage: anObject [
	complishonPackage := anObject
]

{ #category : #accessing }
CoPackageImplementedMessagesFetcher >> entriesDo: aBlock [
	
	SystemNavigation new allSentMessagesInPackage: complishonPackage do: [ :e |
		aBlock value: (NECSelectorEntry contents: e node: self)]
]
