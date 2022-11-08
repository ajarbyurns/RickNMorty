# RickNMorty

Made in XCode 13.1

Deployment Target : 14.0

Language : Swift

Tested on XCode Device Emulator and iPhone 7 Plus 

UI : Programmatic

Design Pattern : MVVM

Pod : None

App has 3 main Screens which can be navigated using bottom tool bar
1. Character
  - Shows List of Characters Along With its Name and Species in Grid Layout
    - When Cell is Clicked, App will present a fullscreen View containing Character Details
      - Has a Back Button on Top to Navigate back to previous screen
  - Has a search TextField to filter the characters by Name
    - Press Return Button After Entering Text
  - Has a Filter Button in Top Navigation Bar
    - When clicked, App will present a page containing buttons which represent filter options
      - Has an Apply Button which dismisses the filter page and updates the Character Page based on the selected filters.
  - Loads More Data When as User scrolls down
2. Location
  - Shows a list of Locations along with its Name, Dimension, and Type
  - When Cell is Clicked, App will present a Page containing Location Details
    - Page may be dismissed by dragging it down
  - Has a search TextField to filter the locations by Name
    - Press Return Button After Entering Text
  - Loads More Data When as User scrolls down
3. Episode
  - Shows a list of Episodes along with its Name, Season Number, Episode Number, and Air Date
  - When Cell is Clicked, App will present a Page containing Episode Details
    - Page may be dismissed by dragging it down
  - Has a search TextField to filter the episodes by Name
    - Press Return Button After Entering Text
  - Loads More Data When as User scrolls down
    
Screenshots can be viewed in the 'Screenshots' folder
    
