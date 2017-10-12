#### 1 Tutorial
##### 1.3. 
Printf has over a dozen such conversions, which Go programmers call verbs. This table is far
from a complete specification but illustrates many of the features that are available:
```sh
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
##### 1.7. A web server
The server has two handlers, and the request URL determines which one is called: a request
for /count invokes counter and all others invoke handler. A handler pattern that ends with
a slash matches any URL that has the pattern as aprefix. Behind the scenes, the server runs
the handler for each incoming request in a separate goroutine so that it can serve multiple
requests simultaneously.
##### 1.8. Loose Ends
Cases do not fall through from one to thenext as in C-like languages (though there is a rarely 
used **fallthrough** statement that overrides this behavior).
A switch does not need an operand; it can just list the cases, each of which is a boolean
expression: This form is called a **tagless switch**; it’s equivalent to switch true.
#### 2 Program Structure
##### 2.2. Declerations
There are 4 major kinds of declarations: *var, const, type and func*.
##### 2.3. Variables
A *var* declaration creates a variable of a particular type, attached a name to it, and sets its
initial value. Each declaration has the general form *var name type = expression*.
###### 2.3.1. Short variable declaration
*name := expression*
Keep in mind that *:=* is a declaration and *=* is an assignment.
A short variable declaration does not necessarily *declare* all the variables on its left hand side. If some
of them were already declared in the same lexical block, then the short variable decleration acts like an
*assignment* to those variables. A short variable declaration must declare at least one new variable.
###### 2.3.2. Pointers
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

###### 2.3.3. The new Function
Another way to create a variable is to use the built-in function *new*. The expression **new(T)** creates an
*unnamed variable*  of type T, initializes it to zero values of T, and returns its address, which is a value
of type *\*T*. Each call to new returns a distinct variable with a unique address.
Since *new* is a predeclared function, and **not a keyword**, it is possible to **redefine** the name for
something else within a function.

###### 2.3.4. Lifetime of a variable
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

##### 2.5. Type Declarations
A **type** declaration defines a new *named type* that has the same *underlying type* as an existing type.
The named type provides a way to separate different and perhaps incompatible uses of the underlying type 
so that they cannot be mixed unintentionally.
```go
type name <underlying-type>
```
```go
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

###### 2.6.2. Package Initialization
If the package has multiple .go files, they are initialized in the order in which the files are given to the compiler.
The go tool sorts the .go files by name before invoking the compiler.
```go
func init() { /* ... */ }
```
Such **init()** functions can't be called or referenced, but otherwise they are normal functions. Within each file,
**init** functions are automatically executed when the program starts, in the order in which they are declared.

##### 2.7. Scope
Don't confuse scope with lifetime. The scope of the declaration is a region of the program text; it is a compile time
property. The lifetime of a variable is the range of time during execution when the variable can be referred to by other
parts of the program. It is a run time property.

#### 3 Basic Data Types
Go types fall into **4 categories**: *basic types, aggregate types, reference types and interface types*.
**Basic** types like numbers, strings, booleans
**Aggregate** types like arrays and structs
**Reference** types includes pointers, slices, maps, functions, channels
**Interface** types which are abstract types. The above 3 are concrete types.
##### 3.1. Integers
* *int* is by far the most used integer type which is signed integer.
* *rune* is a synonym for **int32** and indicates a value is a Unicode code point.
* Similarly *byte* is a synonym for uint8
* *uintptr* is sufficient to hold all bits of a pointer value used only for low level programming.
Built-in **len** function returns a signed int so that it can be used in the loops.
Octal numbers seem to be used for exactly one purpose - file permissions on the POSIX systems.

###### 3.5.3. UTF-8
* `0xxxxxxx                             runes 0-127    (ASCII)`
* `110xxxxx 10xxxxxx                    128-2047`
* `1110xxxx 10xxxxxx 10xxxxxx           2048-65535`
* `11110xxx 10xxxxxx 10xxxxxx 10xxxxxx  65536 - 0x10ffff`

If there are unicode string, then do not use the `len` of the string, but `utf8.RUneCountInString()`
UTF-8 is exceptionally convinient as an interchange format, but within a program runes may be more convinient 
because they are of uniform size and this easily indexes in arrays and slices.

#### 4 Composite Types
##### 4.1. Arrays
An **array** is a *fixed length* sequence of zero or more elements of a particular type. **Slices**, which can grow and 
shrink, are much more versatile. In an array literal, if an ellipsis "..." appears in place of the length, the array
length is determined by the number of initializers. ```q := [...]int{1, 2, 3}``` has 3 integers. The size of an array
is part of its type, so ```[3]int``` and ```[4]int``` are different types. In this form, indices can appear in any order
and some may be omitted and unspecified values take on the zero value for the element type. For instance, 
```r := [...]int{99: 01}``` defines an array of 100 elements, all zero except for the last, which has the value -1.

When a function is called, a copy of each argument value is assigned to the corresponding parameter variable, so
the *function receives a copy, not the original*. Go treats arrays like any other type, but this behavior is
*different* from other languages that implicitly pass *arrays by reference*.

##### 4.2. Slices
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

