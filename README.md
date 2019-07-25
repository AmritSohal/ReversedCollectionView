# ReversedCollectionView
This will Populate CollectionView from bottom-Right

I've created UICollectionViewLayout class named "InvertedStackLayout" Which will automatically take Care about CollectionView reverse Populate.

Usage: 

1) Just Create obeject for "InvertedStackLayout" class

For Example:-

let reversedLayout = InvertedStackLayout()

2) Assign it to your collectionViewController

For Example:-

yourCollectionViewController.collectionViewLayout = reversedLayout

That's it.
