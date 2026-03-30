"
I simplify access to different sources resources obtained through `FamixExecutionFlowImporterBridge` for the JavaTraceExtractor importer
"
Class {
	#name : 'FamixExecutionFlowJavaJTEImporterResource',
	#superclass : 'Object',
	#category : 'Famix-ExecutionFlow-Importer-Tests',
	#package : 'Famix-ExecutionFlow-Importer-Tests'
}

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporterResource class >> basicTrace [

	^ FamixExecutionFlowImporterBridge sources / 'basicTrace.tr'
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporterResource class >> emptyMethodCall [

	| methodCall argsDict method |
	methodCall := Dictionary new.
	methodCall at: #arguments put: (argsDict := Dictionary new).
	methodCall at: #receiver put: nil.
	argsDict at: #argsValues put: {  }.

	"create a simple method with no paremeter to make sure no errors happens from having no arguments"
	method := Dictionary new
		          at: #name put: #main;
		          at: #parentType put: (Dictionary new
				           at: #name put: 'java.Pharo';
				           yourself);
		          at: #isClassSide put: true;
		          at: #signature put: 'java.Pharo.foo()';
		          at: #parameters put: {  };
		          yourself.
	methodCall at: #method put: method.
	^ methodCall
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporterResource class >> emptyTrace [

	^ FamixExecutionFlowImporterBridge sources / 'emptyTrace.tr'
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporterResource class >> simpleArguments [

	^ Dictionary new
		  at: #argsValues put: { self simpleClassReferenceDict };
		  yourself
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporterResource class >> simpleClassReferenceDict [

	^ Dictionary new
		  at: #reference put: (Dictionary new
				   at: #refered put: (Dictionary new
						    at: #fields put: {  };
						    yourself);
				   at: #uniqueId put: 1;
				   at: #type put: (Dictionary new
					    at: #name put: 'im.an.Object';
					    yourself);
				   yourself);
		  yourself
]

{ #category : 'as yet unclassified' }
FamixExecutionFlowJavaJTEImporterResource class >> simpleReceiver [

	^ self simpleClassReferenceDict
]

{ #category : 'see class side' }
FamixExecutionFlowJavaJTEImporterResource >> seeClassSide [ 
]
