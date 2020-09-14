# BBExplore
A Breaking Bad Demo App

The VIPER-like architecture of this app attempts to keep responsibilities of its components separate.

Views take their direction from Presenters that get their data from Interactors. An Observer model of interaction is used to further decouple everything and prevent spaghetti.

Logic concerned with Breaking Bad characters should only be in CharactersModule while logic concerning 
the display of a list of cells in a tableview should be in ListUIModile. 

App-specific code is prefixed with "BB"
