#  Issues

So i have this extrange case

Given. I have a custom View with 2 `UIImageView` inside a subclass of `UITableViewCell` that covers the whole screen,
that custom view uses a `UIViewPropertyAnimator` to do a custom transition between a set of images
(different than the animation of images inside a single `UIImageView`) that modifies the `alpha` and `trasform` properties of the image views.

When I trigger the animation in the first 2 cells (the fresh instances to be reused), the animation works perfectly,

Then, when I reuse the cell, set new image values in the `UIImageView` the animation doesn't just work,
and i come back to the previous cells and where the animation used to work is broken now.

I have tried:

- reusing the instance of `UIViewPropertyAnimator` and set `pausesOnCompletion` to not finish the animation
- creating a new `UIViewPropertyAnimator` instance on each cell reuse

Both things don't work. Printing the `opacity` of the presentation layer of the image view does not change when the animation is broken,
but shows the right values when the animation works.

Here is a video showing the issue: https://www.dropbox.com/s/3vb6f50xqt3p8w5/ScreenRecording_01-12-2018%2009-29-48.MP4?dl=0

A sample project with the code can be found here:

