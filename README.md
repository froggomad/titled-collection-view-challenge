# TitledCollectionView Challenge
Thanks for taking the time to read (and hopefully follow along with) 
my article on [making MVC less massive](https://medium.com/geekculture/making-mvc-less-massive-and-more-reusable-cf731154ffbe). In this challenge, you will 
clean up the starter project by organizing everything into separate 
files and groups, get rid of duplicated code, and add a detail view

# Welcome to the Swift 5 DRY and new feature challenge

The goal of this challenge is to get you used to staying within a
given architecture's rules (MVC in this case) while using good
coding and Software Development practices.

`NOTE:` You are *not* expected to be able to complete these challenges
based on information contained solely in the article that likely brought
you here. You are expected to have to do research - that's probably 80% of
our job as Developers anyway. I will give you ideas and maybe hints, but
the crux of the implementation is up to you.

# Instructions

1. [Fork this repo](https://guides.github.com/activities/forking/)
2. Make small, meaningful commits. This means when you make a change,
commit it right away. You don't have to wait until everything is perfect,
but the project should at least build and run in each commit. It's preferred
that all tests are passing (when unit tests are enabled) and all features
behave as expected, but this isn't necessarily feasible for every single
commit in every single project.
3. Double check that the project builds and runs before you push your commits 😉
4. When you've finished all challenges, [create a Pull Request](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)
back to the [main challenge repository](https://github.com/froggomad/titled-collection-view-challenge)
5. Comment on the article where you found this challenge: "I completed the challenge: \<link to Pull Request\>"

## Challenge #1

The first concept we'll practice is organization. I like organizing my 
files and folders by feature first, then by architecture. This seems
like a logical way for everyone to easily find what they're looking for.
This is what that looks like:

![MVC Feature Organization](Media/MVC%20Feature%20Organization.png)

When you create a new feature, create a new group with the feature's name.

As you add on to a feature (or if you're organizing an existing feature)
create a new group for each layer in the architecture that pertains to the 
feature. For MVC, that'd be a group for View (or Views) Model (or Models) and
Controller (or Controllers). Inside of the Controller(s) group, I often have a 
model controller group and a view controller group. 

`Note:` some say all of these groups are overkill. You don't necessarily need 
a group for each layer, especially if your files are named appropriately.

`🔺IMPORTANT!` If you move the `info.plist` file into a group, and not a *group 
without folder*, you will receive a build error. This can be resolved by [changing
the info.plist's location in the project's build settings](https://stackoverflow.com/questions/58103585/xcode-11-cant-reallocate-info-plist-into-a-group).

*Your challenge*:

Armed with the above knowledge, organize your files into groups, build and run the
project, and when it's running as expected, make a commit, and push.

## Challenge #2

The code for our Fruit and Vegetable description is duplicated! There are a number
of ways to resolve this. One way may help resolve another challenge as well.

Here are some ideas:

Can you use a protocol to join the 2 types together? If it's possible, you could then 
extend the protocol and provide default implementation for the property.

Can you create an extension on String with a method that both types can use?

Can you create an all-encompassing type for `Produce` and maintain good separation of concerns?<br>
`Warning:` this can lead to pretty bloated objects as you add on to a project.

Can you create a global function that somehow solves this problem? (least recommended)

*Your challenge*:

Find a way of reducing code duplication by consolodating the logic for the description of 
`Fruit` and `Vegetable`. Remember to make small, meaningful commits - and remember to make sure
the project builds and runs! 

Once you're finished, push your commits.

## Challenge #3 - More Duplication!

Similar to challenge #2, our protocol has 2 *very* similar methods. As we add on to our project, 
it's likely that we'll end up duplicating more and more code in these 2 methods as we implement 
them for different types. We'll also need to add a new method to our protocol's definition.

![protocol duplication](Media/protocol%20duplication.png)

Can you think of a way of consolidating these 2 methods?

🧐 I think I mentioned in an earlier challenge that one of the solutions may help with a later one.

Remember to make meaningful commits as you go. Even if the solution isn't fully working, it can help
to have a record of what you've done to get to where you are if you get stuck. Once you've somehow 
combined the 2 methods, remember to make sure the project functions as expected! (building and running 
included 🤪)

## Challenge #4 - Visual bugs!
![black bars](Media/cell%20glitch.png)

`Note:` This is a 2 part challenge

### Part 1
Where are those black bars coming from?!? It's likely that we forgot to give one of our elements a 
background color. When creating elements programmatically, it's necessary to provide the backgroundColor.
This is a chance for you to get creative as well. You could use the same color for each type, or you could 
choose to add a color property to your `Fruit` and `Vegetable` and use that to differentiate the 2 different
types of produce. Remember to update your `viewModel` with any properties you add to your model that you want
to display.

### Part 2 (optional)
This is also probably means since there aren't any black bars at top and bottom that our cells aren't sized 
correctly. Can you find a way to create uniform spacing around the cell? This is optional because you may 
prefer for the cell to be full height, and not full width.

Remember to make meaningful commits as you go. Once you've completed what you want to complete, the project 
builds and runs, and is working as you expect it to, push your changes.

## Challenge #5 - the final challenge!
Now that we've gotten rid of code duplication, let's add our new feature. What we want to do is add a simple
detail view. A detail view is just a further representation of a selected item. So when the user selects a 
fruit or vegetable, we want to present them with more information on the object they've selected.

Feel free to get as creative as you want with it. At a mimimum, your detail view should contain the item's 
description. If you added a color property previously, it might be cool to use that as the detail view's 
background color. You can also add images and whatever other elements to this view as you'd like.

In order for this to be considered working properly, you must devise a way for the user to tap on an item
and be presented with more information about *just that item*.

A simple implementation would be to create a new ViewController (or 2 if you couldn't figure out how to 
remove duplication previously), give it a label and `yourProduceType` property. When the produce is set, 
the view should update with its information.

Remember to make small, meaningful commits. Once you have a view that represents the selected item and 
you've styled it to your liking, push your commits.

Here's a sample of a working Detail View

![detailView](Media/working.gif)
