# Parser Syntax

## Querying simple PC stat nouns
```relax-ng
[noun]
```
A list of available tags can be found in [ParserTags](ParserTags.as)

## Conditional Statements

### Simple if statement
```relax-ng
[if (condition) OUTPUT_IF_TRUE]
```

### If-Else statement
```relax-ng
[if (condition) OUTPUT_IF_TRUE | OUTPUT_IF_FALSE]
```
Note - Implicit else indicated by presence of the `|`

### Conditions
```
(arg1 [conditional] arg2)
```
`arg1` and `arg2` can be either numbers, or any of the strings in `conditionalOptions` in [ParserTags](ParserTags.as).
Numbers are converted to a Number typeprior to comparison.

|    |    |    |
|----|----|----|
|`=` | `==` | Both are Equals or equivalent-to operators|
|`<` | `<=` | Less than, and less than or equal         |
|`>` | `>=` | Greater than, and greater than or equal   |
|`!=`|     | Not equal                                 |

### Object aspect descriptions
```relax-ng
[object aspect]
```
gets the description of aspect `aspect` of object/NPC/PC `object`

## Gender Pronoun Weirdness
The parser uses Elverson/Spivak Pronouns specifically to allow characters to be written with non-specific genders.
http://en.wikipedia.org/wiki/Spivak_pronoun

Cheat table:

| Gender    | Subject    | Object       | Possessive Adjective | Possessive Pronoun  | Reflexive         | 
|-----------|------------|--------------|----------------------|---------------------|-------------------| 
| Agendered | ey laughs  | I hugged em  | eir heart warmed     | that is eirs        | ey loves emself   | 
| Masculine | he laughs  | I hugged him | his heart warmed     | that is his         | he loves himself  | 
| Feminine  | she laughs | I hugged her | her heart warmed     | that is hers        | she loves herself | 
