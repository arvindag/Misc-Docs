#### 1 Tutorial
##### 1.3 
Printf has overadozen such conversions, which Go programmers cal l verb s. This table is far
from a complete specification but illustrates many of the features that are available:
```
%d decimal integer
%x, %o, %b integer in hexadecimal, octal, binary
%f, %g, %e floating-point number: 3.141593 3.141592653589793 3.141593e+00
%t boolean: true or false
%c rune (Unicode code point)
%s string
%q quoted string "abc" or rune 'c'
%v any value in a natural format
%T type of any value
%% literal percent sign (no operand)
%#v includes struct field names using Go syntax
%*s prints the string padded with variable number of spaces
```
A **map** is a reference to the data structure created by make. When a map is passed to a function,
the function receives a copy of the reference, so any changes the called function makes to
the underlying data structure will be visible through the caller’s map reference too. In our
example, the values inserted into the counts map by countLines are seen by main.
##### 1.6
A **goroutine** is a concurrent function execution. A **channel** is a communication mechanism
that allows one goroutine to pass values of a specified type to another goroutine. The function
main runs in a goroutine and the go statement creates additional goroutines.
##### 1.7 A web server
The server has two handlers, and the request URL determines which one is called: a request
for /count invokes counter and all others invoke handler. A handler pattern that ends with
a slash matches any URL that has the pattern as aprefix. Behind the scenes, the server runs
the handler for each incoming request in a separate goroutine so that it can serve multiple
requests simultaneously.
##### 1.8 Loose Ends
Cases do not fall through from one to thenext as in C-like languages (though there is a rarely 
used **fallthrough** statement that overrides this behavior).
A switch does not need an operand; it can just list the cases, each of which is a boolean
expression: This form is called a **tagless switch**; it’s equivalent to switch true.
#### 2 Program Structure
##### 2.2 Declerations
There are 4 major kinds of declarations: *var, const, type and func*.
##### 2.3 Variables
A *var* declaration creates a variable of a particular type, attached a name to it, and sets its
initial value. Each declaration has the general form *var name type = expression*.
###### 2.3.1 Short variable declaration
*name := expression*
Keep in mind that *:=* is a declaration and *=* is an assignment.
A short variable declaration does not necessarily *declare* all the variables on its left hand side. If some
of them were already declared in the same lexical block, then the short variable decleration acts like an
*assignment* to those variables. A short variable declaration must declare at least one new variable.
###### 2.3.2 Pointers
A variable is a piece of storage containing a value. A *pointer* is the address of a variable. Pointers
are comparable; two pointers are equal iff they point to the same variable or they are both nil. it is perfectly
safe for a function to return the address of a local variable.
```go
v := 1
p := &v
*p is same as v
```
Pointer aliasing is useful because it allows us to access a variable without using its name. Pointers are key
to  the *flag* package, which uses a program's command-line arguments to set the values of certain variables
distributed throught the program.
```go
var n = flag.Bool("n", false, "omit trailing newline")
var sep = flag.String("s", " ", "separator")
```
The variables *sep* and *n* are pointers to the flag variables, which must be accessed indirectly as *\*sep*
and *\*n*.

###### 2.3.3 The new Function
Another way to create a variable is to use the built-in function *new*. The expression **new(T)** creates an
*unnamed variable*  of type T, initializes it to zero values of T, and returns its address, which is a value
of type *\*T*. Each call to new returns a distinct variable with a unique address.
Since *new* is a predeclared function, and **not a keyword**, it is possible to **redefine** the name for
something else within a function.

###### 2.3.4 Lifetime of a variable
The variable lives on until it becomes **unreachable**, at which point its storage might be recycled.
```go
var global *int
func f() {
  var x int
  x = 1
  global = &x
 }

func g() {
  y := new(int)
  *y = 1
}
```
Here, **x** must be **heap-allocated** because it is still reachable from the variable *global* after
**f** has returned, despite being declared as a local variable; we say **x** *escapes* from **f**.
Conversely, when **g** returns, the variable **\*y** becomes unreachable and can be recycled.

##### 2.5 Type Declarations
A **type** declaration defines a new *named type* that has the same *underlying type* as an existing type.
The named type provides a way to separate different and perhaps incompatible uses of the underlying type 
so that they cannot be mixed unintentionally.
```go
type name underlying-type
```
```
type Celsius float64
type Fahrenheit float64
```
The above example defines two types, **Celsius** and **Fahrenheit**, for the two temperature. Even though both have the same
underlying types, *float64*, they are not the same type, so they **cannot be compared or combined** in arithmetic expressions. This 
stops inadvertent errors. An explicit type *conversion* like **Celsius(t)** or **Fahrenheit(t)** is required to convert from
a float64. **Celsius(t)** and **Fahrenheit(t)** are conversions, not function calls.
A conversion from one type to another is allowed if both have the same underlying type, or if both are unnamed pointer types
that point to variables of the same underlying type. These conversions change the type but not the representation of the value.
In any case, a type conversions never fails at run time. Some special conversions might changed the representation of of the value like float64 to int conversion or string to []byte slice conversions.
Named types also make it possible to define new behaviors for the values of the type. These behaviors are expressed as a set
of functions associated with the type, called the type's *methods*.