###### 4.2.1. The Append function
Usually we do not know whether a given call to built-in *append* will cause the reallocation, so we
 can't assume that the original slice refers to the resulting slice. Hence
 ``` runes = append(runes, r)```
 The ellipsis "..." in the declaration of the *appendInt* makes the function *variadic*. It accepts any number of 
 final arguments. ```func appendInt(x []int, y ...int) []int```
 
##### 4.3. Maps
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

```go var graph = make(map[from]map[to]bool)```

##### 4.4. Structs
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

###### 4.4.3. Struct Embedding and Anonymous Fields
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


##### 4.5. JSON
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

##### 4.6. Text and HTML Templates
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
##### 5.1. Function Declarations
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

##### 5.2. Recursion
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

##### 5.3. Multiple Return Values
In a function with named results, the operands of a return statement may be omitted. This is
called a *bare return*. In functions like this one, with many return statements and several
results, bare returns can reduce code duplication, but rarely make the code easier to
understand.
##### 5.4. Errors
Go’s approach sets it apart from many other languages in which failures are reported using 
*exceptions*, not ordinary values. Although Go does have an exception mechanism of sorts, 
as we will see in Section 5.9, it is used only for reporting truly unexpected errors that 
indicate a bug, not the routine errors that a robust program should be built to expect.

Go programs use ordinary control-flow mechanisms like if and return to respond to errors.
This style undeniably demands that more attention be paid to error-han- dling logic, but 
that is precisely the point.
###### 5.4.1. Error-Handling Strategies
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

##### 5.5. Function Values
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

##### 5.6. Anonymous Functions
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

###### 5.6.1. Caveat: Capturing Iteration Variables
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

##### 5.7. Variadic Functions
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

##### 5.8. Deferred Function Calls
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

##### 5.9. Panic
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

##### 5.10. Recover
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

##### 6.1. Method Declarations
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

##### 6.2. Methods with a Pointer Receiver
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

##### 6.3. Composing Types by Struct Embedding
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
##### 6.4. Method Values and Expressions
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

##### 6.5. Example: Bit Vector Type
Sets in Go are usually implemented as a *map[T]bool*, where T is the element type. A set represented
by a map is very flexible but, for certain problems, a specialized representation may outperform it.
For example, in domains such as dataflow analysis where set elements are small non-negative integers,
sets have many elements, and set operations like union and intersection are common, a *bit vector* is ideal.

##### 6.6. Encapsulation
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
##### 7.1. Interfaces as Contracts
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
##### 7.2. Interface Types
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

##### 7.3. Interface Satisfaction
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

##### 7.4. Parsing Flags with flag.Value
We’ll see how another standard interface, *flag.Value*, helps us define new notations for
command-line flags.
```go
    var period = flag.Duration("period", 1*time.Second, "sleep period")
     func main() {
         flag.Parse()
         fmt.Printf("Sleeping for %v...", *period)
         time.Sleep(*period)
         fmt.Println()
}
```
The flag.Duration function creates a flag variable of type time.Duration and allows the user
to specify the duration in a variety of user-friendly formats, including the same notation
printed by the **String** method. 
```go
    package flag
     // Value is the interface to the value stored in a flag.
     type Value interface {
         String() string
         Set(string) error
}
```
The *String* method formats the flag’s value for use in command-line help messages; thus every
*flag.Value* is also a *fmt.Stringer*. The *Set* method parses its string argument and updates
the flag value. In effect, the *Set* method is the inverse of the String method, and it is good
practice for them to use the same notation.

##### 7.5. Interface Values
Conceptually, a *value* of an *interface type*, or *interface value*, has two components,
a *concrete type* and a *value of that type*. These are called the interface’s *dynamic type*
and *dynamic value*.

For a statically typed language like Go, *types are a compile-time concept*, so a *type is not
a value*.

In the four statements below, the variable w takes on three different values. (The initial
and final values are the same.)

```go
    var w io.Writer
     w = os.Stdout
     w = new(bytes.Buffer)
     w = nil
```
```go
    var w io.Writer
    var <Interface Value> <Interface Type>
    w is Interface Value
    io.Write is Interface Type
```
In Go, variables are always initialized to a well-defined value, and interfaces are no exception.
The *zero value* for an interface has both its type and value components set to *nil*.

|                   |   w               |              |                    |
|-------------------|:------------------|--------------|------------------- |
| Dynamic Type      |   nil             |              |                    |
| Dynamic Value     |   nil             |              |                    |

                      A nil Interface Value

An interface value is described as nil or non-nil based on its dynamic type,
so this is a nil interface value.

```go
    w = os.Stdout
```

|                   |   w               |              |                    |
|-------------------|:------------------|--------------|--------------------|
| Dynamic Type      |   *os.File        |              |  os.File           |
| Dynamic Value     |          -------> | ---------->  |  fd int=1 (stdout) |

                      An Interface value containing an *os.File pointer

The interface value’s *dynamic type* is set to the type descriptor for the pointer
type *\*os.File*, and its *dynamic value* holds a *copy of os.Stdout*, which is a
pointer to the os.File variable representing the standard output of the process. 

In general, we cannot know at compile time what the *dynamic type* of an interface
value will be, so a call through an interface must use *dynamic dispatch*. Instead
of a direct call, the compiler must generate code to obtain the address of the
method named Write from the type descriptor, then make an indirect call to that
address. 

```go
    w = new(bytes.Buffer)
```

