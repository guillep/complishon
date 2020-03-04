Class {
	#name : #CoBasicCompletionTest,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'innerNode',
		'completionClass',
		'completionEnvironment'
	],
	#category : #'Complishon-Tests'
}

{ #category : #testing }
CoBasicCompletionTest class >> isAbstract [

	^ self == CoBasicCompletionTest
]

{ #category : #tests }
CoBasicCompletionTest >> completionClass [

	^ completionClass
]

{ #category : #tests }
CoBasicCompletionTest >> completionEnvironment [

	^ completionEnvironment
]

{ #category : #tests }
CoBasicCompletionTest >> innerASTNode [
	| nodeInsideABlock |
	RBMethodNode
		selector: #foo
		arguments: (#(methodArgument) collect: [ :e | RBVariableNode named: e ])
		body:
			(RBSequenceNode
				temporaries: (#(methodTemporary) collect: [ :e | RBVariableNode named: e ])
				statements:
					{(RBBlockNode
						arguments: (#(blockArgument) collect: [ :e | RBVariableNode named: e ])
						body:
							(RBSequenceNode
								temporaries: (#(blockTemporary) collect: [ :e | RBVariableNode named: e ])
								statements: {(nodeInsideABlock := RBVariableNode named: '')}))}).
	^ nodeInsideABlock
]

{ #category : #tests }
CoBasicCompletionTest >> setUp [

	super setUp.
	completionClass := CoMockClass new
		instanceVariables: #(a b c);
		selectors: #(ma mb mc);
		classVariables: #(Ca Cb Cc);
		superclass: (CoMockClass new
			instanceVariables: #( supera superb superc );
			selectors: #(superma supermb supermc);
			classVariables: #(SuperCa SuperCb SuperCc);
			yourself)
		yourself.
	
	completionEnvironment := CoMockEnvironment new
		globals: {'A' . 'B' . 'C'};
		yourself
]