###### 2.6.2 Package Initialization
If the package has multiple .go files, they are initialized in the order in which the files are given to the compiler.
The go tool sorts the .go files by name before invoking the compiler.
```go
func init() { /* ... */ }
```
Such **init()** functions can't be called or referenced, but otherwise they are normal functions. Within each file,
**init** functions are automatically executed when the program starts, in the order in which they are declared.

##### 2.7 Scope
Don't confuse scope with lifetime. The scope of the declaration is a region of the program text; it is a compile time
property. The lifetime of a variable is the range of time during execution when the variable can be referred to by other
parts of the program. It is a run time property.

#### 3 Basic Data Types
Go types fall into **4 categories**: *basic types, aggregate types, reference types and interface types*.
**Basic** types like numbers, strings, booleans
**Aggregate** types like arrays and structs
**Reference** types includes pointers, slices, maps, functions, channels
**Interface** types which are abstract types. The above 3 are concrete types.
##### 3.1 Integers
* *int* is by far the most used integer type which is signed integer.
* *rune* is a synonym for **int32** and indicates a value is a Unicode code point.
* Similarly *byte* is a synonym for uint8
* *uintptr* is sufficient to hold all bits of a pointer value used only for low level programming.
Built-in **len** function returns a signed int so that it can be used in the loops.
Octal numbers seem to be used for exactly one purpose - file permissions on the POSIX systems.

###### 3.5.3 UTF-8
* `0xxxxxxx                             runes 0-127    (ASCII)`
* `110xxxxx 10xxxxxx                    128-2047`
* `1110xxxx 10xxxxxx 10xxxxxx           2048-65535`
* `11110xxx 10xxxxxx 10xxxxxx 10xxxxxx  65536 - 0x10ffff`

If there are unicode string, then do not use the `len` of the string, but `utf8.RUneCountInString()`
UTF-8 is exceptionally convinient as an interchange format, but within a program runes may be more convinient 
because they are of uniform size and this easily indexes in arrays and slices.
#### 4 Composite Types
##### 4.1 Arrays
An **array** is a *fixed length* sequence of zero or more elements of a particular type. **Slices**, which can grow and 
shrink, are much more versatile. In an array literal, if an ellipsis "..." appears in place of the length, the array
length is determined by the number of initializers. ```q := [...]int{1, 2, 3}``` has 3 integers. The size of an array
is part of its type, so ```[3]int``` and ```[4]int``` are different types. In this form, indices can appear in any order
and some may be omitted and unspecified values take on the zero value for the element type. For instance, 
```r := [...]int{99: 01}``` defines an array of 100 elements, all zero except for the last, which has the value -1.

When a function is called, a copy of each argument value is assigned to the corresponding parameter variable, so
the *function receives a copy, not the original*. Go treats arrays like any other type, but this behavior is
*different* from other languages that implicitly pass *arrays by reference*.

##### 4.2 Slices
A slice is a lightweigth data structure that gives access to a subsequence (or perhaps all) of the elements of an
array, which is known as the slice's underlying array. A slice has 3 components: a pointer, a length and a capacity.
An array of the string for months of the year is ```months := [...]string{1: "January", /* ... */, 12: "December"}```

Since a slice contains a pointer to an element of an array, passing a slice to a function permits
the function to modify the underlying array elements.
A slice literal looks like an array literal: a sequence of values separated by commas and surrounded
by braces, but the size is not given.
``` a := [...]int{0, 1, 2, 3}``` is an array.
``` s := []int{1, 2, 3}``` is a slice.
If you need to test whether a slice is empty, use *len(s) == 0* not *s == nil*.

###### 4.2.1 The Append function
Usually we do not know whether a given call to built-in *append* will cause the reallocation, so we
 can't assume that the original slice refers to the resulting slice. Hence
 ``` runes = append(runes, r)```
 The ellipsis "..." in the declaration of the *appendInt* makes the function *variadic*. It accepts any number of 
 final arguments. ```func appendInt(x []int, y ...int) []int```
 
##### 4.3 Maps
It is an unordered collection of key/value pairs in which all the keys are distinct, and the value
associated with a given key can be retreivedm updatedm or removed using a constant number of key
comparisons on the average, no matter how large the hash table.
In Go, a *map* is a reference to a hash table, and a map can type is written map[K]V, where *K* and *V*
are the types of its keys and values. The key type K must be comparable using ==, so that the map can
test whether a given key is equal to one already within it.
```ages := make(map[string]int)``` mapping from string to ints. Also
```go
ages := map[string]int{
  "alice": 33,
  "charlie": 34
  }
 ```