|                   |   w               |              |                    |
|-------------------|:------------------|--------------|--------------------|
| Dynamic Type      |   *bytes.Buffer   |              |  bytes.Buffer      |
| Dynamic Value     |          -------> | ---------->  |  data []byte       |

                      An Interface value containing an *bytes.Buffer pointer

An *interface value* can hold arbitrarily large dynamic values.

Two *interface values are equal* if both are nil, or if their dynamic types are
identical and their dynamic values are equal according to the usual behavior
of == for that type. Because *interface values are comparable*, they may be used
as the keys of a map or as the operand of a switch statement.

However, if two interface values are compared and have the same dynamic type,
but that type is not comparable (a slice, for instance), then the comparison
fails with a panic.

###### 7.5.1. Caveat: An Interface Containing a Nil Pointer Is Non-Nil
**A nil interface value, which contains no value at all, is not the same as
an interface value containing a pointer that happens to be nil.**

|                   |   w               |              |                    |
|-------------------|:------------------|--------------|------------------- |
| Dynamic Type      |   *bytes.Buffer   |              |  not nil           |
| Dynamic Value     |   nil             |              |                    |

                      A non-nil Interface containing a nil pointer

##### 7.6. Sorting with sort.Interface
Go’s *sort.Sort* function assumes nothing about the representation of either
the sequence or its elements.

```go
     package sort
     type Interface interface {
         Len() int
         Less(i, j int) bool // i, j are indices of sequence elements
         Swap(i, j int)
}
```

```go
     type StringSlice []string
     func (p StringSlice) Len() int           { return len(p) }
     func (p StringSlice) Less(i, j int) bool { return p[i] < p[j] }
     func (p StringSlice) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }
     sort.Sort(StringSlice(names))
     sort.Strings(names)                  # In-build function in sort
```

```go
     package sort
     type reverse struct{ Interface } // that is, sort.Interface
     func (r reverse) Less(i, j int) bool { return r.Interface.Less(j, i) }
     func Reverse(data Interface) Interface { return reverse{data} }
```
**Len** and **Swap**, the other two methods of **reverse**, are implicitly provided
by the original *sort.Interface* value because it is an embedded field. The exported
function *Reverse* returns an instance of the reverse type that contains the
original *sort.Interface* value.

##### 7.7. The http.Handler Interface

```go 
    # net/http
    package http
     type Handler interface {
         ServeHTTP(w ResponseWriter, r *Request)
}
     func ListenAndServe(address string, h Handler) error
```
The *ListenAndServe* function requires a server address, such as "localhost:8000", and an
instance of the Handler interface to which all requests should be dispatched. It runs forever,
or until the server fails (or fails to start) with an error, always non-nil, which it returns.

net/http provides *ServeMux*, a request multiplexer, to simplify the association between URLs
and handlers. A ServeMux aggregates a collection of http.Handlers into a single http.Handler.
Again, we see that different types satisfying the same interface are *substitutable*: the web
server can dispatch requests to any http.Handler, regardless of which concrete type is behind
it.

```go
     func main() {
         db := database{"shoes": 50, "socks": 5}
         mux := http.NewServeMux()
         mux.Handle("/list", http.HandlerFunc(db.list))
         mux.Handle("/price", http.HandlerFunc(db.price))
         log.Fatal(http.ListenAndServe("localhost:8000", mux))
     }
     type database map[string]dollars
     func (db database) list(w http.ResponseWriter, req *http.Request) {
         for item, price := range db {
             fmt.Fprintf(w, "%s: %s\n", item, price)
         }
     }
     func (db database) price(w http.ResponseWriter, req *http.Request) {
         item := req.URL.Query().Get("item")
         price, ok := db[item]
         if !ok {
            w.WriteHeader(http.StatusNotFound) // 404
            fmt.Fprintf(w, "no such item: %q\n", item)
            return
         }
        fmt.Fprintf(w, "%s\n", price)
     }
```

The expression *http.HandlerFunc(db.list)* is a **conversion, not a function call**, since
http.HandlerFunc is a type. It has the following definition:
```go
net/http
    package http
     type HandlerFunc func(w ResponseWriter, r *Request)
     func (f HandlerFunc) ServeHTTP(w ResponseWriter, r *Request) {
         f(w, r)
    }
```
**HandlerFunc** demonstrates some unusual features of Go’s interface mechanism. It is a
*function type* that has methods and *satisfies an interface, http.Handler*. The behavior of
its *ServeHTTP* method is to call the underlying function. *HandlerFunc* is thus an adapter that
lets a *function value satisfy an interface*, where the *function and the interface’s sole method
have the same signature*. In effect, this trick lets a single type such as database satisfy
the http.Handler interface several different ways: once through its list method, once through
its price method, and so on.

Another way to start the mux is:
```go

     func main() {
         db := database{"shoes": 50, "socks": 5}
         http.HandleFunc("/list", db.list)
         http.HandleFunc("/price", db.price)
         log.Fatal(http.ListenAndServe("localhost:8000", nil))
     }
```
Finally, an important reminder: as we mentioned in Section 1.7, the web server invokes *each
handler in a new goroutine*, so handlers must take precautions such as locking when accessing
variables that other goroutines, including other requests to the same handler, may be accessing.

