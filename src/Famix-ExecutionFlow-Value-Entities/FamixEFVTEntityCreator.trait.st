"
This trait is used by Famix models.
It provides an API for creating entities and adding them to the model.


"
Trait {
	#name : 'FamixEFVTEntityCreator',
	#category : 'Famix-ExecutionFlow-Value-Entities-Model',
	#package : 'Famix-ExecutionFlow-Value-Entities',
	#tag : 'Model'
}

{ #category : 'meta' }
FamixEFVTEntityCreator classSide >> annotation [

	<FMClass: #TEntityCreator super: #Object>
	<package: #'Famix-ExecutionFlow-Value-Entities'>
	<generated>
	^ self
]

{ #category : 'entity creation' }
FamixEFVTEntityCreator >> newArgument [

	<generated>
	^ self add: FamixEFVArgument new
]