The order of map iteration is unspecified, and lead to different ordering. Also the map element is not a 
variable, and we cannot take its address.

We mist allocate the map before we can store into it using *make*. Most of the map operations, including
lookup, *delete*, *len*, and *range* loops, are safe to perform on a nil map reference, since they 
behave like an empty map.

Sometimes we need a map or a set whose keys are slices, but because a map's keys mist be comparable, this 
cannot be expressed directly. However, it can be done in two steps. First we define a helper function *k*,
that maps each key to a string, with the property that *k(x) == k(y)* iff we consider x and y are equivalent.
Then we create a map whose keys are strings, applying the helper function to each slice key before we access
the map. The example below used *fmt.Sprintf* to convert a slice of strings into a single string that is 
a suitable map key.
```go
var m = make(map[string]int)
func k(list []string] string { return fmt.Sprintf("%q", list) }
func Add(list []string) { m[k(list)]++ }
func Count(list []string) int { return m[k(list)] } 
```

The same approach can be used for any non-comparable key type, not just slices.

In the following code, the key type of *graph* is a *string* and the value type is *map[string]bool*, 
representing a set of strings. Conceptually, *graph* maps a string to a set of related strings, its successors
in a directed graph.

``` var graph = make(map[string]map[string]bool)``` which is equal to

``` var graph = male(map[from]map[to]bool)```

##### 4.4 Structs
A *struct* is an aggregate data type that groups together zero or more named values of arbitrary types as
a single entity. Each value is called a *field*. Field order is *significant* to the struct type identity.
If the field order is changed, it is a new struct. A zero value for a struct is composed of the zero values
of each of its fields.

Struct values can be passed as arguments to functions and returned from them. For efficiency, larger struct
types are usually passed to or returned from functions indirectly using a pointer.
```go
func Bonus(e *Employee, percent int) int {
   return e.Salary * percent / 100
} 
 ```
and this is required if the function must modify its argument, since in a call-by-value language like
Go, the called function receives only a copy of an argument, not a reference to the original argument.

###### 4.4.3 Struct Embedding and Anonymous Fields
Go lets us declare a field with a type but ni name; such fields are called *anonymous fields*. The type
of the field must be a named type or a pointer to a named type. Below, Circle and Wheel have one
anonymous field each with Wheel.
```go
type Point struct {
    X, Y int
}
type Circle sturct {
    Point
    Radius int
    }
type Wheel struct {
    Circle 
    Spokes int
}
```
Thanks to this emn=bedding, we can refer to the names of the leaves of the implicit tree without
giving the intervening names:
```go
var w Wheel
w.X = 8         // equivalent to w.Circle.Point.X = 8
w.Y = 9         // equivalent to w.Circle.Point.Y = 9
w.Radius = 5    // equivalnet to w.Circle.Radius = 5
w.Spokes = 20
```
Because "anonymous" fields do have implicit names, you can't have two anonymous fields of the same
type since their names would conflict.

**Why would tou want to embed a type that has not fields?**
The answer has to do with methods. The shorthand notation used for selecting the fields of an embedded
type works for selecting its methods as well. In effect, the outer struct type gains not just the 
fields of the embedded type but its methods also. This mechanism is the main way that complex object
behaviors are composed from simpler ones. *Composition* is central to object-oriented programming in Go.


##### 4.5 JSON
The basic JSON types are numbers (in decimal or scientific notation), booleans (true or false), and
strings, which are sequences of Unicode code points enclosed in double quotes, with backslash escapes
using a similar notation to Go, though JSON's *\Uhhhh* numeric escapes denote UTF-16 codes, *not runes*.

A JSON array is an ordered sequence of values, written as a comma-separated list enclosed in square
brackets. A JSON object is a mapping from *string* to *values*, written as a sequence of *name:value*
pairs separated by commas and surrounded by braces.
The string literals after the *Year* and *Color* field declarations are *field tags*.
```go
type Movie struct {
    Title string
    Year int   `json:"released"`
    Color bool `json:"color, omitempty"`
    Actors []string
}
var movies = []Movie{
    {Title:"Casablanca", Year: 1942, Color: false, Actors: []string{"Humphrey Bogart", "Ingrid Bergman"}}
    // ...
}
```
Converting a Go data structure like movies to JSON is called *marshaling*.
```go
data, err := json.Marshal(movies)
if err != nil {
}
```
*Marshal* produces a byte slice containing a very long string with no extraneous white spaces. *MarshalIdent*
produces neatly indented output.