##### 7.8. The error Interface
```go
    type error interface {
         Error() string
    }
```
```go
     package errors
     func New(text string) error { return &errorString{text} }
     type errorString struct { text string }
     func (e *errorString) Error() string { return e.text }
```
The underlying type of *errorString is a struct, not a string*, to protect its representation
from inadvertent (or premeditated) updates. And the reason that the *pointer type
\*errorString*, not errorString alone, satisfies the error interface is so that every call
to New allocates a distinct error instance that is equal to no other. We would not want a
distinguished error such as io.EOF to compare equal to one that merely happened to have the
same message.
```go
     fmt.Println(errors.New("EOF") == errors.New("EOF")) // "false"
```
##### 7.9. Example: Expression Evaluator

##### 7.10. Type Assertions
A *type assertion* is an operation applied to an interface value. Syntactically, it looks
like *x.(T)*, where x is an expression of an interface type and T is a type, called the 
*‘‘asserted’’* type. A **type assertion checks that the dynamic type of its operand matches
the asserted type**.

There are two possibilities.

First, if the asserted type T is a concrete type, then the type assertion checks whether
*x’s dynamic type is identical to T*. If this check succeeds, the *result of the type
assertion is x’s dynamic value, whose type is of course T*. In other words, **a type
assertion to a concrete type extracts the concrete value from its operand**. If the
check fails, then the operation panics.
 
Second, if instead the asserted type T is an interface type, then the type assertion checks
whether x’s dynamic type satisfies T. If this check succeeds, the dynamic value is not extracted;
the result is still an interface value with the same type and value components, but the result
has the interface type T. In other words, **a type assertion to an interface type changes the type
of the expression, making a different (and usually larger) set of methods accessible, but it
preserves the dynamic type and value components inside the interface value**.

If the type assertion appears in an assignment in which two results are expected, such as the
following declarations, the operation does not panic on failure but instead returns an additional
second result, a boolean indicating success:
```go
     var w io.Writer = os.Stdout
     f, ok := w.(*os.File)      // success:  ok, f == os.Stdout
     b, ok := w.(*bytes.Buffer) // failure: !ok, b == nil
```
##### 7.11. Discriminating Errors with Type Assertions
##### 7.12. Querying Behaviors with Interface Type Assertions
The *io.Writer* interface tells us only one fact about the concrete type that w holds: that bytes may be
written to it. If we look behind the curtains of the net/http package, we see that the dynamic type that
w holds in this program also has a *WriteString* method that allows strings to be efficiently written to it,
avoiding the need to allocate a temporary copy. (This may seem like a shot in the dark, but a number of
important types that satisfy io.Writer also have a WriteString method, including *bytes.Buffer, *os.File
and *bufio.Writer.)

##### 7.13. Type Switches
Interfaces are used in **two** distinct styles. In the *first style*, exemplified by io.Reader, io.Writer,
fmt.Stringer, sort.Interface, http.Handler, and error, an interface’s methods express the similarities of
the concrete types that satisfy the interface but hide the representation details and intrinsic operations
of those concrete types. The emphasis is on the methods, not on the concrete types.

The *second* style exploits the ability of an interface value to hold values of a variety of concrete types
and *considers the interface to be the union of those types*. Type assertions are used to discriminate among
these types dynamically and treat each case differently. In this style, the emphasis is on the concrete types
that satisfy the interface, not on the interface’s methods (if indeed it has any), and there is no hiding of
information. We’ll describe interfaces used this way as **discriminated unions**.

In its simplest form, a *type switch* looks like an ordinary switch statement in which the operand
is x.(type)—that’s literally the keyword type—and each case has one or more types. A type switch enables
a multi-way branch based on the interface value’s dynamic type. The nil case matches if x == nil, and the
default case matches if no other case does. A type switch for sqlQuote would have these cases:
```go
     switch x.(type) {
     case nil:       // ...
     case int, uint: // ...
     case bool:      // ...
     case string:    // ...
     default:        // ...
    }
```
As with an ordinary switch statement (§1.8), cases are considered in order and, when a match is found, the
case’s body is executed. Case order becomes significant when one or more case types are interfaces, since then
there is a possibility of two cases matching. The position of the default case relative to the others is immaterial. 
*No fall through is allowed*.

Since this is typical, the *type switch* statement has an extended form that binds the extracted value to a new 
variable within each case:
```go
     switch x := x.(type) { /* ... */ }
```
Although the *type of x is interface{}*, we consider it a *discriminated union of int, uint, bool, string, and nil*.

#### 8 Goroutines and Channels
Go enables two styles of concurrent programming. This chapter presents *goroutines* and *channels*, which support
*communicating sequential processes* or CSP, a model of concurrency in which *values are passed between independent
activities (goroutines)* but variables are for the most part confined to a single activity. Chapter 9 covers some
aspects of the more traditional model of *shared memory multithreading*, which will be familiar if you’ve used
threads in other mainstream languages.

##### 8.1. Goroutines
In Go, each concurrently executing activity is called a *goroutine*.

