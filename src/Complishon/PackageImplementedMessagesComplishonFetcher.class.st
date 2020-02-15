Class {
	#name : #PackageImplementedMessagesComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #'Complishon-Fetchers'
}

{ #category : #accessing }
PackageImplementedMessagesComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	aContext complishonClass ifNil: [
		"Playground? Do nothing for now"
		^ self
	].
	SystemNavigation new allSentMessagesInPackage: aContext complishonPackage do: aBlock
]
