thethingwiththestuff
====================

[![Build Status](https://secure.travis-ci.org/grillp/thethingwiththestuff.png?branch=master)](https://travis-ci.org/grillp/thethingwiththestuff)

The Thing with the Stuff

Description
-----------

Implementation of a simple Point of Sale Terminal

The terminal is setup with a number of price points for items.

e.g

* 'ITEM1' - $2.00 each or 3 for $5.00
* 'ITEM2' - $6.00 each

Items can then be scanned into the terminal one at a time.

When all items are scanned, a total cost for all the scanned items can be retrieved

Details
-------

The main component of the solution is the `PointOfSaleTerminal` class.

To initialise the `PointOfSaleTerminal` prices, you call the `set_pricing` method.

`set_pricing` takes a single parameter which descibes the prices (or price points) for each item. A price point consists of a name, price and quantity.

The parameter passed is an array of hashes, where each hash describes a single price point by it's name, price and quantity.

e.g. for the example above, you would call `set_pricing` with:

```
terminal.set_pricing([
                       {name: 'ITEM1', price: 2.00, quantity: 1},
                       {name: 'ITEM1', price: 5.00, quantity: 3},
                       {name: 'ITEM1', price: 2.00, quantity: 1}
                     ])
```

To scan purchased items into the terminal, use the `scan` method. This method is called with the name of the item you wish to scan.

e.g. to scan an 'ITEM1', you would call:
```
   terminal.scan('ITEM1')
```
If you wish to scan multiple quantities of an item, you would `scan` each item individually... just like at the supermarket!

To get the total price of all scanned items, you call the `total` method, which will calculate the price of all the scanned items, taking into account the price points added to the terminal.

Environment
-----------
* git repo @ github --> <https://github.com/grillp/thethingwiththestuff>
* rbenv to setup my ruby environment (1.9.3)
* bundler to set dependencies
* travis CI for.. well.. CI! --> <https://travis-ci.org/grillp/thethingwiththestuff>
* the `guard` gem to run rpec automagically (awesome!)
* rake for the build

Testing
-------

Everything developed TDD Style

I Have an acceptance test as an rspec test in `rspec/acceptance/point_of_sale_terminal_acceptance_spec.rb`

I did not do a BDD style acceptance test (e.g Cucumber).. seemed a little heavy handed for the problem

Design Notes
------------

* The format of the data passed to set_pricing needs to be correct. I do check for incorrectly specified or missing hash keys in the price point hashes, and will throw a  `RuntimeError` if a required key is missing

* I don't check the types of the attributes in the price points. If you don't use numeric values for price and quantity, It will go boom!

* Scanning an 'item' that has no price point associated with it will throw a `RuntimeError`

* The algorithm for determining the largest price point quantity that will fit with the remaining quantity (`PricePointHelper.find_highest_not_greater_than_target`) is not terribly efficient (reducing over all values). However due to the unsorted nature of the `hash.keys`, it was still more efficient than sorting the keys each time and then scanning the list to see which value is highest, but not more than the target value. And for the small number of '*n*' it did not make any real difference

* I put the `PricePointHelper.find_highest_not_greater_than_target` as a Module so that I could test it in isolation.