```go

     func spinner(delay time.Duration) {
         for {
            for _, r := range `-\|/` {
                fmt.Printf("\r%c", r) // \r means carriage return
                time.Sleep(delay)
            }
         }
     }
```
##### 8.2. Example: Consurrent Clock Server
```go

     func main() {
         listener, err := net.Listen("tcp", "localhost:8000")
         if err != nil {
             log.Fatal(err)
         }
        for {
            conn, err := listener.Accept()
            if err != nil {
                log.Print(err) // e.g., connection aborted
                continue
            }
        }
     }
```
The listener’s *Accept* method blocks until an incoming connection request is made, then returns a *net.Conn*
object representing the connection.

##### 8.4. Channels
If *goroutines are the activities of a concurrent* Go program, *channels are the connections between* them.
A channel is a communication mechanism that *lets one goroutine send values to another goroutine*. Each channel
is a conduit for values of a particular type, called the channel’s element type. The type of a channel whose
elements have type int is written chan int.

To create a channel, we use the built-in make function:
```go
    ch := make(chan int) // ch has type 'chan int'
```
As with maps, a channel is a *reference* to the data structure created by make. When we copy a channel or pass
one as an argument to a function, we are copying a reference, so caller and callee refer to the same data
structure. As with other reference types, the zero value of a channel is nil.

Two *channels of the same type may be compared using ==*. The comparison is true if both are references to the
same channel data structure. A channel may also be compared to nil.

A channel has two principal operations, *send and receive*, collectively known as communications.
```go
     ch <- x   // a send statement
     x = <-ch  // a receive expression in an assignment statement
     <-ch      // a receive statement; result is discarded
     close(ch) // close the channel 
```
Channels support a *third operation, close*, which sets a flag indicating that no more values will ever be
sent on this channel; subsequent attempts to send will panic. 

A channel created with a simple call to make is called an *unbuffered channel*, but make accepts an optional
second argument, an *integer called the channel’s capacity*. If the capacity is non-zero, make creates a
buffered channel.

```go
     ch = make(chan int)    // unbuffered channel or synchronous channel
     ch = make(chan int, 0) // unbuffered channel
     ch = make(chan int, 3) // buffered channel with capacity 3
```

###### 8.4.1. Unbuffered Channels
Messages sent over channels have *two important aspects*. Each message has a value, but sometimes the fact of
communication and the moment at which it occurs are just as important. We call *messages events* when we wish to
stress this aspect. When the event carries no additional information, that is, its sole purpose is
synchronization, we’ll emphasize this by using a channel whose element type is *struct{}*, though it’s common
to use a *channel of bool or int* for the same purpose.

###### 8.4.2. Pipelines
Channels can be used to connect goroutines together so that the output of one is the input to another. This is
called a *pipeline*.

If the sender knows that no further values will ever be sent on a channel, it is useful to communicate this
fact to the receiver goroutines so that they can stop waiting. This is accomplished by closing the channel
using the built-in close function.

After the closed channel has been *drained*, that is, after the last sent element has been received, all
subsequent receive operations will proceed without blocking but will yield a zero value.

###### 8.4.3. Unidirectional Channel Types
Go type system provides *unidirectional channel* types that expose only one or the other of the send and
receive operations.
```go
    chan<- int   // a send-only channel of int
    <-chan int   // a receive-only channel of int
```

###### 8.4.4. Buffered Channels
A buffered channel has a queue of elements. The queue’s maximum size is determined when it is created,
by the capacity argument to make.

A send operation on a buffered channel inserts an element at the back of the queue, and a receive operation
removes an element from the front. If the channel is full, the send operation blocks its goroutine until
space is made available by another goroutine’s receive. Conversely, if the channel is empty, a receive
operation blocks until a value is sent by another goroutine.

Novices are sometimes tempted to use buffered channels within a single goroutine as a queue, lured by
their pleasingly simple syntax, but this is a mistake. Channels are deeply connected to goroutine scheduling,
and without another goroutine receiving from the channel, a sender—and perhaps the whole program risks
becoming blocked forever. If all you need is a simple queue, make one using a slice.

Unlike garbage variables, *leaked goroutines are not automatically collected*, so it is important to make
sure that goroutines terminate themselves when no longer needed.

##### 8.5. Looping in Parallel
This demands a special kind of counter, one that can be safely manipulated from multiple goroutines and
that provides a way to wait until it becomes zero. This counter type is known as **sync.WaitGroup**,
and the code below shows how to use it:
```go
    var wg sync.WaitGroup // number of working goroutines
    wg.Add(1)
    go func(f string) {
        defer wg.Done()
    }
    wg.Wait()
```
Note the asymmetry in the *Add* and *Done* methods. *Add*, which increments the counter, must be called
before the worker goroutine starts, not within it; otherwise we would not be sure that the 
Add happens before the ‘‘closer’’ goroutine calls *Wait*. Also, Add takes a parameter, but Done does not;
it’s equivalent to Add(-1). We use defer to ensure that the counter is decremented even in the error case.

##### 8.6. Example: Concurrent Web Crawler
If you open thousands of goroutines for each method it is never good.

The program is *too* parallel. *Unbounded parallelism* is rarely a good idea since there is always a limiting
factor in the system, such as the number of CPU cores for compute-bound workloads, the number of spindles
and heads for local disk I/O operations, the bandwidth of the network for streaming downloads, or the serving
capacity of a web service. The solution is to limit the number of parallel uses of the resource to match the
level of parallelism that is available. A simple way to do that in our example is to ensure that no more than
*n calls* to goroutines are active at once, where n is comfortably less than the file descriptor limit—20, say.
This is analogous to the way a doorman at a crowded nightclub admits a guest only when some other guest leaves.

