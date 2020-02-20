Class {
	#name : #PackageImplementedMessagesComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#instVars : [
		'complishonPackage'
	],
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
PackageImplementedMessagesComplishonFetcher >> complishonPackage [
	^ complishonPackage
]

{ #category : #accessing }
PackageImplementedMessagesComplishonFetcher >> complishonPackage: anObject [
	complishonPackage := anObject
]

{ #category : #accessing }
PackageImplementedMessagesComplishonFetcher >> entriesDo: aBlock [
	
	SystemNavigation new allSentMessagesInPackage: complishonPackage do: aBlock
]
