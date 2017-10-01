# XXC &mdash; Externalizable XML Content

TODO

## Examples

### String externalization

#### ActionScript 3 part

```ecma script level 4
class ForestScene { /*...*/ 
    public function tripOnARoot():void {
        forestStory.display(context, "strings/trip");
        player.takeDamage(10);
        doNext(camp.returnToCampUseOneHour);
    }
    public function findTruffle():void {
        forestStory.display(context, "strings/truffle");
        inventory.takeItem(consumables.PIGTRUF, camp.returnToCampUseOneHour);
    }
}
```

#### XML part

```xml
<?xml version="1.0" encoding="utf-8"?>
<!--content/coc/desert.xml-->
<extend-story name="/" xmlns="xxc-story">
    <extend-zone name="forest">
        <lib name="strings">
            <text name="trip">
                You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.
            </text>
            <text name="truffle">
                You spot something unusual. Taking a closer look, it's definitely a truffle of some sort.
            </text>
        </lib>
    </extend-zone>
</extend-story>
```

#### Explanation

A _story_ is a named script that might contain other stories.

TODO

### String externalization &mdash; conditionals 

```ecma script level 4
public function forestWalkFn():void {
    forestStory.display(context, "strings/walk");
    doNext(camp.returnToCampUseOneHour);
}
```
```xml
<text name="walk">
    <if test="player.cor lt 80">
        You enjoy a peaceful walk in the woods, it gives you time to think.
        <dynStats tou="0.5" int="1"/>
        <else>
            As you wander in the forest, you keep
            <switch value="player.gender">
                <case value="0">daydreaming about sex-demons with huge sexual attributes, and how you could please them.</case>
                <case value="1">stroking your half-erect [cocks] as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes.</case>
                <case value="2">idly toying with your [vagina] as you daydream about getting fucked by all kinds of monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.</case>
                <case value="3">stroking alternatively your [cocks] and your [vagina] as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes, before, or while, getting fucked by various monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.</case>
            </switch>
            <dynStats tou="0.5" lib="0.25" lus="player.lib/5"/>
        </else>
    </if>
</text>
```

TODO

### Creating new encounters

```xml
<?xml version="1.0" encoding="utf-8"?>
<!--content/coc/desert.xml-->
<extend-zone name="desert" xmlns="xxc-story">
    <encounter name="walk" chance="50" when="model.time.hours eq 23">
        <lib name="ss">
            <string name="intro">You walk through the shifting sands for an hour, finding nothing. </string>
            <string name="str">The effort of struggling with the uncertain footing has made you STRONGEST.</string>
            <string name="tou">The effort of struggling with the uncertain footing has made you TOUGHEST.</string>
        </lib>
        <!-- logic -->
        <display ref="ss/intro"/>
        <if test="rand(2) eq 0">
            <if test="rand(2)==0 and player.str lt 500">
                <display ref="ss/str"/>
                <dynStats str="50"/>
                <elseif test="player.tou lt 500">
                    <display ref="ss/tou"/>
                    <dynStats tou="50"/>
                </elseif>
            </if>
        </if>
    </encounter>
</extend-zone>
```

TODO

## Reference

### Display elements

#### text, string, story, lib, macro

```relax-ng
Text = element text { 
    attribute name { text }?, 
    content*
}
```
Outputs its content, processing whitespace __in XML text during compilation__ (i.e. generated text is not processed):
* All whitespace after opening tag is removed
* Spaces and tabs after line break are removed (considered indents) 
* Single line-breaks are replaced by spaces (double and multiple are preserved).

This _story_ is saved in the outer text block as `name`.

##### <string>

As `<text>` but no whitespace processing is done.

##### <lib>

Used for grouping. Can only contain named display elements 

##### <macro>

Skipped when iterated from outer element, but can be displayed by name

##### <story>

Same as `<text>`  

#### display

```relax-ng
display = element display {
    attribute ref { text }
}
```
Locates 

#### output

TODO

#### zone, encounter

TODO

### Action elements

#### set

TODO

#### dynStats

TODO

### Structure elements

#### story

TODO

#### include

TODO

#### extend-story

TODO

#### extend-zone

TODO

### Logic elements

#### if-elseif-else

```xml
<if test="condition" then="thenString" else="elseString">
    thenContent
    <elseif>...</elseif>
    <else>
    elseContent
    </else>
</if>
```

* `condition` (expression) is required;
* `thenString` is a raw string, not an expression;
* `else="""`, `<elseif>`, and `<else>` are optional and only one of them should be present;
* `<elseif>` has same structure as `<if>`.

#### switch-case-default

##### Valueless:
```relax-ng
witch = element switch {
    case*,
    Default?
}
case = element case {
    attribute test { expression }?,
    content*
}
Default = element default {
    content*
}
```
Equivalent to a `if-elseif*-else?` chain

##### With value

Attribute `value` is calculated once and used in checks
```relax-ng
switch = element switch {
    attribute value { expression }?,
    case*,
    Default?
}
case = element case {
    attribute test { expression }?,
    attribute value { expression }?,
    attribute values { array-content-expression }?,
    attribute lt { expression }?,
    attribute gt { expression }?,
    attribute ne { expression }?,
    attribute lte { expression }?,
    attribute gte { expression }?,
    content*
}
Default = element default {
    content*
}
```

The following checks are performed (if present)
* `switch@value == case@value` 
* `[ case@values ]` contains `switch@value`
* `switch@value < case@lt` 
* `switch@value <= case@lte` 
* `switch@value > case@gt` 
* `switch@value >= case@gte` 
* `switch@value != case@value` 

If multiple value-checks are present, they are combined with AND (so `lt` and `gt` mean "between").
If the `test` attribute is present, it is combined with OR (if you need AND, move it to inner `<if>`)

### Expression syntax

Supported:
1. String, decimal and hex integer, floating-point literals.
1. Binary operators (listed in priority order; `()`-grouping is supported):
    *. `*`, `/`, `%`;
    *. `+`, `-`;
    *. `==` (aliased `eq` and `=`), `!=` (aliased `ne` and `neq`), `!==`, `===`, `<` (aliased `lt`), `<=` (aliased `lte` and `le`), `>` (aliased `gt`), `>=` (aliased `gte` and `gt`);
    *. `&&` (aliased `and`);
    *. `||` (aliased `or`).
2. Ternary operator `if_expr ? then_expr : else_expr`
2. Identifier lookup in the externally-provided scope. 
3. Predefined constants 
3. Dot operator `object_expr.key`
4. Array element access `array[index_expr]`
5. Array creation `[element_expr, element_expr, ..., element_expr]`
6. Function call `function_expr(arg_expr, arg_expr, ..., arg_expr)`

**NOT** supported:
1. (might be added) Object literals.
1. (some might be added) `is`, `instanceof`, `as`, `|`, `&`, `^`, unary `+` `-` `~`
1. L-values (and all asignment operators).
2. Control structures (basically everything that isn't a statement)
4. Accessing global variables, class names etc. 

Predefined identifiers: `Math` class, functions `int`, `uint`, `String`, `string` and `Number`, and constants `undefined`, `null`, `true`, `false`

TODO