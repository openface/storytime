# Storytime

A text-based story-telling game.

Storytime is a simple choose-your-own-adventure game engine.  Using a simple
DSL-like interface for YAML files, stories are consumed and presented to the
player along with various options to let them navigate their way through
the story.


## Story YAML files

Stories follow the following rules:

- A story is a comprised of a set of YAML files contained in the stories/
  directory.

- A story must have a `story.yml` (story metadata), `start.yml` (the entrypoint
  into the story), and an `end.yml` (the final ending of the story).  All other
  YAML files are parts of the story.

- A story YAML file can contain these keys:
  - `content` The actual story part itself.
  - `choices` A set of options presented to the user.  Each option has a key
    that corresponds to a different story part by name.  If `choices` is not
    defined, it is considered a dead-end, and user is sent back one part.
