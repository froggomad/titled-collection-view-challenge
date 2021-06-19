# TitledCollectionView Challenge
Thanks for taking the time to read (and hopefully follow along with) 
my article on making MVC less massive. In this challenge, you will 
clean up the starter project by organizing everything into separate 
files and groups, get rid of duplicated code, and add a detail view

# Welcome to the Swift 5 DRY and new feature challenge

The goal of this challenge is to get you used to staying within a
given architecture's rules (MVC in this case) while using good
coding and Software Development practices.

# Instructions

1. [Fork this repo](https://guides.github.com/activities/forking/)
2. Make small, meaningful commits. This means when you make a change,
commit it right away. You don't have to wait until everything is perfect,
but the project should at least build and run in each commit. It's preferred
that all tests are passing (when unit tests are enabled) and all features
behave as expected, but this isn't necessarily feasible for every single
commit in every single project.
3. Double check that the project builds and runs before you push your commit 😉
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
without folder*, you will receive a build error.

*Your challenge*: 

Armed with the above knowledge, organize your files into groups, build and run the
project, and when it's running as expected, make a commit, and push.