Only exported fields are marshaled, which is why we chose capitalized names for all the Go field names.
*omitempty* field tag indicates that no JSON output should be produced if the field has the zero value for 
its type.

The inverse of *marshaling*, decoding JSON and populating a Go data structure is called *unmarshaling*, and
is done by *json.unmarshal*. If the Go data structure only has some of the fields from the marshalled version,
then the other fields from the JSON are ignored.

##### 4.6 Text and HTML Templates
a *template* is a string or file containing one or more of portions enclosed in double braces,
{{...}}, called *actions*. Within an action, the **|** notation makes the result of one operation the
argument of another, analogous to a Unix shell pipeline.

```go
const templ = `{{.TotalCount}} issues:
{{range .Items}}------------------------
Number: {{.Number}}
User:   {{.User.login}}
Title:  {{.Title | printf "%.64s"}}
Age:    {{.CreatedAt | daysAgo}} days
{{end}}`
```

#### 5 Functions
##### 5.1 Function Declarations
```go
func name(paramater-list) (result-list) {
  body
```
The type of a function is sometimes called its *signature*. Two functions have the same type
or signature if they have the same sequence of parameter types and the same sequence of 
result types.
Arguments are passed by *value*, so the function receives a copy of each argument and 
modifications to the copy do not affect the caller. However, if the argument contains
some kind of reference, like a pointer, slice, map, function, or channel, then the caller
may be affected by the modifications the function makes to the variables *indirectly*
referred to by the argument.

You may occasionally encounter a function declaration without a body, indicating that the
function is implemented in a language other than Go. Such declaration defines the function
signature.
```go
package math
func Sin(x float64) float64 // implemented in assembly language
```

##### 5.2 Recursion
```go
package html

// A NodeType is the type of a Node.
type NodeType uint32

const (
	ErrorNode NodeType = iota
	TextNode
	DocumentNode
	ElementNode
	CommentNode
	DoctypeNode
	scopeMarkerNode
)

type Node struct {
	Parent, FirstChild, LastChild, PrevSibling, NextSibling *Node
	Type      NodeType
	Data      string
	Attr      []Attribute
}

```

##### 5.3 Multiple Return Values
In a function with named results, the operands of a return statement may be omitted. This is
called a *bare return*. In functions like this one, with many return statements and several
results, bare returns can reduce code duplication, but rarely make the code easier to
understand.
##### 5.4 Errors
Go’s approach sets it apart from many other languages in which failures are reported using 
*exceptions*, not ordinary values. Although Go does have an exception mechanism of sorts, 
as we will see in Section 5.9, it is used only for reporting truly unexpected errors that 
indicate a bug, not the routine errors that a robust program should be built to expect.

Go programs use ordinary control-flow mechanisms like if and return to respond to errors.
This style undeniably demands that more attention be paid to error-han- dling logic, but 
that is precisely the point.
###### 5.4.1 Error-Handling Strategies
There are 5 different ways to handle errors.

**First**
First, and most common, is to propagate the error, so that a failure in a subroutine 
becomes a failure of the calling routine.
```go
resp, err := http.Get(url)
     if err != nil {
         return nil, err
}
```

```go
     doc, err := html.Parse(resp.Body)
     resp.Body.Close()
     if err != nil {
         return nil, fmt.Errorf("parsing %s as HTML: %v", url, err)
}
```
The **fmt.Errorf** function formats an error message using *fmt.Sprintf* and returns a new *error*
value. Because error messages and frequently chained together, message strings should not be
capitalized and newlines should be avoided. The resulting errors may be long, but they will be
self-contained when found by tools like *grep*.

**Second**
It may make sense to *retry* the failed operation, possibly with a delay between tries, and perhaps
with a limit to number of attempts before giving up entirely.

**Third** 
If progress is impossible, the caller can print the error and stop the program gracefully,
but this course of action should generally be reserved for the main package of a program.
Library functions should usually propagate errors to the caller.

**Fourth**
In some cases, it’s sufficient just to log the error and then continue, perhaps with 
*reduced* functionality.

**Fifth**
Finally, in rare cases we can safely ignore an error entirely like cleaning the tmp area.

##### 5.5 Function Values
Functions are *first-class values* in Go: like other values, function values have types,
and they may be assigned to variables or passed to or returned from functions. A function
value may be called like any other function. For example:
```go
     func square(n int) int     { return n * n }
     func negative(n int) int   { return -n }
     func product(m, n int) int { return m * n }
     f := square
     fmt.Println(f(3)) // "9"
     f = negative
     fmt.Println(f(3))     // "-3"
     fmt.Printf("%T\n", f) // "func(int) int"
     f = product // compile error: can't assign f(int, int) int to f(int) int
```
When the function variable gets different function values, they need to have the same
signature, else they will cause errors.
The zero value of a function type is *nil*. Calling a nil function value causes a panic:
The Function values may be compared with *nil*, but they are not comparable, so they may
not be compared against each other or used as keys in a map.

