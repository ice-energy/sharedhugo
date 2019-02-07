---
title:  "Github Plus Hugo"
date:   2019-02-06T12:19:00
tags:
- github
categories:
- Systems/Solutions
description : "A Hugo Repository stored in github, can be used as a Static Website"
draft: false
cover: "/sharedhugo/img/cover_githubhugo.jpg"
menu: main

---

![pic1](../img/githubhugo.jpg)

---

*Hugo* is an open-source static website generator.   It has many themes and many layouts
ready to choose from.   **Content** in *Hugo* consists of posts that you add
using markdown format, and the posts are arranged in a logical directory tree structure.
See the Hugo site here: [Hugo Website](https://gohugo.io).

I put together 3 Hugo sites, using the same set of post files.   Have a quick look:

 - [ice-energy.github.io/jreed](https://ice-energy.github.io/jreed)
 - [ice-energy.github.io/user1](https://ice-energy.github.io/user1)
 - [ice-energy.github.io/user9](https://ice-energy.github.io/user9)

3 questions you probably have after looking at that:

 1.  We have a github account?
 2.  Holy Cow, how'd you do that?
 3.  How do you keep documents private?



# We have a github account?

Yeah, github accounts are free.  Pick a username and go.
For the *free deal*, all your repositories are public.

For $99/year, repositories can be made private.

I have the Password, I'll give it to you if you want to host
your repository here as well.


# How'd you do that?

While Github is known as a source code repository, it is also something else:

> If the repository you are storing ALSO happens to be a Static Website,
  Github can serve up pages from the site.

**Let that sink in!**

```

It's completely unprecendented to have your code repository
ALSO serve up web-pages that happen to be stored there.

The key concept is that checking in your code and pushing
the resulting git branch to the server is EQUIVALENT to publishing
your website.

It's a new paradigm, and it's really incredible.  It makes
Documentation Management incredibly easy!

```

With proper configuration of the github repository, and proper layout
of the data you are storing there, **github can serve up the pages**.

With Hugo installed locally on my linux workstation, here's the process I use
for creating that website:

   - edit content, simple .txt file
   - Run Hugo from within a shell script.  This generates the entire static site.
   - use git to check-in changes, and push to Server
   - browse to site, wait a bit for changes to propagate



# How do you keep documents private?

1st of all, pay the $99 fee.   That means the repositories are private, but the
website pages are not.    The key is knowing where the publicly
browsable files are, and not putting private documents there.

The solution to pub/priv relies on a logical arrangement of the source code tree.

See the repositories at:

 - [github.com/ice-energy/jreed](https://github.com/ice-energy/jreed)
 - [github.com/ice-energy/user1](https://github.com/ice-energy/user1)
 - [github.com/ice-energy/user9](https://github.com/ice-energy/user9)

Each of those repo's have 2 content directories, which are the *Source Material* of
the documents.

 - [content_pub](https://github.com/ice-energy/jreed/tree/master/content_pub) &nbsp; &nbsp; &nbsp;  publicly browsable content.
 - [content_priv](https://github.com/ice-energy/jreed/tree/master/content_priv) &nbsp; &nbsp; &nbsp; private content, not to be displayed on github.

My technique for public/private then is to generate 2 different
sites, that are completely seperate:

   - One meant for public viewing on github
   - The 2nd one stored on github, **But must be copied somewhere else to be displayed**

To do this requires executing Hugo twice while using the proper Source and
Destination flags.

*For the publicly visible:*

```
  hugo -c "./content_pub" -d "./docs"
```

*To remain private:*

```
  hugo -c "./content_priv" -d "./docs_priv"
```

The 2 output directories, *docs* and *docs_priv*, are both:

>  Standalone, Static, Hugo-Based Websites

*docs* gets displayed by github as default.  *docs_priv* will have to
be copied somewhere else to be displayed.


# A few more notes

See the file [x.sh](https://github.com/ice-energy/jreed/blob/master/x.sh).
It's the shell script that automates the running of Hugo.


My platform is *linux*, there'd be just a bit of work to do getting this
to run on Windows.   *x.sh* might have to be turned into a .bat file.
Haven't done that yet.    *Hugo* is supposed to run fine on Windows, but
again, something I haven't done yet.

Hugo should also be supported on Mac.

I'd be glad to help anyone get this up and running for themselves.
Also, it's not too difficult to set up different themes from gohugo.io.


JR



























