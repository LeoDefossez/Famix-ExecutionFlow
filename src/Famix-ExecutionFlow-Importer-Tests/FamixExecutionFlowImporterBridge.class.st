"
I make a bridge to tests resources of importers.




"
Class {
	#name : 'FamixExecutionFlowImporterBridge',
	#superclass : 'GitBridge',
	#category : 'Famix-ExecutionFlow-Importer-Tests-Resources',
	#package : 'Famix-ExecutionFlow-Importer-Tests',
	#tag : 'Resources'
}

{ #category : 'accessing' }
FamixExecutionFlowImporterBridge class >> jteSources [

	^ self sources / 'JTE'
]

{ #category : 'accessing' }
FamixExecutionFlowImporterBridge class >> resources [

	^ self root / 'resources'
]

{ #category : 'accessing' }
FamixExecutionFlowImporterBridge class >> sources [

	^ self resources / 'sources' / 'JTE' / 'traces'
]

{ #category : 'see class side' }
FamixExecutionFlowImporterBridge >> seeClassSide [ 
]
