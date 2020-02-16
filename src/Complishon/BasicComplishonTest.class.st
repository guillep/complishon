Class {
	#name : #BasicComplishonTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'Complishon-Tests'
}

{ #category : #testing }
BasicComplishonTest class >> isAbstract [

	^ self == BasicComplishonTest
]

{ #category : #tests }
BasicComplishonTest >> context [
	| innerNode |
	
	context ifNotNil: [ ^ context ].
	
	RBMethodNode
		selector: #foo
		arguments: (#( methodArgument ) collect: [ :e | RBVariableNode named: e ])
		body: (RBSequenceNode
			temporaries: (#( methodTemporary ) collect: [ :e | RBVariableNode named: e ])
			statements: {RBBlockNode
				arguments: (#(blockArgument) collect: [ :e | RBVariableNode named: e ])
				body: (RBSequenceNode
					temporaries: (#(blockTemporary) collect: [ :e | RBVariableNode named: e ])
					statements: { innerNode := RBVariableNode named: '' })}).
	^ context := ComplishonContext new
		complishonClass:
			(ComplishonMockClass new
				instanceVariables: #(a b c);
				selectors: #(ma mb mc);
				classVariables: #(Ca Cb Cc);
				superclass: (ComplishonMockClass new
					instanceVariables: #( supera superb superc );
					selectors: #(superma supermb supermc);
					classVariables: #(SuperCa SuperCb SuperCc);
					yourself)
				yourself);
		complishonEnvironment:
			(ComplishonMockEnvironment new
				globals: {'A' . 'B' . 'C'};
				yourself);
		astNode: innerNode;
		yourself.
]