##### 5.6 Anonymous Functions
Named functions can be declared only at the package level, but we can use a *function literal*
to denote a function value within any expression. A function literal is written like a 
function declaration, but without a name following the func keyword. It is an expression, 
its value is called an *anonymous function*.

Function literals let us define a function at its point of use. As an example, the earlier
call to strings.Map can be rewritten as
```go
     strings.Map(func(r rune) rune { return r + 1 }, "HAL-9000")
```

More importantly, functions defined in this way have *access to the entire lexical environment*,
so the inner function can refer to variables from the enclosing function, as this example shows:
```go
   gopl.io/ch5/squares
     // squares returns a function that returns
     // the next square number each time it is called.
     func squares() func() int {
         var x int
         return func() int {
             x++
             return x * x
} }
     func main() {
         f := squares()
         fmt.Println(f()) // "1"
         fmt.Println(f()) // "4"
         fmt.Println(f()) // "9"
         fmt.Println(f()) // "16"
}
```
The squares example demonstrates that function values are not just code but can have state.
The anonymous inner function can access and update the local variables of the enclosing
function *squares*. These hidden variable references are why we classify functions as reference
types and why function values are not comparable. Function values like these are implemented 
using a technique called *closures*, and Go programmers often use this term for function values.

###### 5.6.1 Caveat: Capturing Iteration Variables
Consider a program that must create a set of directories and later remove them. We can use a 
slice of function values to hold the clean-up operations. (For brevity, we have omitted all 
error handling in this example.)
```go
     var rmdirs []func()
     for _, d := range tempDirs() {
         dir := d               // NOTE: necessary!
         os.MkdirAll(dir, 0755) // creates parent directories too
         rmdirs = append(rmdirs, func() {
             os.RemoveAll(dir)
}) }
     // ...do some work...
     for _, rmdir := range rmdirs {
         rmdir() // clean up
}
```
You may be wondering why we assigned the loop variable d to a new local variable dir within the loop
body, instead of just naming the loop variable dir as in this subtly incorrect variant:
```go
     var rmdirs []func()
     for _, dir := range tempDirs() {
         os.MkdirAll(dir, 0755)
         rmdirs = append(rmdirs, func() {
             os.RemoveAll(dir) // NOTE: incorrect!
}) }
```
The reason is a consequence of the scope rules for loop variables. In the program immediately above,
the for loop introduces a new lexical block in which the variable dir is declared. All function 
values created by this loop ‘‘capture’’ and share the same variable—an addressable storage 
location, not its value at that particular moment. The value of dir is updated in successive
iterations, so by the time the cleanup functions are called, the dir variable has been updated
several times by the now-completed for loop. Thus dir holds the value from the final iteration,
and consequently all calls to os.RemoveAll will attempt to remove the same directory.

The risk is not unique to range-based **for** loop.

##### 5.7 Variadic Functions
A *variadic function* is one that can be called with varying numbers of arguments. The most 
familiar examples are fmt.Printf and its variants. 

To declare a variadic function, the type of the final parameter is preceded by an 
ellipsis, ‘‘...’’, which indicates that the function may be called with any number of arguments
 of this type.
```go
func sum(vals ...int) int {
    total := 0
    for _, val := range vals {
    total += val
    }
    return total
}
values := []int{1, 2, 3, 4}
     fmt.Println(sum(values...)) // "10"
```

Although the *...int* parameter behaves like a slice within the function body, the type of a 
variadic function is distinct from the type of a function with an ordinary slice parameter.
```go
     func f(...int) {}
     func g([]int)  {}
     fmt.Printf("%T\n", f) // "func(...int)"
     fmt.Printf("%T\n", g) // "func([]int)"
```

The *interface{}* type means that this function can accept any values at all for its final arguments.

##### 5.8 Deferred Function Calls
a *defer* statement is an ordinary function or method call prefixed by the keyword defer. The 
function and argument expressions are evaluated when the statement is executed, but the *actual 
call is deferred* until the function that contains the defer statement has finished, whether 
normally, by executing a return statement or falling off the end, or abnormally, by panicking.
Any number of calls may be deferred; they are *executed in the reverse of the order* in which they
were deferred.

Deferred functions run after return statements have updated the function’s result variables.
Because an anonymous function can access its enclosing function’s variables, including named
results, a deferred anonymous function can observe the function’s results.

Consider the function double: 
```go
func double(x int) int {
    return x + x
}
```
By naming its result variable and adding a defer statement, we can make the function print 
its arguments and results each time it is called.
```go
   func double(x int) (result int) {
         defer func() { fmt.Printf("double(%d) = %d\n", x, result) }()
         return x + x
}
     _ = double(4)
     // Output:
     // "double(4) = 8"
```
This trick is overkill for a function as simple as double but may be useful in functions with
many return statements.

