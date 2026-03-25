Class {
	#name : 'FamixExecutionFlowAbstractImporter',
	#superclass : 'Object',
	#category : 'Famix-ExecutionFlow-Importer',
	#package : 'Famix-ExecutionFlow-Importer'
}

{ #category : 'api' }
FamixExecutionFlowAbstractImporter class >> import: aFileReference [

	^ self new readFrom: aFileReference
]

{ #category : 'instance creation' }
FamixExecutionFlowAbstractImporter >> readFrom: aFileReference [

	self subclassResponsibility 
]
