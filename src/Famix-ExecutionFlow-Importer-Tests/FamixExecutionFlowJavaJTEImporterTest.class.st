"
A FamixExecutionFlowJavaJTEImporterTest is a test class for testing the behavior of FamixExecutionFlowJavaJTEImporter
"
Class {
	#name : 'FamixExecutionFlowJavaJTEImporterTest',
	#superclass : 'TestCase',
	#instVars : [
		'importer'
	],
	#category : 'Famix-ExecutionFlow-Importer-Tests',
	#package : 'Famix-ExecutionFlow-Importer-Tests'
}

{ #category : 'running' }
FamixExecutionFlowJavaJTEImporterTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	importer := FamixExecutionFlowJavaJTEImporter new.
]

{ #category : 'accessing' }
FamixExecutionFlowJavaJTEImporterTest >> sourceResources [

	^ FamixExecutionFlowJavaJTEImporterResource
]

{ #category : 'tests' }
FamixExecutionFlowJavaJTEImporterTest >> testCreateMethodCallEmpty [

	| result |
	result := importer createMethodCall:
		          self sourceResources emptyMethodCall.

	"Should only be indirect method call for now"
	self assert: result class equals: FamixEFIndirectMethodCall.
	self assert: result method signature equals: 'java.Pharo.foo()'.
	
]

{ #category : 'tests' }
FamixExecutionFlowJavaJTEImporterTest >> testCreateMethodCallOneArgument [

	| result |
	result := importer createMethodCall:
		          (self sourceResources emptyMethodCall
			           at: #arguments
			           put: self sourceResources simpleArguments;
			           yourself).

	"Should only be indirect method call for now"
	self assert: result class equals: FamixEFIndirectMethodCall.
	self assert: result arguments size equals: 1
]

{ #category : 'tests' }
FamixExecutionFlowJavaJTEImporterTest >> testCreateMethodCallWithReceiver [

	| result |
	result := importer createMethodCall:
		          (self sourceResources emptyMethodCall
			           at: #receiver put: self sourceResources simpleReceiver;
			           yourself).

	"Should only be indirect method call for now"
	self assert: result class equals: FamixEFIndirectMethodCall.
	self assert: result receiver notNil
]

{ #category : 'tests' }
FamixExecutionFlowJavaJTEImporterTest >> testImportIsBasicTrace [
	"Smoke test, we just want to make sure no error happen"

	| result |
	result := FamixExecutionFlowJavaJTEImporter import:
		          self sourceResources basicTrace.

	self assert: result class equals: FamixEFModel.
	self assert: result entities notEmpty
]

{ #category : 'tests' }
FamixExecutionFlowJavaJTEImporterTest >> testImportIsOk [

	| result |
	result := FamixExecutionFlowJavaJTEImporter import: self sourceResources emptyTrace.
	
	self assert: result class equals: FamixEFModel.
	self assert: result entities isEmpty
]

{ #category : 'tests' }
FamixExecutionFlowJavaJTEImporterTest >> testReadFromIsOk [

	| result |
	result := importer readFrom: self sourceResources emptyTrace.
	
	self assert: result class equals: FamixEFModel.
	self assert: result entities isEmpty
]
