# Task 3: Cover ViewModel with unit tests

## Functionality Description
"Start" button trigers 3 parallel requests which return "one", "two", "three" in a random order with 1...4 seconds delay for each.  
Top label shows how many requests completed. Second label showes accumulated sequence of requests results. Both lables are updated each time any parallel request is completed   

## Task to complete:
Cover `Task5ViewModel` with unit tests, check that:
- when `buttonPressed` is invoked viewModel properties binned to lables (`displayedText`, `loadedSequence`) have correspond values before any request is completed
- Check that ViewModel properties updated correctly for the sequence of completed APIs. When e.g. "one" request is completed it has values "loaded 1 of 3" and "loaded sequence: [one]", when after that "three" is completed they have values: "loaded 2 of 3" and "loaded sequence: [one] [three]" and etc)
