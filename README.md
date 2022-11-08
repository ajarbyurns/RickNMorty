# RickNMorty

Made in XCode 13.1
Deployment Target : 14.0

Language : Swift

Tested on Virtual Device Emulator and iPhone 7 Plus 

UI : Programmatic
Design Pattern : MVVM
Pod : None

App has 3 main Screens which can be navigated using bottom tool bar
1. Character
  i. Shows List of Characters Along With its Name and Species in Grid Layout
    - When Cell is Clicked, App will present a fullscreen View containing Character Details
      1. Has a Back Button on Top to Navigate back to previous screen
  ii. Has a search TextField to filter the characters by Name
  iii. Has a Filter Button in Top Navigation Bar
    - When clicked, App will present a page containing buttons which represent filter options
      1. Has an Apply Button which dismisses the filter page and updates the Character Page based on the selected filters.
2. Location
  i. Shows a list of Locations along with its Name, Dimension, and Type
  ii. When Cell is Clicked, App will present a Page containing Location Details
      1. Page may be dismissed by dragging it down
  iii. Has a search TextField to filter the locations by Name
3. Episode
  i. Shows a list of Episodes along with its Name, Season Number, Episode Number, and Air Date
  ii. When Cell is Clicked, App will present a Page containing Episode Details
    1. Page may be dismissed by dragging it down
  iii. Has a search TextField to filter the episodes by Name

  