We can limit parallelism using a buffered channel of capacity n to model a concurrency primitive called
a *counting semaphore*.

```go
     // tokens is a counting semaphore used to
     // enforce a limit of 20 concurrent requests.
     var tokens = make(chan struct{}, 20)
     func crawl(url string) []string {
         fmt.Println(url)
         tokens <- struct{}{} // acquire a token
         list, err := links.Extract(url)
         <-tokens // release the token
    }
```

##### 8.7. Multiplexing with Select
If we need to multiplex between different channels, we can use the *select* statement to do so.
```go
     select {
     case <-ch1:
         // drop from ch1 ...
     case x := <-ch2:
         // ...use x...
     case ch3 <- y:
         // send y on ch3 ...
     default:
 }
```
Each case specifies a *communication* (a send or receive operation on some channel) and an associated
block of statements.

A *select* waits until a communication for some case is ready to proceed. It then performs that communication
and executes the case’s associated statements; the other communications do not happen. A select with no
cases, select{}, waits forever.

The select statement below waits until the first of two events arrives, either an abort event or the event
indicating that 10 seconds have elapsed. If 10 seconds go by with no abort, the launch proceeds.
```go
     func main() {
         // ...create abort channel...
        fmt.Println("Commencing countdown.  Press return to abort.")
        select {
        case <-time.After(10 * time.Second):
            // Do nothing.
        case <-abort:
            fmt.Println("Launch aborted!")
            return
        }
        launch()
    }
```

##### 8.9. Cancellation
There is no way for one goroutine to terminate another directly, since that would leave all its shared variables
in undefined states. In the rocket launch program (§8.7) we sent a single value on a channel named abort, which
the countdown goroutine interpreted as a request to stop itself. But what if we need to cancel two goroutines,
or an arbitrary number?

First, we create a cancellation channel on which no values are ever sent, but whose closure indicates that it
is time for the program to stop what it is doing. We also define a utility function, cancelled, that checks
or polls the cancellation state at the instant it is called.

```go
     var done = make(chan struct{})
     func cancelled() bool {
         select {
         case <-done:
             return true
         default:
             return false
         }
     }
```

#### 9 Concurrency with Shared Variables
##### 9.1. Race Conditions
When we cannot confidently say that one event happens before the other, then the events x and y are *concurrent*.
A type is concurrency-safe if all its accessible methods and operations are concurrency-safe.

There are many reasons a function might not work when called concurrently, including deadlock, livelock,
and resource starvation. We don’t have space to discuss all of them, so we’ll focus on the most important
one, the *race condition*.

A race condition is a situation in which the program does not give the correct result for some interleavings
of the operations of multiple goroutines.

This is because Alice’s deposit operation A1 is really a sequence of two operations, a read and a write;
call them A1randA1w. Here’s the problematic interleaving:
```
Data race
         0
A1r      0  // ... = balance + amount
B      100
A1w    200  // balance = ...
A2  "= 200"
```
This program contains a particular kind of race condition called a *data race*. A data race occurs whenever
*two goroutines access the same variable concurrently* and *at least one of the accesses is a write*.

It follows from this definition that there are *three ways to avoid a data race*.

The **first way is not to write the variable**. We initialize the map with all necessary entries before
creating additional goroutines and never modify it again, then any number of goroutines may safely call
the variable concurrently since each only reads the value. Data structures that are never modified or are
immutable are inherently concurrency-safe and need no synchronization.

The **second way** to avoid a data race is to **avoid accessing the variable from multiple goroutines**.
These variables are *confined* to a single goroutine. Since other goroutines cannot access the variable
directly, they must use a channel to send the confining goroutine a request to query or update the
variable.

This is what is meant by the Go mantra ‘‘Do not communicate by sharing memory; instead, share memory by
communicating.’’ A goroutine that brokers access to a confined variable using channel requests is called
a *monitor goroutine* for that variable.

The **third way** to avoid a data race is to allow many goroutines to access the variable, but only one
at a time. This approach is known as **mutual exclusion**.

##### 9.2. MutualExclusion:sync.Mutex
A semaphore that counts only to 1 is called a *binary semaphore* or mutex. The *mutex guards the shared
variables*. By convention, the variables guarded by a mutex are declared immediately after the declaration
of the mutex itself.

The region of **code between Lock and Unlock** in which a goroutine is free to read and modify the shared
variables is called a *critical section*.

A defer is marginally more expensive than an explicit call to Unlock, but not enough to justify less
clear code. As always with concurrent programs, favor clarity and resist premature optimization. Where
possible, use defer and let critical sections extend to the end of a function.

There is a good reason Go’s mutexes are not re-entrant. The purpose of a mutex is to ensure that certain
invariants of the shared variables are maintained at critical points during program execution. One of the
invariants is ‘‘no goroutine is accessing the shared variables,’’ but there may be additional invariants
specific to the data structures that the mutex guards. When a goroutine acquires a mutex lock, it may assume
that the invariants hold. While it holds the lock, it may update the shared variables so that the invariants
are temporarily violated. However, when it releases the lock, it must guarantee that order has been restored
and the invariants hold once again. Although a re-entrant mutex would ensure that no other goroutines are
accessing the shared variables, it cannot protect the additional invariants of those variables.

