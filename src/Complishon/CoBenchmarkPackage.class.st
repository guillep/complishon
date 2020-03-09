Class {
	#name : #CoBenchmarkPackage,
	#superclass : #Object,
	#instVars : [
		'package'
	],
	#category : #'Complishon-Benchmarks'
}

{ #category : #'instance creation' }
CoBenchmarkPackage class >> on: aRPackage [ 
	
	^ self new
		package: aRPackage;
		yourself
]

{ #category : #enumerating }
CoBenchmarkPackage >> methodsDo: aBlockClosure [ 
	
	package definedClassesDo: [ :each | | class |
		class := self class environment at: each.
		class isTrait ifFalse: [
			(package definedMethodsForClass: class) do: aBlockClosure] ]
]

{ #category : #accessing }
CoBenchmarkPackage >> package: aRPackage [ 
	
	package := aRPackage
]
