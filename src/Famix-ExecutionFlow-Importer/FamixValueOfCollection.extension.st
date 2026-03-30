Extension { #name : 'FamixValueOfCollection' }

{ #category : '*Famix-ExecutionFlow-Importer' }
FamixValueOfCollection >> fillFrom: aCollection reader: aFamixExecutionFlowImporter [

	^ aFamixExecutionFlowImporter
		  fillValueOfCollection: self
		  with: aCollection
]
