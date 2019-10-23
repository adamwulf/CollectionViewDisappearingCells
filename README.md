
## UICollectionView Cell Display Bug

UICollectionView incorrectly hides cells when they should be visible.


### Source Code
The included source code provides a custom UICollectionViewLayout that overrides the appropriate methods.
The datasource is hardcoded to 20 items and 1 section, and similarly, the layout for those 20 items is hardcoded.

Importantly, `layoutAttributesForElementsInRect:` always returns the correct attributes for any input rect,
and it never returns zero items, even though the screen sometimes shows zero cells. `NSLog` outputs the index
paths returned for each input `rect`, showing that the correct paths are being returned.

### Reproduced On
The following bug is visible in the simulator using iPad Air (3rd generation) running iOS 13.1. The bug
does not appear on my 12.9" iPad Pro (2nd gen), or the 12.9" iPad Pro (3rd gen) simulator.

### Reproduction steps

1. Run the demo app
2. scroll to the right-hand size of cell 0,0
3. note the cell disappears when it should stay visible
4. scroll down to 0,5
5. note the cell disappears when it should stay visible
6. note the logs show that elements are always returned for `layoutAttributesForElementsInRect:`