A deferred anonymous function can even change the values that the enclosing function returns to 
its caller:
```go
     func triple(x int) (result int) {
         defer func() { result += x }()
         return double(x)
}
     fmt.Println(triple(4)) // "12"
```
Because deferred functions aren’t executed until the very end of a function’s execution, a 
defer statement in a loop deserves extra scrutiny. The code below could run out of file descriptors
since no file will be closed until all files have been processed:
```go
     for _, filename := range filenames {
         f, err := os.Open(filename)
         if err != nil {
}
return err
}
defer f.Close() // NOTE: risky; could run out of file descriptors
// ...process f...
```

One solution is to move the loop body, including the defer statement, into another function 
that is called on each iteration.
```go
     for _, filename := range filenames {
         if err := doFile(filename); err != nil {
             return err
         }
     }
     func doFile(filename string) error {
         f, err := os.Open(filename)
         if err != nil {
              return err
         }
         defer f.Close()
         // ...process f...
     }
```

##### 5.9 Panic
Go’s type system catches many mistakes at compile time, but others, like an out-of-bounds array
access or nil pointer dereference, require checks at run time. When the Go runtime detects these
mistakes, it *panics*.

Although Go’s panic mechanism resembles exceptions in other languages, the situations in which 
*panic* is used are quite different. Since a panic causes the program to crash, it is generally
used for grave errors, such as a logical inconsistency in the program; diligent programmers 
consider any crash to be proof of a bug in their code. In a robust program, "expected" errors,
the kind that arise from incorrect input, misconfiguration, or failing I/O, should be handled
gracefully; they are best dealt with using *error* values.

Readers familiar with exceptions in other languages may be surprised that **runtime.Stack** can 
print information about functions that seem to have already been ‘‘unwound.’’ Go’s panic 
mechanism runs the deferred functions *before* it unwinds the stack.

##### 5.10 Recover
If the built-in *recover* function is called *within a deferred function* and the function
containing the defer statement is panicking, recover ends the current state of panic and
returns the panic value. The function that was panicking does not continue where it left 
off but returns normally. If recover is called at any other time, it has no effect and
returns nil.

To illustrate, consider the development of a parser for a language. Even when it appears 
to be working well, given the complexity of its job, bugs may still lurk in obscure corner
cases. We might prefer that, instead of crashing, the parser turns these panics into ordinary
parse errors, perhaps with an extra message exhorting the user to file a bug report.
```go
     func Parse(input string) (s *Syntax, err error) {
         defer func() {
}
    if p := recover(); p != nil {
        err = fmt.Errorf("internal error: %v", p)
} }()
// ...parser...
```
The deferred function in Parse recovers from a panic, using the panic value to construct an
error message; a fancier version might include the entire call stack using runtime.Stack.
The deferred function then assigns to the err result, which is returned to the caller.

#### 6 Methods
Although there is no universally accepted definition of object-oriented programming, for our
purposes, an *object* is simply a value or variable that has methods, and a *method* is a function
associated with a particular type. An object-oriented program is one that uses methods to
express the properties and operations of each data structure so that clients need not access
the object’s representation directly.

##### 6.1 Method Declarations
A method is declared with a variant of the ordinary function declaration in which an extra
parameter appears before the function name.
```go
package geometry
     import "math"
     type Point struct{ X, Y float64 }
     // traditional function
     func Distance(p, q Point) float64 {
         return math.Hypot(q.X-p.X, q.Y-p.Y)
}
     // same thing, but as a method of the Point type
     func (p Point) Distance(q Point) float64 {
         return math.Hypot(q.X-p.X, q.Y-p.Y)
}
```
The extra parameter p is called the method’s **receiver**, a legacy from early object-oriented
languages that described calling a method as ‘‘sending a message to an object.’’
In Go, we don’t use a special name like this or self for the receiver; we choose receiver names
just as we would for any other parameter. Since the receiver name will be frequently used,
it’s a good idea to choose something short and to be consistent across methods. A common 
choice is the first letter of the type name, like p for Point.

```go
fmt.Println(p.Distance(q))  // "5", method call
```
The expression p.Distance is called a *selector*, because it selects the appropriate Distance
method for the receiver p of type Point. Selectors are also used to select fields of struct
types, as in p.X. 

In allowing methods to be associated with any type, Go is unlike many other object-oriented
languages. It is often convenient to define additional behaviors for simple types such 
as numbers, strings, slices, maps, and sometimes even functions. *Methods* may be declared
on any named type defined in the same package, so long as its underlying type is neither
a pointer nor an interface.

