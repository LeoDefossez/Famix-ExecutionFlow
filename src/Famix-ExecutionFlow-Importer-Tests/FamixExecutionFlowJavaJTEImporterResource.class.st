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
FamixExecutionFlowJavaJTEImporterResource class >> emptyMethodCall [

	| methodCall argsDict method |
	methodCall := Dictionary new.
	methodCall at: #arguments put: (argsDict := Dictionary new).
	argsDict at: #argsValues put: {  }.

	"create a simple method with no paremeter to make sure no errors happens from having no arguments"
	method := Dictionary new
		          at: #name put: #main;
		          at: #parentType put: (Dictionary new
				           at: #name put: 'java.Pharo';
				           yourself);
		          at: #isClassSide put: false;
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

{ #category : 'see class side' }
FamixExecutionFlowJavaJTEImporterResource >> seeClassSide [ 
]
