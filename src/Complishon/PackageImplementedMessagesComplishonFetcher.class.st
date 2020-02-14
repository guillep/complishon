Class {
	#name : #PackageImplementedMessagesComplishonFetcher,
	#superclass : #ComplishonFetcher,
	#category : #Complishon
}

{ #category : #accessing }
PackageImplementedMessagesComplishonFetcher >> entriesInContext: aContext do: aBlock [
	
	SystemNavigation new allSentMessagesInPackage: aContext complishonPackage do: aBlock
]