All methods of a given type must have unique names, but different types can use the same
name for a method, like the Distance methods for Point and Path; there’s no need to qualify
function names (for example, PathDistance) to disambiguate. Here we see the first benefit to
using methods over ordinary functions: method names can be shorter. The benefit is magnified
for calls originating outside the package, since they can use the shorter name and omit the
package name.

##### 6.2 Methods with a Pointer Receiver
Because calling a function makes a copy of each argument value, if a function needs to update
a variable, or if an argument is so large that we wish to avoid copying it, we must pass the
address of the variable using a pointer. The same goes for methods that need to update the
receiver variable: we attach them to the pointer type, such as *Point.
```go
func (p *Point) ScaleBy(factor float64) {
    p.X *= factor
    p.Y *= factor
}
```

Named types (Point) and pointers to them (*Point) are the only types that may appear in a
receiver declaration. Furthermore, to avoid ambiguities, method declarations are not permitted
on named types that are themselves pointer types.

If all the methods of a named type T have a receiver type of T itself (not *T), it is safe
to copy instances of that type; calling any of its methods necessarily makes a copy. For example,
time.Duration values are liberally copied, including as arguments to functions. But if any method
has a pointer receiver, you should avoid copying instances of T because doing so may violate
internal invariants. For example, copying an instance of bytes.Buffer would cause the original
and the copy to alias (§2.3.2) the same underlying array of bytes. Subsequent method calls would
have unpredictable effects.

In some cases, *nil* is allowed to be a valid Receiver Value.

##### 6.3 Composing Types by Struct Embedding
Consider the type ColoredPoint: gopl.io/ch6/coloredpoint
```go
     import "image/color"
     type Point struct{ X, Y float64 }
     type ColoredPoint struct {
         Point
         Color color.RGBA
}
```
We could have defined *ColoredPoint* as a struct of three fields, but instead we embedded a *Point* to 
provide the X and Y fields. As we saw in Section 4.4.3, embedding lets us take a syntactic shortcut to
defining a *ColoredPoint* that contains all the fields of Point, plus some more.
```go
     red := color.RGBA{255, 0, 0, 255}
     blue := color.RGBA{0, 0, 255, 255}
     var p = ColoredPoint{Point{1, 1}, red}
     var q = ColoredPoint{Point{5, 4}, blue}
     fmt.Println(p.Distance(q.Point)) // "5"
     p.ScaleBy(2)
     q.ScaleBy(2)
     fmt.Println(p.Distance(q.Point)) // "10"
```
The methods and variables of Point have been *promoted* to ColoredPoint. In this way, embedding allows
complex types with many methods to be built up by the *composition* of several fields, each
providing a few methods.

If you prefer to think in terms of implementation, the embedded field instructs the compiler to
generate additional wrapper methods that delegate to the declared methods.
The type of an anonymous field may be a pointer to a named type, in which case fields and methods are
promoted indirectly from the pointed-to object. A struct type may have more than one anonymous field.

A struct type may have more than one anonymous field. Had we declared **ColoredPoint** as
```go
     type ColoredPoint struct {
         Point
}
```
then a value of this type would have all the methods of Point, all the methods of RGBA, and any
additional methods declared on **ColoredPoint** directly. When the compiler resolves a selector such
as p.ScaleBy to a method, it first looks for a *directly declared method named ScaleBy*, then for
*methods promoted once* from ColoredPoint’s embedded fields, then for *methods promoted twice* from
embedded fields within Point and RGBA, and so on. The compiler reports an *error if the selector
was ambiguous* because two methods were promoted from the same rank.

The version below is functionally equivalent but groups together the two related variables in a
single package-level variable, cache:

```go
     var cache = struct {
         sync.Mutex
         mapping map[string]string
     }{
         mapping: make(map[string]string),
     }
     func Lookup(key string) string {
         cache.Lock()
         v := cache.mapping[key]
         cache.Unlock()
         return v
     }
```
##### 6.4 Method Values and Expressions
The selector *p.Distance* yields a *method value*, a function that binds a method (Point.Distance) to
a specific receiver value p. This function can then be invoked without a receiver value; it needs only
the non-receiver arguments.
```go
p := Point{1, 2}
q := Point{4, 6}
distanceFromP := p.Distance         // method value
fmt.Println(distanceFromP(q))       // "5"
var origin Point                    // {0, 0}
fmt.Println(distanceFromP(origin))  // "2.23606797749979", sqrt(5)

scaleP := p.ScaleBy // method value
scaleP(2)           // p becomes (2, 4)
scaleP(3)           //      then (6, 12)
scaleP(10)          //      then (60, 120)
```
Related to the method value is the *method expression*.
```go
     p := Point{1, 2}
     q := Point{4, 6}
     distance := Point.Distance   // method expression
     fmt.Println(distance(p, q))  // "5"
     fmt.Printf("%T\n", distance) // "func(Point, Point) float64"
```