When you use a mutex, make sure that both it and the variables it guards are not exported, whether they
are package-level variables or the fields of a struct.

##### 9.3. Read/WriteMutexes:sync.RWMutex
We need a special kind of lock that allows read-only operations to proceed in parallel with each other, but write
operations to have fully exclusive access. This lock is called a *multiple readers, single writer lock*, and in
Go it’s provided by *sync.RWMutex*:
```go
     var mu sync.RWMutex
     var balance int
     func Balance() int {
         mu.RLock() // readers lock
         defer mu.RUnlock()
         return balance
}
```
*RLock and RUnlock* methods to acquire and release a *readers or shared lock*. Calls the *mu.Lock and mu.Unlock* 
methods to acquire and release a *writer or exclusive lock*. An RWMutex requires more complex internal bookkeeping,
making it slower than a regular mutex for uncontended locks.

##### 9.4. Memory Synchronization
In a modern computer there may be dozens of processors, each with its own local cache of the main memory. For
efficiency, writes to memory are buffered within each processor and flushed out to main memory only when necessary.
They may even be committed to main memory in a different order than they were written by the writing goroutine.
Synchronization primitives like channel communications and mutex operations cause the processor to flush out
and commit all its accumulated writes so that the effects of goroutine execution up to that point are guaranteed
to be visible to goroutines running on other processors.

Within a single goroutine, the effects of each statement are guaranteed to occur in the order of execution;
goroutines are sequentially consistent. But in the absence of explicit synchronization using a channel or mutex,
there is no guarantee that events are seen in the same order by all goroutines.

##### 9.5. LazyInitialization:sync.Once
It is good practice to defer an expensive initialization step until the moment it is needed. Initializing a
variable up front increases the start-up latency of a program and is unnecessary if execution doesn’t always
reach the part of the program that uses that variable. Initializing at the time of first use or call is called
lazy initialization. One can use mutux to sync and performa the lazy initialization. But better is to use
*Sync.Once.Do()* for this.

A **Sync.Once** consists of a mutex and a boolean variable that records whether initialization has taken place;
the mutex guards both the boolean and the client’s data structures. The sole method, Do, accepts the initialization
function as its argument.
```go
     var loadIconsOnce sync.Once
     var icons map[string]image.Image
     // Concurrency-safe.
     func Icon(name string) image.Image {
         loadIconsOnce.Do(loadIcons)
         return icons[name]
}
```
In the first call, in which the variable is false, Do calls loadIcons and sets the variable to true. Subsequent
calls do nothing, but the mutex synchronization ensures that the effects of loadIcons on memory (specifically,
icons) become visible to all goroutines. Using sync.Once in this way, we can avoid sharing variables with other
goroutines until they have been properly constructed.

##### 9.6. The Race Detector
Just add the *-race* flag to your gobuild, go run or go test command.

The race detector studies this stream of events, looking for cases in which one goroutine reads or writes a shared
variable that was most recently written by a different goroutine without an intervening synchronization operation.
This indicates a concurrent access to the shared vari- able, and thus a data race. The tool prints a report that
includes the identity of the variable, and the stacks of active function calls in the reading goroutine and the
writing goroutine. This is usually sufficient to pinpoint the problem.

##### 9.8. Goroutines and Threads
There are a few differences between the green goroutines and OS threads.
###### 9.8.1. Growable Stacks

Each OS thread has a fixed-size block of memory (often as large as 2MB) for its stack, the work area where it
saves the local variables of function calls that are in progress or temporarily suspended while another function
is called. This fixed-size stack is simultaneously too much and too little.

In contrast, a goroutine starts life with a small stack, typically 2KB. A goroutine’s stack, like the stack of an
OS thread, holds the local variables of active and suspended function calls, but unlike an OS thread, a goroutine’s
stack is not fixed; it grows and shrinks as needed. The size limit for a goroutine stack may be as much as 1GB.

###### 9.8.3 Goroutine Scheduling
OS threads are scheduled by the OS kernel. Every few milliseconds, a hardware timer inter- rupts the processor,
which causes a kernel function called the scheduler to be invoked. This function suspends the currently executing
thread and saves its registers in memory, looks over the list of threads and decides which one should run next,
restores that thread’s registers from memory, then resumes the execution of that thread. Because OS threads are
scheduled by the kernel, passing control from one thread to another requires a full context switch, that is,
saving the state of one user thread to memory, restoring the state of another, and updating the scheduler’s data
structures. This operation is slow, due to its poor locality and the number of memory accesses required, and has
historically only gotten worse as the number of CPU cycles required to access memory has increased.

The Go runtime contains its own scheduler that uses a technique known as m:n scheduling, because it multiplexes
(or schedules) m goroutines on n OS threads.

Unlike the operating system’s thread scheduler, the Go scheduler is not invoked periodically by a hardware timer,
but implicitly by certain Go language constructs. For example, when a goroutine calls time.Sleep or blocks in a
channel or mutex operation, the scheduler puts it to sleep and runs another goroutine until it is time to wake
the first one up.


