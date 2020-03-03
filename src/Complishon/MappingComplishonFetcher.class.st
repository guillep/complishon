"
I am a mapping complishon fetcher. I decorate a complishon fetcher and transform its results to those ones using the collectBlock block.
I can be created by sending the #collect: message to an existing fetcher.

(GenericComplishonFetcher onCollection: aCollection) collect [ :each | each * 2 ]
"
Class {
	#name : #MappingComplishonFetcher,
	#superclass : #ComplishonFetcherDecorator,
	#instVars : [
		'collectBlock'
	],
	#category : #'Complishon-Core'
}

{ #category : #accessing }
MappingComplishonFetcher >> collectBlock: aBlockClosure [ 
	
	collectBlock := aBlockClosure
]

{ #category : #accessing }
MappingComplishonFetcher >> entriesDo: aBlockClosure [

	decoree entriesDo: [ :each | aBlockClosure value: (collectBlock value: each) ]
]
