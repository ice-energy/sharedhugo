
This is a Hugo tree, and is meant to be built using
[hugo](https://gohugo.io).

```
     git clone https://github.com/ice-energy/sharedhugo.git
     cd sharedhugo
     hugo -c "./content" -d "./docs"
```

hugo outputs a directory named **public** (default output directory)
in the above example, the -d option causes the output to be written to ./docs.

Those 2 steps are included in the shell script **x.sh**, which
automates it all.

When it's all built, it needs to be uploaded to github for display.

Now typically I enter these commands in by hand because I have them
memorizied, but the following lines here could be added to x.sh
in order to automatically upload to github.    (Pretty standard git
thing:  you have to commit locally before pushing to the server)

```
     git add .
     git commit -m "auto-commit from x.sh.  Best to put a real message in here"
     git push -u origin master
```

Then browse to: (might take 30 seconds for the changes to show up)

```
     ice-energy.github.io/sharedhugo
```

To allow for these server pages on GitHub, a particular setup
on the repository needs to be done.

```
     github.com/ice-energy
     You have to be logged in as ice-energy
     You have to be in the sharedhugo repository
     Click the Settings Tab up near the top
```

Scroll down a bit to **GitHub Pages**.

Change **Source** to:

```
     master branch /docs folder
```

Hit **Save**.


Good to Go!



JR





