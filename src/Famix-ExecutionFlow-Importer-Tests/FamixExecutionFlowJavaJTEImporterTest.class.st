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