##### 6.5 Example: Bit Vector Type
Sets in Go are usually implemented as a *map[T]bool*, where T is the element type. A set represented
by a map is very flexible but, for certain problems, a specialized representation may outperform it.
For example, in domains such as dataflow analysis where set elements are small non-negative integers,
sets have many elements, and set operations like union and intersection are common, a *bit vector* is ideal.

##### 6.6 Encapsulation
A variable or method of an object is said to be encapsulated if it is inaccessible to clients of
the object. Encapsulation, sometimes called *information hiding*, is a key aspect of object-oriented
programming.

Go has only one mechanism to control the visibility of names: capitalized identifiers are exported
from the package in which they are defined, and uncapitalized names are not. The same mechanism
that limits access to members of a package also limits access to the fields of a struct or the
methods of a type. As a consequence, to encapsulate an object, we must make it a struct.

**Encapsulation provides three benefits.**

*First*, because clients cannot directly modify the object’s variables, one need inspect fewer
statements to understand the possible values of those variables.

*Second*, hiding implementation details prevents clients from depending on things that might
change, which gives the designer greater freedom to evolve the implementation without breaking
API compatibility. As an example, consider the bytes.Buffer type. It is frequently used to
accumulate very short strings, so it is a profitable optimization to reserve a little extra
space in the object to avoid memory allocation in this common case. 

The *third* benefit of encapsulation, and in many cases the most important, is that it prevents
clients from setting an object’s variables arbitrarily.

#### 7 Interfaces
Many object-oriented languages have some notion of interfaces, but what makes Go’s interfaces
so distinctive is that they are *satisfied implicitly*.
##### 7.1 Interfaces as Contracts
An interface as an *abstract type*. When you have a value of an interface type, you know nothing
about what it is; you know only what it can do, or more precisely, what behaviors are provided by
its methods.

This freedom to substitute one type for another that satisfies the same interface is called
*substitutability*, and is a hallmark of object-oriented programming.

Declaring a String method makes a type satisfy one of the most widely used interfaces of all,
**fmt.Stringer**:
```go
package fmt
     // The String method is used to print values passed
     // as an operand to any format that accepts a string
     // or to an unformatted printer such as Print.
     type Stringer interface {
         String() string
}
```
##### 7.2 Interface Types
An interface type specifies a set of methods that a concrete type must possess to be considered
an instance of that interface.

```go
package io
     type Reader interface {
         Read(p []byte) (n int, err error)
}
     type Closer interface {
         Close() error
}
     type ReadWriter interface {
         Reader
         Writer
}
     type ReadWriteCloser interface {
         Reader
         Writer
         Closer
}
```

The syntax used above, which resembles struct embedding, lets us name another interface as a
shorthand for writing out all of its methods. This is called *embedding an interface*. The order
in which the methods appear is imma- terial. All that matters is the set of methods.

##### 7.3 Interface Satisfaction
A type *satisfies* an interface if it possesses all the methods the interface requires.
For example, an \*os.Filesatisfiesio.Reader, Writer, Closer, and ReadWriter*. A \*bytes.Buffer 
satisfies Reader, Writer, and ReadWriter, but does not satisfy Closer because it does not have
a Close method. As a shorthand, Go programmers often say that a concrete type ‘‘is a’’ particular
interface type, meaning that it satisfies the interface. For example, a \*bytes.Buffer is an 
io.Writer; an \*os.File is an io.ReadWriter.

The assignability rule (§2.4.2) for interfaces is very simple: an expression may be assigned to an
interface only if its type satisfies the interface.

Like an envelope that wraps and conceals the letter it holds, an interface wraps and conceals the
concrete type and value that it holds. Only the methods revealed by the interface type may be called,
even if the concrete type has others.

An interface with more methods, such as io.ReadWriter, tells us more about the values it contains,
and places greater demands on the types that implement it, than does an interface with fewer methods
such as io.Reader. So what does the type interface{}, which has no methods at all, tell us about the
concrete types that satisfy it?

That’s right: nothing. This may seem useless, but in fact the type interface{}, which is called the
empty interface type, is indispensable. Because the empty interface type places no demands on the
types that satisfy it, we can *assign any value to the empty interface*.

Of course, having created an interface{} value containing a boolean, float, string, map, pointer,
or any other type, we can do nothing directly to the value it holds since the interface has no methods.
We need a way to get the value back out again. We’ll see how to do that using a *type assertion* in
Section 7.10.

Each grouping of concrete types based on their shared behaviors can be expressed as an interface type.
Unlike class-based languages, in which the set of interfaces satisfied by a class is explicit, in Go
we can define new abstractions or groupings of interest when we need them, without modifying the
declaration of the concrete type. This is particularly useful when the concrete type comes from a
package written by a different author. Of course, there do need to be underlying commonalities in
the concrete types.
