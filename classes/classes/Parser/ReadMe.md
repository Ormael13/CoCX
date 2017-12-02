#Parser Syntax

##Querying simple PC stat nouns
```relax-ng
[noun]
```

##Conditional Statements

###Simple if statement
```relax-ng
[if (condition) OUTPUT_IF_TRUE]
```

###If-Else statement
```relax-ng
[if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
```
Note - Implicit else indicated by presence of the `|`

###Object aspect descriptions
```relax-ng
[object aspect]
```
gets the description of aspect "aspect" of object/NPC/PC "object"
Eventually, I want this to be able to use introspection to access class attributes directly
Maybe even manipulate them, though I haven't thought that out much at the moment.

##Gender Pronoun Weirdness
The parser uses Elverson/Spivak Pronouns specifically to allow characters to be written with non-specific genders.
http://en.wikipedia.org/wiki/Spivak_pronoun

Cheat table:

| Gender    | Subject    | Object       | Possessive Adjective | Possessive Pronoun  | Reflexive         | 
|-----------|------------|--------------|----------------------|---------------------|-------------------| 
| Agendered | ey laughs  | I hugged em  | eir heart warmed     | that is eirs        | ey loves emself   | 
| Masculine | he laughs  | I hugged him | his heart warmed     | that is his         | he loves himself  | 
| Feminine  | she laughs | I hugged her | her heart warmed     | that is hers        | she loves herself | 