###### 9.8.3. GOMAXPROCS
The Go scheduler uses a parameter called GOMAXPROCS to determine how many OS threads may be actively executing Go
code simultaneously. Its default value is the number of CPUs on the machine, so on a machine with 8 CPUs, the
scheduler will schedule Go code on up to 8 OS threads at once. (GOMAXPROCS is the n in m:n scheduling.)

You can explicitly control this parameter using the *GOMAXPROCS environment variable* or the *runtime.GOMAXPROCS* function.

###### 9.8.4. Goroutines Have No Identity
Goroutines have no notion of identity that is accessible to the programmer. This is by design, since thread-local
storage tends to be abused.

#### 10. Packages and the Go Tool
##### 10.1. Introduction
Packages also provide *encapsulation* by controlling which names are visible or exported outside the package.
Restricting the visibility of package members hides the helper functions and types behind the package’s API,
allowing the package maintainer to change the implemen- tation with confidence that no code outside the package
will be affected. Restricting visibility also hides variables so that clients can access and update them only
through exported functions that preserve internal invariants or enforce mutual exclusion in a concurrent program.

Go *compilation is notably faster* than most other compiled languages, even when building from scratch.
There are *three main reasons for the compiler’s speed*. **First**, all imports must be explicitly listed at the
beginning of each source file, so the compiler does not have to read and process an entire file to determine its
dependencies. **Second**, the dependencies of a package form a directed acyclic graph, and because there are no
cycles, packages can be compiled separately and perhaps in parallel. **Finally**, the object file for a compiled
Go package records export information not just for the package itself, but for its dependencies too. When
compiling a package, the compiler must read one object file for each import but need not look beyond these files.

##### 10.5. Blank Imports
It is an error to import a package into a file but not refer to the name it defines within that file. However,
on occasion we must import a package merely for the side effects of doing so: *evaluation of the initializer*
expressions of its package-level variables and *execution of its init functions*.

```go
package main

import "fmt"

var WhatIsThe = AnswerToLife()

func AnswerToLife() int {
	return 43
}

func init() {
	WhatIsThe = 0
}

func main() {
	if WhatIsThe == 0 {
		fmt.Println("It's all a lie.")
	}
}
```
*AnswerToLife()* is guaranteed to run before *init()* is called, and *init()* is guaranteed to run before *main()* is called.
Keep in mind that init() is always called, regardless if there's main or not, so if you import a package that has an
init function, it will be executed.
Also, keep in mind that you can have multiple init() functions per package, they will be executed in the order they
show up in the code (after all variables are initialized of course).

##### 10.7. The Go Tool
The go tool combines package manager (analogous to apt or rpm), build system and  test driver.

###### 10.7.1. Workspace Organization
The only configuration most users ever need is the **GOPATH environment variable**, which specifies the root of the workspace.
GOPATH has three subdirectories: src, pkg and bin.

The **go env** command prints the effective values of the environment variables relevant to the toolchain, including
the default values for the missing ones.

###### 10.7.2. Downloading Packages
```go get ...``` If you specify the **-u** flag, go get will ensure that all packages it visits, including dependencies,
are updated to their latest version before being built and installed.

###### 10.7.3. Building Packages
The **go build** command builds the requested package and all its dependencies, then throws away all the compiled code
except the final executable, if any.

The **go install** command is very similar to go build, except that it saves the compiled code for each package and
command instead of throwing it away.

###### 10.7.4. Documenting Packages
```godoc -http :8000```
Its **-analysis=type** and **-analysis=pointer** flags augment the documentation and the source code with the
results of advanced static analysis.

#### 11. Testing
##### 11.1. The go test Tool
```go test```. A *test function*, which is a function whose name begins with *Test*, exercises some program logic
for correct behavior; go test calls the test function and reports the result, which is either PASS or FAIL. A
*benchmark function* has a name beginning with *Benchmark* and measures the performance of some operation; go
test reports the mean execution time of the operation. And an *example function*, whose name starts with *Example*,
provides machine-checked documentation.

##### 11.2. Test Functions
```go test -v -run="French|Canal"```
##### 11.3. Coverage
```go test -v -run=Coverage ./...``` and ```go tool cover```. ```go test -cover``` will give more details about coverage.

##### 11.4. Benchmark Functions
Benchmark prefix and a ```*testing.B``` parameter. ```go test -bench=.``` will run all the benchmark tests. The 
benchmark tests are not run by default.

The -benchmem command-line flag will include memory allocation statistics in its report. 
```go test -bench=. -benchmem```

##### 11.6. Example Functions
The third kind of function treated specially by go test is an example function, one whose name starts with Example.
It has neither parameters nor results.

Example functions serve **three** purposes. The *primary* one is documentation: a good example can be a more succinct
or intuitive way to convey the behavior of a library function than its prose description.
The *second* purpose is that examples are executable tests run by go test.
The *third* purpose of an example is hands-on experimentation. The godoc server at golang.org uses the Go Playground
to let the user edit and run each example function from within a web browser

#### 12. Reflection
Go provides a mechanism to update variables and inspect their values at run time, to call their methods, and to apply
the operations intrinsic to their representation, all without knowing their types at compile time. This mechanism is
called *reflection*. Reflection also lets us treat types themselves as first-class values.





#### Misc docs:
https://dzone.com/articles/so-you-wanna-go-fast is a good site.
