Extension { #name : 'FamixValueOfObject' }

{ #category : '*Famix-ExecutionFlow-Importer' }
FamixValueOfObject >> fillFrom: aCollection reader: aFamixExecutionFlowImporter [

	^ aFamixExecutionFlowImporter
		  fillValueOfObject: self
		  with: aCollection
]
