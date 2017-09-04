# BRILLIANT CUT solution

## Stephen Sykes

### Solution description

This is of course a variation on the well known knapsack problem.

The algorithm I used lazily creates a table of results for each size of raw
stone. We know that the best(size) is the best result of
trying each of the cuts, and adding best(size - currentCutSize).

As the result for each size is calculated once, this should be very
efficient at totalling the values of the list of raw gems.

SWift offers a nice combination of features for this solution, including
the functional reduce() and class and struct types, used for Stone and 
Chunk (which finds its own value on initialisation) respectively.

To run the program, use swift from the command line:

    $ swift wunder.swift 
    103228

I have also included a playground (with necessarily slightly different code for loading
the json file) for experimentation.

### Thanks

Thanks to Wunderdog for [posing yet another fun puzzle](http://wunder.dog/brilliant-cut).
