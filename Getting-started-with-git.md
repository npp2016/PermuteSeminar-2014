Getting Started with git and GitHub
=====================================


The first time we use Git on a new machine,
we need to configure a few things (we'll insert blank lines
between groups of shell commands to make them easier to read):

~~~
$ git config --global user.name "Hermione Granger"

$ git config --global user.email "hgranger@hogwarts.edu"

$ git config --global color.ui "auto"

$ git config --global core.editor "nano"
~~~

Use your own name and email address instead of Hermione's,
and please make sure you choose an editor that's actually on your system
rather than `nano`. Configuring git properly makes sure that changes are attributable
to your account.

Git commands are written `git verb`,
where `verb` is what we actually want it to do.
In this case,
we're telling Git:

*   our name and email address,
*   to colorize output,
*   what our favorite text editor is, and
*   that we want to use these settings globally (i.e., for every project),

The four commands above only need to be run once:
Git will remember the settings until we change them.
Once Git is configured,
we can start using Git.

If you want to interact with git and GitHub through the command line, 
there are only a few key commands to learn. If you are on Mac or Linux, 
you would do this through the Terminal. If you you are on Windows, we recommend
downloading GitBash (http://git-scm.com/downloads).

There are many good resources for how to start using git, depending on the interface you prefer:
*For RStudio* - http://www.molecularecologist.com/2013/11/using-github-with-r-and-rstudio/
*For GitHub for Windows* - http://windows.github.com/
*For GitHub for Mac* - http://mac.github.com/
*For the command line* - http://www.git-tower.com/blog/git-cheat-sheet-detail/ and https://github.com/swcarpentry/bc/tree/master/git/novice

GitHub will allow everyone to work simultaneously on code related to the seminar,
and to share examples of different ways to arrive at an answer for a given
problem. Please remember to `push` and `pull` your changes often to avoid conflicts, and 
always use descriptive filenames so that we can keep things organized. For the purposes of 
the seminar, everyone will be added to the "Organization" PermuteSeminar, so we can use
a simple workflow, where everyone has ownership and administrative powers.
